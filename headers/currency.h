#ifndef CURRENCY_H
#define CURRENCY_H
#include <QDebug>
#include <QObject>


struct Currency{
        Q_GADGET
public:
    Currency():converter(1.0),type("PLN"),amount(""),filePath("../images/PLN.jpg"){}

    Q_PROPERTY(QString type MEMBER type);
    Q_PROPERTY(QString amount MEMBER amount);
    Q_PROPERTY(QString filePath MEMBER filePath);
    Q_PROPERTY(double converter MEMBER converter);

  //  operator= (const Currency& other);
        double converter;
        QString type;
        QString amount;
        QString filePath;
    };

Q_DECLARE_METATYPE(Currency)
#endif // CURRENCY_H
