#include "../headers/register.h"



Register::Register(QObject *parent):
    QObject(parent)
{
    mform.insert("FirstName", "FirstName" );
    mform_edited.insert("FirstName", false );

    mform.insert("SecondName","SecondName");
    mform_edited.insert("SecondName",false);

    mform.insert("Email","Email");
    mform_edited.insert("Email",false);

    mform.insert("Pesel","Pesel");
    mform_edited.insert("Pesel",false);

    mform.insert("BirthPlace","BirthPlace");
    mform_edited.insert("BirthPlace",false);

    mform.insert("CitizenShip","CitizenShip");
    mform_edited.insert("CitizenShip",false);

    mform.insert("MotherName","MotherName");
    mform_edited.insert("MotherName",false);


}

void Register::setForm(const QVariantMap &formcell,Action_on_cell action)
{

    QString key=formcell.firstKey();
    qDebug()<<"cell:firstname  "<<"  value  "<<mform["FirstName"];

    if(registergui!=NULL){
        QQuickItem *cell =  registergui->findChild<QQuickItem*>(key) ;



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

          //  qDebug()<<mform[key] ;
        }
            break;
        case Action_on_cell::Clicked:
        {
            if(cell)
            {
                int fontsize = cell->property("font.pixelSize").toInt() ;


                cell->setProperty("color","black");
                cell->setProperty("font.pixelSize",fontsize + 2);
                cell->setFocus(true);

            }
            else qCritical()<<"Couldn't change property";

            if(mform_edited[key] == false ){
                cell->setProperty("text","");
                mform[key].clear();
                emit formChanged();
            }

        }
            break;
        case Action_on_cell::Editing_Finished:
        {

            int fontsize = cell->property("font.pixelSize").toInt() ;
            cell->setProperty("color","grey");
            cell->setProperty("font.pixelSize",fontsize - 2);

            if(mform[key].isNull() || mform[key]=="")
            {
                cell->setProperty("text",key);
                mform[key]=key;
                emit formChanged();
            }
        }
            break;
        default: qCritical()<<"Action enum on cell "<<key<<" not defined";
            break;
        }
    }
}


QVariant Register::get_form_cell(QString key)
{
    return mform[key];
}

void Register::setroot(QObject *engineroot)
{
    registergui=engineroot;
}









