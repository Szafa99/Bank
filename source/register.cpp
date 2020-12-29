#include "../headers/register.h"



Register::Register(QObject *parent):
    QObject(parent),lastcell(nullptr)
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

    mform.insert("City", "City" );
    mform_edited.insert("City", false );

    mform.insert("StreetName","StreetName");
    mform_edited.insert("StreetName",false);

    mform.insert("HouseNumber","HouseNumber");
    mform_edited.insert("HouseNumber",false);

    mform.insert("PostalCode","PostalCode");
    mform_edited.insert("PostalCode",false);

    mform.insert("Password","Password");
    mform_edited.insert("Password",false);

    mform.insert("CheckPassword","CheckPassword");
    mform_edited.insert("CheckPassword",false);

    mform.insert("Pin","Pin");
    mform_edited.insert("Pin",false);

    mform.insert("CheckPin","CheckPin");
    mform_edited.insert("CheckPin",false);


}

void Register::setForm(const QVariantMap &formcell,Action_on_cell action)
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


QVariant Register::get_form_cell(QString key)
{
    return mform[key];
}


QVariant Register::get_error_info()
{
    if(merrorinfo.empty())
        return "";
    else return merrorinfo.last();
}


bool Register::register_user()
{
    return Data_base::get_instance().add_client(mform,Data_base::clients) ;
}

void Register::update()
{
    if(lastcell!=NULL)
    {
        QVariantMap cell;
        cell.insert(lastcell->objectName(),"");
        setForm( cell,Action_on_cell::Editing_Finished);
    }
}


void Register::setroot(QObject *engineroot)
{
    registergui=engineroot;
}


bool Register::validet_input()
{

    merrorinfo.clear();
    emit error_infoChanged();
    for(auto i = mform.begin();i!=mform.end();i++) {
        QQuickItem *cell= registergui->findChild<QQuickItem*>(i.key());
        if(cell) {
        if( i.key()==i.value() )
        {

           cell->parentItem()->setProperty("bordercolor","red");
           merrorinfo.insert(i.key(),"Please type your "+i.key()+" data in");
           emit error_infoChanged();
        }
        else cell->parentItem()->setProperty("bordercolor","lightgrey");
}

    }
    if(merrorinfo.empty()) return true;
    else return false;

}









