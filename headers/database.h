#ifndef DATA_BASE_H
#define DATA_BASE_H


#include <QtSql/QtSql>
#include <QtSql/QSqlDatabase>
#include<QtSql/QSqlQuery>
#include<QtSql/QSqlError>




class Data_base
{

public:
     Data_base(QString hostname ,QString username,QString password ,QString dbname ,QString sqlengine);
    ~Data_base();

private:
        QSqlDatabase clientdb;
        QString db_hostname;
        QString db_Username;
        QString db_Password;
        QString db_Name;
        QString db_Engine;
public:
        bool validet_user(const QString &username,const QString &pin);

};


#endif // Data_base_H
