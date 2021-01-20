#ifndef DATA_BASE_H
#define DATA_BASE_H


#include <QtSql/QtSql>
#include <QtSql/QSqlDatabase>
#include<QtSql/QSqlQuery>
#include<QtSql/QSqlError>
#include<QtSql/QSqlField>
#include "session.h"



class Data_base
{

    friend class Session;
    friend class Login;

private:
    Data_base(QString hostname ,QString username,QString password ,QString dbname ,QString sqlengine);

public:
      enum dbtables{
         clients=1,
         client_payments,
         currency_accounts,
          currencys
     };

    ~Data_base();

private: //fields
        QSqlDatabase clientdb;
        QString db_hostname;
        QString db_Username;
        QString db_Password;
        QString db_Name;
        QString db_Engine;

public:
        Data_base(Data_base const&)=delete;
        void operator=(Data_base const&)=delete;
        static Data_base &get_instance();

public: //methods
        bool validet_user(const QString &username,const QString &pin,QString &clientid);
        bool insert_record(QVariantMap data,dbtables table);
        bool check_if_data_exist(const QString &data,const QString& formName,dbtables table);
        bool check_if_data_exist(const QString &data,const QString& formName,dbtables table,const QString & clientid);
        bool updatedata(const QString &formname,const QString &newdata,dbtables table,const QString &id);
        QVector<QString> getcolumnnames(dbtables table);
        QVector<QVariantMap> set_clients_transfers(QString clientid);
        QString getclient_data(QString formname, dbtables table,QString client_id)const;
        QString getclient_data(const QString &formname, dbtables table, const QString& formname2,const QString& formdata)const;
        QStringList getcolumn(const QString &columname,dbtables table,const QString & clientid);
        QStringList getcolumn(const QString &columname,dbtables table);
};



Q_DECLARE_METATYPE(QSqlField)
#endif // Data_base_H
