#ifndef REGISTER_H
#define REGISTER_H
#include <QRegularExpression>

#include "formfactory.h"
#include "form.h"


class Register:public QObject
{
  Q_OBJECT

public:

    //! Sets the data model of the form
    explicit Register(QObject *parent =nullptr);

    //! deletes the form object
    ~Register();


public slots:

    //! Inserts a new record with data about a new user into the database
    bool register_user();

    //! validates the data gicen by the user and displays error infos if data is not valid
    bool validet_input();

    //! Return the header of the form
    QString getheader(){return "Join BankName";}
private:

    //! Pointer the an form object
    Form *form=NULL;


public:

    //! Validates the given email
    bool validate_email(const QVariant&);

    //! Vaildates if form cells match. For instance cell named pin and checkpin
    bool check_match(const QVariant&);

    //! Validates the given pin
    bool validate_pin(const QVariant &);

    //! Validates the password
    bool validate_password(const QVariant &);

    //! Validates the given birthdate
    bool validate_birthdate(const QVariant &);

};
#endif // REGISTER_H
