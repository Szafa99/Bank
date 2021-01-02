#include "headers/form.h"
void Form::setForm(const QVariantMap &formcell,Action_on_cell action)
{

    QString key=formcell.firstKey();

    if(registergui!=NULL){

        QQuickItem *cell = registergui->findChild<QQuickItem*>(key) ;
        lastcell=cell;


        switch (action) {
        case Action_on_cell::Data_changed:
        {
            if(formcell[key].isNull())return;
            mform[key]=formcell[key];

            if( mform[key].isNull() || mform[key]==key)
            {
                mform_edited[key]=false;
                emit form_editedChanged();
            }
            else
            {
                mform_edited[key]=true;
                emit form_editedChanged();
            }

            if(key=="BirthDay")
                qDebug()<<mform[key];
        }
            break;
        case Action_on_cell::Clicked:
        {
            cell->setProperty("color","black");
            cell->setFocus(true);

            if(mform_edited[key] == false )
            {
                cell->setProperty("text","");
                mform[key].clear();
                emit formChanged();
            }

        }
            break;
        case Action_on_cell::Editing_Finished:
        {

            cell->setProperty("color","grey");

            if(mform[key].isNull() || mform[key]=="")
            {
                cell->setProperty("text",key);
                mform[key]=key;
                emit formChanged();
            }
            if(!merrorinfo.isEmpty())
                validet_input();
        }
            break;


        default: qCritical()<<"Action enum on cell "<<key<<" not defined";
            break;
        }
    }
}

void Form::update()
{
    if(lastcell!=NULL)
    {
        QVariantMap cell;
        cell.insert(lastcell->objectName(),"");
        setForm( cell,Action_on_cell::Editing_Finished);
    }
}


 void Form::setroot(QObject *engineroot)
{
    registergui=engineroot;
}


QVariant Form::get_form_cell(QString key)
{
    return mform[key];
}


QVariant Form::get_error_info()
{
    if(merrorinfo.empty())
        return "";
    else return merrorinfo.last();
}


void Form::validet_input()
{

   merrorinfo.clear();
    emit error_infoChanged();

    for(auto i = mform.begin();i!=mform.end();i++) {
        QQuickItem *cell= registergui->findChild<QQuickItem*>(i.key());

        if(cell)
        {
                if( i.key()==i.value() ) // checking if data was inserted
                {

                    cell->parentItem()->setProperty("bordercolor","red");
                    merrorinfo.insert(i.key(),"Type your "+i.key()+" in");
                    emit error_infoChanged();
                }
                else cell->parentItem()->setProperty("bordercolor","lightgrey");

            }
    }

}
