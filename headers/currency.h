#ifndef CURRENCY_H
#define CURRENCY_H
#include <QDebug>
#include <QObject>

//! \struct This struct holda data about a currency
struct Currency{
        Q_GADGET
public:
    Currency():converter(1.0),type("PLN"),amount(""),filePath("../images/PLN.jpg"){}

    Q_PROPERTY(QString type MEMBER type);
    Q_PROPERTY(QString amount MEMBER amount);
    Q_PROPERTY(QString filePath MEMBER filePath);
    Q_PROPERTY(double converter MEMBER converter);

    //!  Says how mouch PLN's does the currency cost
        double converter;
    //! Stands for the type of the currency
        QString type;
    //! Holds the information about the amount to display
        QString amount;
    //! Holds the path to the image of the currencys flag
        QString filePath;
    };

Q_DECLARE_METATYPE(Currency)
#endif // CURRENCY_H
