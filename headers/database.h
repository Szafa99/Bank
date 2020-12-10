#ifndef DATA_BASE_H
#define DATA_BASE_H


#include <QtSql/QtSql>
#include <QtSql/QSqlDatabase>
#include<QtSql/QSqlQuery>
#include<QtSql/QSqlError>
#include "session.h"




class Data_base
{
//b    friend class Transfer_list;
    friend class Session;
    friend class Login;
public:
     Data_base(QString hostname ,QString username,QString password ,QString dbname ,QString sqlengine);

      enum dbtables{
         clients=1,
         client_payments
     };

    ~Data_base();

private: //fields
        QSqlDatabase clientdb;
        QString db_hostname;
        QString db_Username;
        QString db_Password;
        QString db_Name;
        QString db_Engine;

public: //methods
        bool validet_user(const QString &username,const QString &pin,QString &clientid);
        bool get_client_id();

private: //methods
      QVector<QVariantMap> set_clients_transfers(QString clientid);
      QString getclient_data(QString data, dbtables table,QString client_id)const;
};


#endif // Data_base_H
