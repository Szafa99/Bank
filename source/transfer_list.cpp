#include "headers/transfer_list.h"




Transfer_list::Transfer_list(QObject *parent):
    QAbstractListModel(parent){}

QVector<QVariantMap> Transfer_list::client_transfer_data() const
{
    return mclient_transfer_data;
}

void Transfer_list::set_client_transfer_data(QVector<QVariantMap> val)
{
    mclient_transfer_data=val;
};




int Transfer_list::rowCount(const QModelIndex &parent) const
{

    if (parent.isValid())
        return 0;


    else return mclient_transfer_data.size();
}

QVariant Transfer_list::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || mclient_transfer_data.empty() ){
        qDebug()<<"Couldn't load transferlist";
        return "";
    }

        QVariantMap transfer = mclient_transfer_data[index.row()];
        switch (role) {
        case transferamount:{

              return transfer["TransferAmount"]  ;
        }break;
        case transfername:
        {
           return  transfer["Title"];
        }break;
        case date:
        {
            return transfer["Date"];
        }break;
        case currency:
        {
            return transfer["Currency"];
        }break;

    }
    return QVariant();


}




QHash<int,QByteArray> Transfer_list::roleNames() const{
    QHash<int,QByteArray> roles;
    roles[transfername]="transfername";
    roles[transferamount]="transferamount";
    roles[date]="date";
    roles[currency]="currency";
    return roles;
}

