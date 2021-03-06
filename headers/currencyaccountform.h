#ifndef CURRENCYACCOUNTFORM_H
#define CURRENCYACCOUNTFORM_H

#include <QObject>
#include <headers/currency_list.h>
#include <headers/database.h>
#include <headers/formfactory.h>

//!\class Provides data and validation of the data in a currency account form
class CurrencyAccountForm : public QObject
{
    Q_OBJECT
public:
    //! In contstructor a data model is set
    explicit CurrencyAccountForm(QObject *parent = nullptr);

    // In the destructor the form object is deleted
    ~CurrencyAccountForm();

public slots:

    //! Validates the data inputed by the user to the form
    bool validateInput();

    //! Add a new currency account to the database
    void addcurencyaccount();

    //! Returns the header that is seen at top of the form page
    QString getheader(){return "Create a currency account";}
private:
    //! A pointer to a form object, that holds the data inputed by the user and
    //! handles the gui changes of the form
    Form * form=NULL;

    //! Points to the database instance
    Data_base *db;

};

#endif // CURRENCYACCOUNTFORM_H
