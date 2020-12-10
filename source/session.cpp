#include "headers/session.h"

Session::Session(QObject *parent) : QObject(parent)
{}


QString Session::get_data_from_clients_table(QString record) const
{
    return db->getclient_data(record,Data_base::clients,client_id);
}

