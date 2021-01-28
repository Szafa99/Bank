#ifndef DATA_BASE_H
#define DATA_BASE_H


#include <QtSql/QtSql>
#include <QtSql/QSqlDatabase>
#include<QtSql/QSqlQuery>
#include<QtSql/QSqlError>
#include<QtSql/QSqlField>
#include <QRandomGenerator>

#include "session.h"



class Data_base
{

    friend class Session;
    friend class Login;

private:
    //! Sets the connection with the database . If the fails to connect - suitable info will be shown
    Data_base(QString hostname ,QString username,QString password ,QString dbname ,QString sqlengine);

public:
    //! \enum This enum represents the tables from the database
      enum dbtables{
         clients=1,
         client_payments,
         currency_accounts,
          currencys
     };

    // In the destructor the database is closed
    ~Data_base();

private:
        //! Holds the conncection to the database
        QSqlDatabase clientdb;
        //! Holds the host name of the database
        QString db_hostname;
        //! Holds the username of the database
        QString db_Username;
        //! Holds the pasword to the database
        QString db_Password;
        //! Hold the name of the database
        QString db_Name;
        //! Hold the engine name of the database
        QString db_Engine;

public:
        //! This is a singelton. Can't copy the object
        Data_base(Data_base const&)=delete;
        //! This is a singelton. Can't copy the object
        void operator=(Data_base const&)=delete;
        //! Returns a Data_base instance
        static Data_base &get_instance();

public:
        //! Validates if the pin given by the user matches the username
        bool validet_user(const QString &username,const QString &pin,QString &clientid);

        //! Insert a record into the given table
        //! data - a map of data, which keys must be of type QString and match the colummn name where the data should be inserted in
        //!  able - the table you want to insert the data in
        bool insert_record(QVariantMap data,dbtables table);
        //! Returns true if a given data exist in the given table in the column passed under ther fromName argument

        bool check_if_data_exist(const QString &data,const QString& columnname,dbtables table);

        //! Returns true if a given data exist in the given table in the column passed under ther fromName argument where the id matches the given clientid
        bool check_if_data_exist(const QString &data,const QString& columnname,dbtables table,const QString & clientid);

        //! Return true if data was updated succsesfully.
        //! @param columnname - name of the column where the data should be updated
        //! @param newdata - data that the cell should be updated with
        //! @param table - database table in which the data shuld be updated
        //! @param table - database table in which the data shuld be updated
        //! @param id - the id of the user of whom the data should be updated
        bool updatedata(const QString &columnname,const QString &newdata,dbtables table,const QString &id);

        //! Return true if data was updated succsesfully.
        //! @param fromname - name of the column where the data should be updated
        //! @param newdata - data that the cell should be updated with
        //! @param table - database table in which the data shuld be updated
        //! @param table - database table in which the data shuld be updated
        //! @param columname2 - column name of the data argument
        //! @param data- tha data that the cel of the columnname should match
        bool updatedata (const QString &columnname, const QString &newdata, Data_base::dbtables table,const QString &columnname2,const QString & data);

        //! Return true if data was updated succsesfully.
        //! @param columnname - name of the column where the data should be updated
        //! @param newdata - data that the cell should be updated with
        //! @param table - database table in which the data shuld be updated
        //! @param table - database table in which the data shuld be updated
        //! @param columname2 - columnname of the \c data argument
        //! @param data- tha data that the cell of the columnname should match
        //! @param clientid - the id of the user of whom the data should be updated
        bool updatedata (const QString &columnname, const QString &newdata, Data_base::dbtables table,const QString &columnname2,const QString & data,const QString &clientid);

        //! Returns a vector of QStrings which stands for the column names of the given table
        QVector<QString> getcolumnnames(dbtables table);

        //! Fetches the transfers from the user under the given id and returns them in a Vector of QVariantMaps.
        //! NOTE The Maps keys are the names of the column
        QVector<QVariantMap> set_clients_transfers(QString clientid);

        //! Returns data from the given table under the given colum name from the row where the id matches the data under clientid argument
        QString getclient_data(QString columnname, dbtables table,QString client_id)const;

        //! Returns data from the given table under the given colum name from the row where the id matches the data under clientid argument
        QString getclient_data(const QString &columnname, dbtables table, const QString& columname2,const QString& formdata)const;

        //! Returns data from the given table under the given colum name from the row where the id matches the data under clientid argument
        QString getclient_data(const QString &columnname, dbtables table, const QString& columnname2,const QString& formdata,const QString &clientid )const;

        //! Returns a list of data from the given columnname where the user id matches the clientid
        QStringList getcolumn(const QString &columname,dbtables table,const QString & clientid);

        //! Returns the whole data from a given columname from the given table in a QStringList structure
        QStringList getcolumn(const QString &columname,dbtables table);

        //! This method generets an unique account number
        QString generateAccountnumber();
private:
        //! This method takes a table name in form of a enum and returns the suitable name in form of a QString
        QString tableNames(const dbtables &tablename) const;
};



Q_DECLARE_METATYPE(QSqlField)
#endif // Data_base_H
