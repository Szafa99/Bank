#ifndef TRANSFER_LIST_H
#define TRANSFER_LIST_H

#include <QAbstractListModel>
#include <QVector>
#include <QMap>

#include <headers/database.h>
#include <headers/session.h>



//! \class Transfer_list is a model of a listview that displays the users transfer list
class Transfer_list : public QAbstractListModel
{
    friend class Session;
    friend class Login;

    Q_OBJECT
    Q_PROPERTY(QVector<QVariantMap>  client_transfer_data READ client_transfer_data WRITE set_client_transfer_data)
public:


    explicit Transfer_list(QObject *parent=nullptr );


    //! This enum is used to call the right datatype in the data() method from qml level
    //!  \value transfername - reffers to the title of the transfer
    //!  \value transferamount - reffers to the amount of the transfer
    //!  \value Date - reffers to date of the trasnfer
    enum{
        transfername=0,
        transferamount,
        date,
        currency
    };

public slots:

    //!  Returns the data of the model. The map holds data about the transfername,transferamount and date
    QVector<QVariantMap> client_transfer_data() const;


    //! Fills the model with data about the clients transfers.
    void set_client_transfer_data( QVector<QVariantMap> val);


    //! Returns how many elements are in the list
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    //! Returns the data about a transfer
    //! \param role says witch data specified in qml to return
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;



    //!Hashes the enum Roles with the names after which the needed data is called from qml
    virtual QHash<int,QByteArray> roleNames() const override;



private:

    //! Holds data of the model
   QVector<QVariantMap> mclient_transfer_data;


};

#endif // TRANSFER_LIST_H
