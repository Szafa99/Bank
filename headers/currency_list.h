#ifndef CURRENCY_LIST_H
#define CURRENCY_LIST_H

#include <QAbstractListModel>
#include <QObject>
#include <headers/database.h>
#include <headers/session.h>
#include <headers/currency.h>



class Currency_list : public QAbstractListModel
{
    Q_OBJECT
public:

    //!Creates a list-view model, and sets the currency list of the user fetched from the database as the data of the model
    explicit Currency_list(QObject *parent = nullptr);

    Q_PROPERTY(int choosencurrency READ getactivecurrencyindex WRITE setactivecurrency NOTIFY choosencurrencyChanged);

    //! This method overwrites the current data model with all currencys available in the database.
    //! \bNOTE - Reset the listview model after datamodel was overwriten\b
    Q_INVOKABLE void setallcurrency();

    //! This method overwrites the current data model with currencys available for the user.
    //! \bNOTE - Reset the listview model after datamodel was overwriten\b
    Q_INVOKABLE void setList();

    //! \enum Roles
    //! This enum is used to call the right datatype in the data() method from qml level
    //!  \value Type - reffers to the currency type
    //!  \value Amount - reffers to account ballance of the given currency
    //!  \value Filepath - reffers to the filepath of the image that stands for the currency
    //!  \value Converter -  how much PLN's does this currency cost
     enum Roles{
        TYPE, AMOUNT,FILEPATH,CONVERTER
    };

public slots:

    //! Returns how many elements are in the list
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    //! Returns the data about a currency
    //! \param role says witch data specified in qml to return
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    //!Hashes the enum Roles with the names after which the needed data is called from qml
    virtual QHash<int,QByteArray> roleNames() const override;

    //! Swaps two given rows. NOTE - reset the model after this method was called
    void swapRows(const int &sourceindex,const int &destindex);

    //! Sets the given currency as the new one
    void setactivecurrency(const int& newcurrency);

//! Returns the index of the listelement choosen from the currency list
    int getactivecurrencyindex()const;

//! Returns the first currency structure from the currency list
    Currency getactivecurrency()const;


//! Call to hide ot unhide the list - toggles the boolean that holds data whether display one or all elements of the list
    bool hidelist();

signals:
   //!This signal should be emited when the currency index of the choosen currency has changed
    void choosencurrencyChanged();

private:
    //! Holds the data of the list view model
    QList<Currency> list;

    //! Stands for the index of the choosen currency. By default none is choosen
    int choosenCurrency=-1;

    //! Says wheter one or all elements of the list should be displayed. Toglled by hidelist()
    bool displayonelement=false;

};

#endif // CURRENCY_LIST_H
