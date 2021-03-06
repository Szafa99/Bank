#include "headers/currency_list.h"




Currency_list::Currency_list(QObject *parent):
         QAbstractListModel(parent)
{
setList();


}

int Currency_list::getactivecurrencyindex() const
{
    return choosenCurrency;
}



Currency Currency_list::getactivecurrency()const
{
    return list.first();
}




bool Currency_list::hidelist()
{
    return displayonelement=!displayonelement;
}

void Currency_list::setactivecurrency(const int& newcurrency)
{

    if(newcurrency!=0)
        {
        choosenCurrency=newcurrency;
        swapRows(choosenCurrency,0);
        }
    emit choosencurrencyChanged();



}


int Currency_list::rowCount(const QModelIndex &parent)const
{
    if(parent.isValid())return 0;

    else if(displayonelement)
        return 1;
    else
        return list.size();

}

QVariant Currency_list::data(const QModelIndex &index, int role) const
{
    if(!index.isValid() && list.empty())
        return "";

    switch (role) {

    case AMOUNT:{
        return list.at(index.row()).amount;
    }break;

    case FILEPATH:{
        return list.at(index.row()).filePath;
    }break;

    case TYPE:{
    return list.at(index.row()).type;
    }break;

    case CONVERTER:{
        return list.at(index.row()).converter;
    }break;

    default:return "";
    }

}

QHash<int, QByteArray> Currency_list::roleNames() const
{
    QHash<int,QByteArray> roles;
    roles[AMOUNT]="amount";
    roles[FILEPATH]="filepath";
    roles[TYPE]="type";
    roles[CONVERTER]="converter";
    return roles;
}

void Currency_list::swapRows(const int &sourceindex, const int &destindex)
{
    list.swapItemsAt(sourceindex,destindex);
}



void Currency_list::setList()
{
    list.clear();
    QString clientid = Session::getclientId();
    Currency currency;
    Data_base *db=&Data_base::get_instance();

    //First the minor account of the user is inserted into the list
    currency.amount = db->getclient_data("AccountBalance",Data_base::clients,clientid);
    list.push_back(currency);

    // Then the currency accounts of the user are inserted into the list
        QStringList amount = db->getcolumn("AccountBalance",Data_base::currency_accounts,clientid);
        QStringList type = db->getcolumn("Currency",Data_base::currency_accounts,clientid);

        for(int i=0; i<type.size();i++ )
         {
            currency.amount=amount.at(i);
            currency.type=type.at(i);
            // return the exchangerate of the given currency
            currency.converter=db->getclient_data("ExchangeRate",Data_base::currencys,"Currency",type.at(i)).toDouble();
            currency.filePath="../images/"+currency.type+".jpg";
            list.push_back(currency);
         }
        emit choosencurrencyChanged();


}


void Currency_list::setallcurrency()
{
        list.clear();
        Currency currency;
        Data_base *db=&Data_base::get_instance();
        QStringList converter = db->getcolumn("ExchangeRate",Data_base::currencys);
        QStringList type = db->getcolumn("Currency",Data_base::currencys);

        for(int i=0; i<type.size();i++ )
             {
                currency.converter=converter.at(i).toDouble();
                currency.type=type.at(i);
                currency.filePath="../images/"+currency.type+".jpg";
                list.push_back(currency);
             }


}



