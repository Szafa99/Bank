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
    explicit Session(QObject *parent=nullptr);
    Q_PROPERTY(Currency choosencurrency READ getcurrency WRITE setcurrency NOTIFY choosencurrencyChanged);

    Q_INVOKABLE void settransfers();
    Q_INVOKABLE QVector<QVariantMap> gettransfers() const;
    Q_INVOKABLE QString get_data_from_clients_table(QString record)const;

    static QString getclientId(){return client_id;};


public slots:
   Currency getcurrency()const;

   void setcurrency(const Currency &newcurrency);


signals:
    void choosencurrencyChanged();


private:
    static QString client_id;

    Currency choosencurrency;

    Data_base *db;

    QVector<QVariantMap> transfers;

};

#endif // SESSION_H
