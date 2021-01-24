#include "../headers/register.h"



Register::Register(QObject *parent):QObject(parent),
  form(FormFactory::getInstance().CreateForm("Form"))
{

    form->setmodel(Data_base::dbtables::clients);

    form->mform.insert("Pesel","Pesel");
    form->mform_edited.insert("Pesel",false);


    form->mform.insert("BirthPlace","BirthPlace");
    form->mform_edited.insert("BirthPlace",false);


    form->mform.insert("CitizenShip","CitizenShip");
    form->mform_edited.insert("CitizenShip",false);

    form->mform.insert("MotherName","MotherName");
    form->mform_edited.insert("MotherName",false);


    form->mform.insert("StreetName","StreetName");
    form->mform_edited.insert("StreetName",false);


    form->mform.insert("CheckPassword","CheckPassword");
    form->mform_edited.insert("CheckPassword",false);


    form->mform.insert("CheckPin","CheckPin");
    form->mform_edited.insert("CheckPin",false);

    form->mform["BirthDay"]="dd-mm-yyyy";

    form->mform["AccountNumber"]= Data_base::get_instance().generateAccountnumber();
    form->mform["AccountBalance"]= "100.00";


}





bool Register::register_user()
{

    if( Data_base::get_instance().insert_record(form->mform,Data_base::clients))
    {
        return true;
    }
       else return false;

}


bool Register::validate_email(const QVariant & mail)
{
    const QRegularExpression pattern("(\\w+)(\\.|_)?(\\w*)@(\\w+)(\\.(\\w+))+");
    const QRegularExpressionMatch match = pattern.match(mail.toString());
    if(!match.hasMatch())
    {
        form->merrorinfo.insert("Email","Email is not valid");
        emit form->error_infoChanged();
    }
    return match.hasMatch();
}

bool Register::check_match(const QVariant & checkkey)
{
    QString key=checkkey.toString();
    key.remove("Check");

    if(form->mform[checkkey.toString()]!=form->mform[key])
    {
        form->merrorinfo.insert(checkkey.toString(),key+" does not match");
        emit form->error_infoChanged();
        return false;
    }
    return true;
}

bool Register::validate_pin(const QVariant &pin)
{
    const QRegularExpression pattern("(^\\d{4}$)");
    const QRegularExpressionMatch match = pattern.match(pin.toString());
    if(!match.hasMatch())
    {
        form->merrorinfo.insert("Pin","Pin must have 4 digits");
        emit form->error_infoChanged();
    }
    return match.hasMatch();
}

bool Register::validate_password(const QVariant &password)
{
    //Minimum eight characters, at least one letter, one number and one special character:
    const QRegularExpression pattern("^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$");
    const QRegularExpressionMatch match = pattern.match(password.toString());
    if(!match.hasMatch())
    {
        form->merrorinfo.insert("Password","Password must contain eight characters, at least one letter, one number and one special character");
        emit form->error_infoChanged();
    }
    return match.hasMatch();
}

bool Register::validate_birthdate(const QVariant &birthdate)
{
    const QRegularExpression pattern("^((0[1-9]|[12]\\d|3[01])-(0[1-9]|1[0-2])-[12]\\d{3})$");
    const QRegularExpressionMatch match = pattern.match(birthdate.toString());
    if(!match.hasMatch())
    {
        form->merrorinfo.insert("BirthDay","BirthDay is no valid");
        emit form->error_infoChanged();
    }
    return match.hasMatch();
}


bool Register::validet_input()
{

    form->merrorinfo.clear();
    emit form->error_infoChanged();

    for(auto i = form->mform.begin();i!=form->mform.end();i++) {
        QQuickItem *cell= form->registergui->findChild<QQuickItem*>(i.key());

        if(cell)
        {
                if( i.key()==i.value() ) // checking if data was inserted
                {

                    cell->parentItem()->setProperty("bordercolor","red");
                    form->merrorinfo.insert(i.key(),"Type your "+i.key()+" data in");
                    emit form->error_infoChanged();
                }

                   else if(
                        (i.key().contains("Check") && !check_match(i.value()) ) || //checking if forms that need matches actually match
                        (i.key()=="Email" && !validate_email(i.value())     )  || // checking email
                        (i.key()=="Pin" && !validate_pin(i.value())         ) ||//checking pin
                        (i.key()=="Password" && !validate_password(i.value()))||//checking if password is valid
                        (i.key()=="BirthDay" && !validate_birthdate(i.value())) //checking birthdate
                        )
                    cell->parentItem()->setProperty("bordercolor","red");

                else cell->parentItem()->setProperty("bordercolor","lightgrey");

            }
    }


    return form->merrorinfo.empty();

}












