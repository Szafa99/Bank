#include "headers/transfer_list.h"




int Transfer_list::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    // FIXME: Implement me!
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
        }
        case transfername:
        {
           return  transfer["Title"];
        }
        case Date:
        {
            return transfer["Date"];
        }

    }
    return QVariant();


}

bool Transfer_list::insertRows(int row, int count, const QModelIndex &parent)
{
    beginInsertRows(parent, row, row + count - 1);

    // FIXME: Implement me!
    endInsertRows();
}


QHash<int,QByteArray> Transfer_list::roleNames() const{
    QHash<int,QByteArray> roles;
    roles[transfername]="transfername";
    roles[transferamount]="transferamount";
    roles[Date]="Date";
    return roles;
}

