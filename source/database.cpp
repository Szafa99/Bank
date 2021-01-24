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




QString Data_base::tableNames(const dbtables &tablename)const
{
    QHash<int,QString> table;
    table[clients]="clients";
    table[currencys]="currencys";
    table[currency_accounts]="currency_accounts";
    table[client_payments]="clients_payments";
    return table[tablename];
}




QString Data_base::generateAccountnumber()
{
    QString accountnumber;
    QVariant digit;
   do{
    for(int i =0;i<4;i++)
    {
    digit = QRandomGenerator::global()->bounded(1000, 10000);
    accountnumber+= " " + digit.toString() ;
    }
    }while (
            check_if_data_exist("PLN" + accountnumber,"AccountNumber",currency_accounts)  &&
            check_if_data_exist(accountnumber,"AccountNumber",clients)
            );


    return  accountnumber;
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

Data_base &Data_base::get_instance()
{
    static Data_base instance("localhost","root","","bank_clients","QMYSQL");
    return instance;
}




QVector<QVariantMap> Data_base::set_clients_transfers(QString clientid)
{
    QVector<QVariantMap> transfers;
    QSqlQuery myquery;
    myquery.prepare( "SELECT * FROM clients_payments WHERE id = '" + clientid+"' ");
    if(myquery.exec())
    {

        QSqlRecord myrecord = clientdb.driver()->record("clients_payments");
        while(myquery.next())
        {
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




QVector<QString> Data_base::getcolumnnames(Data_base::dbtables table)
{
    QVector<QString> columnkeys;
    QSqlRecord myrecord;

    myrecord= clientdb.driver()->record(tableNames(table));
    columnkeys.reserve(myrecord.count());


    for(int i=0;i<myrecord.count();i++)
        columnkeys.push_back( myrecord.fieldName(i)) ;

    return columnkeys;

}




QString Data_base::getclient_data(QString data, dbtables table,QString client_id) const
{
    QSqlQuery myquery;
       myquery.prepare( "SELECT " + data + " FROM " + tableNames(table) + " WHERE id = " + client_id );


    if(myquery.exec())
        while(myquery.next())
            return (myquery.value(0).toString());

    else qDebug()<<"IN getclient_data COLUDN'T FETCH DATA ABOUT:" << data << " : " << myquery.lastError();
    return QString::Null();

}




QString Data_base::getclient_data(const QString &data, dbtables table, const QString& formname,const QString& formdata) const
{
    QSqlQuery myquery;
    QString temp;
    myquery.prepare( "SELECT `" + data + "` FROM `" + tableNames(table) + "` WHERE `" + formname + "` = '"+ formdata+"'" );


    if(myquery.exec())
    {
        while(myquery.next())
            return (myquery.value(0).toString());
    }
    else qDebug()<<"IN getclient_data COLUDN'T FETCH DATA ABOUT:" << data << " : " << myquery.lastError();
    return QString::Null();
}





QString Data_base::getclient_data(const QString &data, Data_base::dbtables table, const QString &formname, const QString &formdata, const QString &clientid) const
{
    QSqlQuery myquery;
       myquery.prepare( "SELECT " + data + " FROM " + tableNames(table) + " WHERE " + formname + " = " + formdata + " && id = " + clientid );


    if(myquery.exec())
        while(myquery.next())
            return (myquery.value(0).toString());

    else qDebug()<<"IN getclient_data COLUDN'T FETCH DATA ABOUT:" << data << " : " << myquery.lastError();
    return QString::Null();
}





QStringList Data_base::getcolumn(const QString &columname, Data_base::dbtables table, const QString &clientid)
{
    QSqlQuery myquery;
    QStringList columnlist;
    myquery.prepare("SELECT " + columname + " FROM " +  tableNames(table) +" WHERE id = "+clientid);


    if(myquery.exec())
        while(myquery.next())
           columnlist.push_back(myquery.value(0).toString());

    else qCritical()<<"QUERY ERROR IN GETCOLUMN METHOD: "<<myquery.lastError();

    return columnlist;
}





QStringList Data_base::getcolumn(const QString &columname, Data_base::dbtables table)
{

    QSqlQuery myquery;
    QStringList columnlist;
    myquery.prepare("SELECT " + columname + " FROM "+tableNames(table));

    if(myquery.exec())
        while(myquery.next())
           columnlist.push_back(myquery.value(0).toString());
    else qCritical()<<"QUERY ERROR IN GETCOLUMN METHOD: "<<myquery.lastError();

    return columnlist;

}




bool Data_base::check_if_data_exist(const QString &data,const QString& formName, Data_base::dbtables table)
{
    QSqlQuery myquery;
    myquery.prepare( "SELECT "+ formName  + " FROM " + tableNames(table) );

    if(myquery.exec()){
        while (myquery.next())
            if( data == myquery.value(0).toString())return true;
    }
    else qCritical()<<" QUERY_ERROR IN CHECK_IF_DATA_EXIST FUNCTION " << myquery.lastError();
    return false;

}





bool Data_base::check_if_data_exist(const QString &data,const QString& formName, Data_base::dbtables table,const QString & clientid)
{
    QSqlQuery myquery;
        myquery.prepare( "SELECT "+ formName  + " FROM " + tableNames(table) +" WHERE id = " + clientid );


    if(myquery.exec()){
        while (myquery.next())
            if( data == myquery.value(0).toString())return true;
    }
    else qCritical()<<" QUERY_ERROR IN CHECK_IF_DATA_EXIST FUNCTION " << myquery.lastError();
    return false;

}




bool Data_base::updatedata(const QString &formname, const QString &newdata, Data_base::dbtables table, const QString &id)
{
    QSqlQuery myquery;
        myquery.prepare( "UPDATE " + tableNames(table) + " SET " + formname + " = " + newdata +" WHERE id = " + id );

     if(myquery.exec())
        return true;

    else qDebug()<<"Couldn't update:" << formname << " : " << myquery.lastError();
    return false;
}




bool Data_base::updatedata(const QString &formname, const QString &newdata, Data_base::dbtables table,const QString &datacolumn,const QString & data)
{
    QSqlQuery myquery;
        myquery.prepare( "UPDATE " + tableNames(table) + " SET " + formname + " = " + newdata +" WHERE " + datacolumn + " = " + data);

     if(myquery.exec())
        return true;

    else qDebug()<<"Couldn't update:" << formname << " : " << myquery.lastError();
     return false;
}





bool Data_base::updatedata(const QString &formname, const QString &newdata, Data_base::dbtables table, const QString &datacolumn, const QString &data, const QString &clientid)
{
    QSqlQuery myquery;
        myquery.prepare( "UPDATE " + tableNames(table) + " SET `" + formname + "` = '" + newdata + "' WHERE `" + datacolumn + "` = '" + data + "' && `id` = '" + clientid+"'");


     if(myquery.exec())
        return true;

    else qDebug()<<"Couldn't update:" << formname << " : " << myquery.lastError();
     return false;
}




bool Data_base::insert_record(QVariantMap data,dbtables table)
{

    QSqlQuery myquery;
    QSqlRecord myrecord;
    QString keys ,values;
    values = " VALUES (";


        keys = "INSERT INTO `" + tableNames(table) + "` (";
        myrecord = clientdb.driver()->record(tableNames(table));



    // Preapering query which task is to insert a new record
    for(QVariantMap::Iterator i = data.begin(); i!=data.end() ;i++){
        if(myrecord.contains(i.key()) && myrecord.field(i.key()).type()!=QVariant::Type::Date &&
                !myrecord.field(i.key()).isAutoValue())
        {
            keys+=( "`"+ qvariant_cast<QString>(i.key()) + "`, " );
            values+=( "'"+ qvariant_cast<QString>(i.value()) + "', " );
        }
    }

    values.replace(values.size()-2,1,")");// replacing "," with ")"
    keys.replace(keys.size()-2,1,")");

    if(myquery.exec(keys+values) )
        return true;
    else
    {
        qCritical()<<myquery.lastError();
        return false;
    }


}











