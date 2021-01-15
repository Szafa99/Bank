#ifndef SESSION_H
#define SESSION_H

#include <QObject>
#include <QRegularExpression>

#include "headers/database.h"



class Data_base;
class Session : public QObject
{
    friend class Login;
    Q_OBJECT

public:
    explicit Session(QObject *parent=nullptr);
    Q_INVOKABLE void settransfers();
    Q_INVOKABLE QVector<QVariantMap> gettransfers() const {return transfers ;};
    Q_INVOKABLE QString get_data_from_clients_table(QString record)const;

    static QString getclientId(){return client_id;};




private:
    static QString client_id;

    Data_base *db;
    QVector<QVariantMap> transfers;

};

#endif // SESSION_H
