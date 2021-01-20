#ifndef CURRENCYACCOUNTFORM_H
#define CURRENCYACCOUNTFORM_H

#include <QObject>
#include <headers/currency_list.h>
#include <headers/database.h>
#include <headers/formfactory.h>
class CurrencyAccountForm : public QObject
{
    Q_OBJECT
public:
    explicit CurrencyAccountForm(QObject *parent = nullptr);
public slots:
    bool validateInput();
    void addcurencyaccount();

private:
    Form * form=NULL;
    Data_base *db;
private:
    bool currencyChoosen();
    bool alreadyexist();
};

#endif // CURRENCYACCOUNTFORM_H
