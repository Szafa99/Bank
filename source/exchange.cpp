#include "headers/exchange.h"


Exchange::Exchange(QObject *parent) : QObject(parent),
    form(FormFactory::getInstance().CreateForm("Form")),
    db(&Data_base::get_instance())
{
    form->mform.insert("Id",Session::getclientId());
    form->mform.insert("Result", "0.0");
    form->mform_edited.insert("Result", false );
    form->mform.insert("Amount", "0.0");
    form->mform_edited.insert("Amount", false );

}

QString Exchange::setresult(const QVariant &converter_input, const QVariant &converter_output)
{

    double res = form->mform["Amount"].toDouble()*(converter_output.toDouble()/converter_input.toDouble());

    form->mform["Result"]= QString::number(res,'f',2);

    return QString::number(res,'f',2);
}

bool Exchange::validate(const double &accountBalance)
{
    if (accountBalance>= form->mform["Amount"].toDouble() )
        return true;
    else {
        form->merrorinfo["Amount"]="You don't have enough money on your account.";
        emit form->error_infoChanged();
    }
    return false;
}


// This method updates the accountbalances of the currency account - makes the exchange
void Exchange::exchange(const Currency &inputcurrency, const Currency &outputcurrency)
{
    QString clientid = Session::getclientId();
    double currentAccountBalance;
    QString newAccountBalance;

    // First handling the accountbalance if of the account the money is converted from
    if(inputcurrency.type=="PLN"){
        currentAccountBalance = db->getclient_data("AccountBalance",Data_base::clients,clientid).toDouble();
        newAccountBalance = QString::number (currentAccountBalance - form->mform["Amount"].toDouble(),'f',2 );
        db->updatedata("AccountBalance",newAccountBalance,Data_base::clients,clientid );

    }
    else{
        currentAccountBalance = db->getclient_data("AccountBalance",Data_base::currency_accounts,clientid).toDouble();
        newAccountBalance = QString::number (currentAccountBalance - form->mform["Amount"].toDouble(),'f',2 );
        db->updatedata("AccountBalance",newAccountBalance,Data_base::currency_accounts,"Currency",inputcurrency.type,clientid);

    }

    // Then handling the accountbalance of the account the money is converted to
    if(outputcurrency.type=="PLN"){
        currentAccountBalance = db->getclient_data("AccountBalance",Data_base::clients,clientid).toDouble();
        newAccountBalance = QString::number (currentAccountBalance + form->mform["Result"].toDouble(),'f',2 );
        db->updatedata("AccountBalance",newAccountBalance,Data_base::clients,clientid );

    }
    else{
        currentAccountBalance = db->getclient_data("AccountBalance",Data_base::currency_accounts,clientid).toDouble();
        newAccountBalance = QString::number (currentAccountBalance + form->mform["Result"].toDouble(),'f',2 );
        db->updatedata("AccountBalance",newAccountBalance,Data_base::currency_accounts,"Currency",outputcurrency.type,clientid);

    }


}




