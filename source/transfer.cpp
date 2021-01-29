#include "headers/transfer.h"

Transfer::Transfer(QObject *parent):QObject(parent),
    form(FormFactory::getInstance().CreateForm("Form")),
    db(&Data_base::get_instance())
{
    form->setmodel(Data_base::dbtables::client_payments);
    form->mform["TransferAmount"]="00,00";
    form->mform["AccountNumber"]="0000 0000 0000 0000";
    form->mform["Currency"];
}

Transfer::~Transfer()
{
    delete form;
}



bool Transfer::make_transfer(const Currency &currency)
{
        form->mform["Currency"] = currency.type;
        QString sum =form->mform["TransferAmount"].toString();
        double sum_d=sum.toDouble();
        double sendersBalance ,reciversBalance;
        QString recieverId = db->getclient_data("id",Data_base::clients,"AccountNumber",form->mform["AccountNumber"].toString());
        QString senderId = Session::getclientId();
        bool reciever_has_same_account = db->check_if_data_exist(currency.type,"Currency",Data_base::currency_accounts,recieverId);
    QString reciversNewBalance,sendersNewBalance;

        // Check from which account the money is sent
        if(currency.type=="PLN")
        sendersBalance = db->getclient_data("AccountBalance",Data_base::clients,senderId).toDouble();
        else
         sendersBalance = db->getclient_data("AccountBalance",Data_base::currency_accounts,"Currency",currency.type,senderId ).toDouble();

        //Check if the reciver owns a currency account of the same currency as the account the money is send from. By default the money will be transfer
        // to the account of the same currency. Otherwise the money will be transfered to the main account
        if(reciever_has_same_account)
             reciversBalance = db->getclient_data("AccountBalance",Data_base::currency_accounts,"Currency",currency.type,recieverId).toDouble();
        else
            reciversBalance = db->getclient_data("AccountBalance",Data_base::clients,recieverId).toDouble();


        sendersNewBalance = QString::number(sendersBalance - sum_d,'f',2);
        if(reciever_has_same_account)
            reciversNewBalance = QString::number(reciversBalance + sum_d,'f',2);
        else
           reciversNewBalance = QString::number(reciversBalance + sum_d * currency.converter,'f',2);


            if(sendersBalance - sum_d<0)
            {
               form->merrorinfo["TransferAmount"]="You don't have enough savings";
               emit form->error_infoChanged();
               return false;
            }
            else
            {   // if data is correct
                // updating senders and recivers account balance
                if(currency.type=="PLN")
                    db->updatedata("AccountBalance",sendersNewBalance,Data_base::clients,senderId);
                else
                    db->updatedata("AccountBalance",sendersNewBalance,Data_base::currency_accounts,"Currency",currency.type,senderId);

                if(reciever_has_same_account)
                    db->updatedata("AccountBalance",sendersNewBalance,Data_base::currency_accounts,"Currency",currency.type,recieverId);
                else
                    db->updatedata("AccountBalance",reciversNewBalance,Data_base::clients,recieverId);


                // adding transfer to senders and recivers transferlist

                QString temp = form->mform["TransferAmount"].toString();
                if(temp[0]=="0" && temp.size()==5)
                    temp.remove(0,1);

                temp.push_front('-');
                form->mform["TransferAmount"]=temp;
                form->mform["Id"]=senderId;
                db->insert_record(form->mform,Data_base::client_payments);


                temp.remove("-");
                form->mform["TransferAmount"]=QString::number( sum_d * currency.converter,'f',2);;
                form->mform["Id"]=recieverId;
                form->mform["AccountNumber"]=db->getclient_data("AccountNumber",Data_base::clients,senderId);
                if(reciever_has_same_account)
                    db->insert_record(form->mform,Data_base::client_payments);
                else
                {

                    form->mform["Currency"]="PLN";
                    db->insert_record(form->mform,Data_base::client_payments);
                }

                return true;
            }




}


bool Transfer::validateAccountNumber(const QVariant & accountNumber)
{
    if(db->check_if_data_exist(accountNumber.toString(),"AccountNumber",Data_base::clients) ||
            db->check_if_data_exist(accountNumber.toString(),"AccountNumber",Data_base::currency_accounts ) )
        return true;
    else
    {
        form->merrorinfo["AccountNumber"]="AccountNumber dosen't exist";
        emit form->error_infoChanged();
        return false;
    }
}

bool Transfer::validateTransferAmount(const QVariant & amount)
{

    if(amount.toDouble()==0.0){
        form->merrorinfo.insert("TransferAmount","Insert the sum you want to transfer");
        emit form->error_infoChanged();
        return false;
    }
    else return true;

}



bool Transfer::validet_input()
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
                    (i.key() == "AccountNumber" && !validateAccountNumber( (i.value()) )) ||
                    (i.key() == "TransferAmount" && !validateTransferAmount(i.value()))
                    )
                cell->parentItem()->setProperty("bordercolor","red");

            else cell->parentItem()->setProperty("bordercolor","lightgrey");

        }
    }


    return form->merrorinfo.empty();

}


