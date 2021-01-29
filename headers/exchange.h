#ifndef EXCHANGE_H
#define EXCHANGE_H

#include <QObject>
#include <headers/database.h>
#include <headers/formfactory.h>
struct Currency;
class Exchange:public QObject
{
    Q_OBJECT
public:
    //! In the constructor the data model is set
    explicit Exchange(QObject *parent=nullptr);

public slots:

    //! Returns the header of the exhange form
   QString getheader()const;

   //! Takes the exchange rate of two currencys, calculates the exchange and sets the result into the form object
   QString setresult(const QVariant &converter_input,const QVariant &converter_output);

   //! Upadates the data in the database about the currency accounts that took part in the exchange
   void exchange(const Currency &inputcurrency, const Currency &outputcurrency);

   //! Validates if the account balance is greater then the given sum to exchange
   bool validate(const double &accountBalance);
private:
   //! A pointer to a form object, that holds the data inputed by the user and
   //! handles the gui changes of the form
    Form * form=NULL;

    //!Points to the database object
    Data_base *db;

private:

};

#endif // EXCHANGE_H
