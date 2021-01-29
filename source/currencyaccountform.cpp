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

CurrencyAccountForm::~CurrencyAccountForm()
{
    delete form;
}




bool CurrencyAccountForm::validateInput()
{
    if(form->mform["Currency"]=="")
        {
            form->merrorinfo.insert("AccountNumber","You have to choose a currency");
            emit form->error_infoChanged();
        }
    if( db->check_if_data_exist(form->mform["Currency"].toString(),"Currency",Data_base::currency_accounts,Session::getclientId()) )
        {
            form->merrorinfo.insert("AccountNumber","You have already an account of this currency");
            emit form->error_infoChanged();
        }

    return form->merrorinfo.empty();
}




void CurrencyAccountForm::addcurencyaccount()
{
    db->insert_record(form->mform,Data_base::currency_accounts);
}






