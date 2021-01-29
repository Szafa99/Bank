#ifndef SESSION_H
#define SESSION_H

#include <QObject>
#include <QRegularExpression>

#include "headers/database.h"
#include "headers/currency.h"



class Data_base;
struct Currency;

class Session : public QObject
{

    friend class Login;
    Q_OBJECT

public:

    //! In the constructor a poniter to database instance is set
    explicit Session(QObject *parent=nullptr);
    Q_PROPERTY(Currency choosencurrency READ getcurrency WRITE setcurrency NOTIFY choosencurrencyChanged);

    Q_INVOKABLE void settransfers();
    Q_INVOKABLE QVector<QVariantMap> gettransfers() const;
    Q_INVOKABLE QString get_data_from_clients_table(QString record)const;

    //! Returns the id of the user currently being loged in
    static QString getclientId(){return client_id;};


public slots:

   //! Returns the currency of the currency accoun that is selected
   Currency getcurrency();

   //! Sets the currency that was selected by the user
   void setcurrency(const Currency &newcurrency);


signals:

   //! Is emitted when the choosen currency changes
    void choosencurrencyChanged();


private:

    //! Holds the id of the user being currently loged in
    static QString client_id;

    //! The currency that is currently selected by the user
    Currency choosencurrency;

    //! A pointer to the database instance
    Data_base *db;

    //! Stores a data about the transfers of the user
    QVector<QVariantMap> transfers;

};

#endif // SESSION_H
