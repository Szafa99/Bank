#include "headers/currencyaccountform.h"

CurrencyAccountForm::CurrencyAccountForm(QObject *parent) : QObject(parent),
    form(FormFactory::getInstance().CreateForm("Form")),
    db(&Data_base::get_instance())
{
    form->setmodel(Data_base::currency_accounts);
    form->mform["Id"]="2";//Session::getclientId();
    form->mform["AccountBalance"]="0.00";//Session::getclientId();
    form->mform["Currency"]="";//Session::getclientId();
    form->mform["AccountNumber"]= "PLN " + db->getclient_data("AccountNumber",Data_base::clients,form->mform["Id"].toString());
}

bool CurrencyAccountForm::validateInput()
{
    return (!alreadyexist() && currencyChoosen());
}

void CurrencyAccountForm::addcurencyaccount()
{
    db->insert_record(form->mform,Data_base::currency_accounts);
}

bool CurrencyAccountForm::currencyChoosen()
{
    if(form->mform["Currency"]=="")
    {
        form->merrorinfo.insert("AccountNumber","You have to choose a currency");
        emit form->error_infoChanged();
        return false;
    }
    return true;
}

bool CurrencyAccountForm::alreadyexist()
{
    if(db->check_if_data_exist(form->mform["AccountNumber"].toString(),"AccountNumber",Data_base::currency_accounts,form->mform["Id"].toString() ) )
    {
        form->merrorinfo.insert("AccountNumber","You already have an account of this cuurency");
        emit form->error_infoChanged();
        return true;
    }
    return false;
}




