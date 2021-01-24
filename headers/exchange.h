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
    explicit Exchange(QObject *parent=nullptr);
//    Q_PROPERTY(QString amount READ getamount WRITE setamount NOTIFY amountChanged);
public slots:
    QString getheader(){return "Exchange your money";}
   QString setresult(const QVariant &converter_input,const QVariant &converter_output);
   void exchange(const Currency &inputcurrency, const Currency &outputcurrency);


   bool validate(const double &accountBalance);
private:
    Form * form=NULL;
    Data_base *db;

private:

};

#endif // EXCHANGE_H
