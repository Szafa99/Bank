#include "headers/session.h"

QString Session::client_id=0;

Session::Session(QObject *parent) : QObject(parent),
    db(&Data_base::get_instance())
{
    choosencurrency.amount=get_data_from_clients_table("AccountBalance");
}


QString Session::get_data_from_clients_table(QString record) const
{
    return db->getclient_data(record,Data_base::clients,client_id);
}

void Session::settransfers()
{
    transfers = db->set_clients_transfers(client_id);
}



