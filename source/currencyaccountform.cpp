#include "headers/currencyaccountform.h"

CurrencyAccountForm::CurrencyAccountForm(QObject *parent) : QObject(parent),
    form(FormFactory::getInstance().CreateForm("Form")),
    db(&Data_base::get_instance())
{
    form->setmodel(Data_base::currency_accounts);
    form->mform["Id"]= Session::getclientId();
    form->mform["AccountBalance"]="0.0";
    form->mform["Currency"]="";
    form->mform["AccountNumber"]= "PLN" + db->generateAccountnumber();
}




bool CurrencyAccountForm::validateInput()
{
    if(form->mform["Currency"]=="")
        {
            form->merrorinfo.insert("AccountNumber","You have to choose a currency");
            emit form->error_infoChanged();
            return false;
        }
        return true;
}




void CurrencyAccountForm::addcurencyaccount()
{
    db->insert_record(form->mform,Data_base::currency_accounts);
}






