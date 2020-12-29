#ifndef TRANSFER_LIST_H
#define TRANSFER_LIST_H

#include <QAbstractListModel>
#include <headers/database.h>
#include <headers/session.h>
#include <QVector>
#include <QMap>




class Transfer_list : public QAbstractListModel
{
    friend class Session;
    friend class Login;

    Q_OBJECT
    Q_PROPERTY(QVector<QVariantMap>  client_transfer_data READ client_transfer_data WRITE set_client_transfer_data)
public:
    explicit Transfer_list(QObject *parent=nullptr ):
        QAbstractListModel(parent)
    { };

    enum{
        transfername=0,
        transferamount,
        Date,
    };

public slots:


    QVector<QVariantMap> client_transfer_data() const {return mclient_transfer_data;};

    void set_client_transfer_data( QVector<QVariantMap> val){mclient_transfer_data=val;};





    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;



    // Add data:
    bool insertRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;

    virtual QHash<int,QByteArray> roleNames() const override;



private:

   QVector<QVariantMap> mclient_transfer_data;


};

#endif // TRANSFER_LIST_H
