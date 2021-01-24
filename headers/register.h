#ifndef REGISTER_H
#define REGISTER_H
#include <QRegularExpression>

#include "formfactory.h"
#include "form.h"


class Register:public QObject
{
  Q_OBJECT

public:
    explicit Register(QObject *parent =nullptr);
    ~Register(){delete form;};


public slots:
    bool register_user();
    bool validet_input();
     QString getheader(){return "Join BankName";}
private:
    Form *form=NULL;


public:
    bool validate_email(const QVariant&);
    bool check_match(const QVariant&);
    bool validate_pin(const QVariant &);
    bool validate_password(const QVariant &);
    bool validate_birthdate(const QVariant &);

};
#endif // REGISTER_H
