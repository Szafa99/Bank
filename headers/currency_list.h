#ifndef CURRENCY_LIST_H
#define CURRENCY_LIST_H

#include <QAbstractListModel>
#include <QObject>
#include <headers/database.h>
#include <headers/session.h>

struct Currency{

    double converter=1.0;
    QString type="PLN";
    QString amount;
    QString filePath="../images/PLN.jpg";
};


class Currency_list : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit Currency_list(QObject *parent = nullptr);

    Q_PROPERTY(int choosencurrency READ getactivecurrency WRITE setactivecurrency NOTIFY choosencurrencyChanged);

    Q_INVOKABLE void setallcurrency();

    enum Roles{
        TYPE, AMOUNT,FILEPATH,CONVERTER
    };
public slots:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    virtual QHash<int,QByteArray> roleNames() const override;

    void swapRows(const int &sourceindex,const int &destindex);

    void setactivecurrency(const int& newcurrency);
    int getactivecurrency()const;
    QString getcurrencyName()const;

    bool hidelist();
signals:
    void choosencurrencyChanged();

private:
    QList<Currency> list;
    int choosenCurrency=-1;
    bool currecychoosen=false;
    bool displayonelement=false;
private:
    void setList();
};

#endif // CURRENCY_LIST_H
