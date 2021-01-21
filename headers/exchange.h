#ifndef EXCHANGE_H
#define EXCHANGE_H

#include <QObject>
#include <headers/database.h>
#include <headers/formfactory.h>

class Exchange:public QObject
{
    Q_OBJECT
public:
    explicit Exchange(QObject *parent=nullptr);
public slots:
   QString getresult(QString amount,double converter);

private:
    Form * form=NULL;
    Data_base *db;
private:

};

#endif // EXCHANGE_H
