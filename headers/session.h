#ifndef SESSION_H
#define SESSION_H

#include <QObject>

#include "headers/database.h"
//#include <headers/transfer_list.h>


class Data_base;
class Session : public QObject
{
    friend class Login;
    Q_OBJECT

public:
    Q_INVOKABLE QVector<QVariantMap>  gettransfers() const {return transfers ;};
     Q_INVOKABLE QString get_data_from_clients_table(QString record)const;


    explicit Session(QObject *parent=nullptr);



private:

    QString client_id;
    Data_base *db;
    QVector<QVariantMap> transfers;
    //QML_ELEMENT
};

#endif // SESSION_H
