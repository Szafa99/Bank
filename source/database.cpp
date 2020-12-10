#include <headers/database.h>




Data_base::Data_base(QString hostname,QString Username,QString Password,QString dbName,QString sqlengine):
    db_hostname(hostname),
    db_Username(Username),
    db_Password(Password),
    db_Name(dbName),
    db_Engine(sqlengine)
{

    clientdb=QSqlDatabase::addDatabase(sqlengine);
    clientdb.setHostName(hostname);
    clientdb.setDatabaseName(dbName);
    clientdb.setPassword(Password);
    clientdb.setUserName(Username);
    if(clientdb.open()) qDebug()<<"Conncted to " + db_Name<< Qt::endl;
    else qDebug()<<"Connction to " + db_Name+" failed"<< Qt::endl;
}


Data_base::~Data_base()
{
    clientdb.close();
    qDebug()<<"closing database";
}


bool Data_base::validet_user(const QString &username, const QString &pin, QString &clientid)
{

    QSqlQuery myquery;
    myquery.prepare( "SELECT pin, id FROM clients WHERE email = '" + username + "'");

    if(myquery.exec())
    {
        while(myquery.next())
            if(myquery.value(0).toString()==pin){
                clientid=myquery.value(1).toString();
                qDebug()<<"clientid:"<<clientid;
                return true;
            }
    }
    else qDebug()<<myquery.lastError();
    return false;
}


QVector<QVariantMap> Data_base::set_clients_transfers(QString clientid)
{
    QVector<QVariantMap> transfers;
    QSqlQuery myquery;
    myquery.prepare( "SELECT * FROM clients_payments WHERE Client_id = '" + clientid+"' ");
    if(myquery.exec())
    {
        //int i=0;

        while(myquery.next())
        {
            QSqlRecord myrecord = clientdb.driver()->record("clients_payments");
            QVariantMap buf;
            for(int i=0;i<myrecord.count();i++){
                buf.insert( clientdb.driver()->record("clients_payments").fieldName(i) ,myquery.value(i).toString() ) ;
            }

            transfers.push_back(buf);
        }
        return transfers;
    }
    else qDebug()<<"Couldn't load transfers : "<<myquery.lastError();
    return {{{"",""}}};
}




QString Data_base::getclient_data(QString data, dbtables table,QString client_id) const
{
    QSqlQuery myquery;
    if(table == clients)
        myquery.prepare( "SELECT " + data + " FROM clients WHERE id = " + client_id );
    else if(table==client_payments)
        myquery.prepare( "SELECT " + data + " FROM clients_payments WHERE Client_id = " + client_id );


    if(myquery.exec())
    {
        while(myquery.next())
            return (myquery.value(0).toString());
    }
    else qDebug()<<"Couldn't fetch data about:" << data << " : " << myquery.lastError();
    return QString::Null();

}











