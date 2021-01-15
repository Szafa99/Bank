#include "headers/transfer.h"

Transfer::Transfer(QObject *parent):QObject(parent),
    form(FormFactory::getInstance().CreateForm("Form")),
    db(&Data_base::get_instance())
{
    form->setmodel(Data_base::dbtables::client_payments);
    form->mform["TransferAmount"]="00,00";
    form->mform["AccountNumber"]="0000 0000 0000 0000";

}

Transfer::~Transfer()
{
    delete form;
}

bool Transfer::make_transfer()
{

        QString sum =form->mform["TransferAmount"].toString();
        sum.chop(3);
        bool *ok=new bool;
        double sum_d=sum.toDouble(ok);
        if(!*ok){
            qCritical("Coludn't convert to double");
            return false;
        }
        else
        {
        QString recieverId = db->getclient_data("id",Data_base::clients,"AccountNumber",form->mform["AccountNumber"].toString());
        QString senderId = Session::getclientId();
        double sendersBalance = db->getclient_data("AccountBalance",Data_base::clients,senderId).toDouble();
        double reciversBalance = db->getclient_data("AccountBalance",Data_base::clients,recieverId).toDouble();


        QString reciversNewBalance = QString::number(reciversBalance + sum_d,'f',2);
        QString sendersNewBalance = QString::number(sendersBalance - sum_d,'f',2);


            if(sendersBalance - sum_d<0)
            {
               form->merrorinfo["TransferAmount"]="You don't have enough savings";
               emit form->error_infoChanged();
               return false;
            }
            else
            {   // if data is correct
                // updating senders and recivers account balance
                db->updatedata("AccountBalance",reciversNewBalance,Data_base::clients,recieverId);
                db->updatedata("AccountBalance",sendersNewBalance,Data_base::clients,senderId);

                // adding transfer to senders and recivers transferlist
                QString temp = form->mform["TransferAmount"].toString();
                temp.chop(3);

                temp.push_front('-');
                form->mform["TransferAmount"]=temp;
                form->mform["Id"]=senderId;
                db->insert_record(form->mform,Data_base::client_payments);

                temp.remove("-");
                form->mform["TransferAmount"]=temp;
                form->mform["Id"]=recieverId;
                form->mform["AccountNumber"]=db->getclient_data("AccountNumber",Data_base::clients,senderId);
                db->insert_record(form->mform,Data_base::client_payments);


                return true;
            }
    }



}


bool Transfer::validateAccountNumber(const QVariant & accountNumber)
{
    if(db->check_if_data_exist(accountNumber.toString(),"AccountNumber",Data_base::clients))
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

    if(amount.toString()=="00,00"){
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


