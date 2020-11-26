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


bool Data_base::validet_user(const QString &username, const QString &pin)
{
    qDebug()<<"\n\n valuser:\n";
    QSqlQuery myquery;
    myquery.prepare( "SELECT pin FROM clients WHERE email = '" + username+"'");

    if(myquery.exec())
    {
        while(myquery.next())
            if(myquery.value(0).toString()==pin)
                return true;
    }
    else qDebug()<<myquery.lastError();
    return false;
}
