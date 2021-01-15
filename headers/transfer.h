#ifndef TRANSFER_H
#define TRANSFER_H

#include <regex>
#include <QObject>
#include <headers/form.h>
#include <headers/formfactory.h>
#include <headers/session.h>

class Transfer: public QObject
{
    Q_OBJECT

 public:
    explicit Transfer(QObject *parent=nullptr);
    ~Transfer();
public slots:


    bool make_transfer();
    bool validet_input();
private:
    Form *form=NULL;
    Data_base *db ;
private:
    bool validateTitle(const QVariant&);
    bool validateAccountNumber(const QVariant&);
    bool validateTransferAmount(const QVariant&);

public:


};


#endif // TRANSFER_H
