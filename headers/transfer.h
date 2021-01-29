#ifndef TRANSFER_H
#define TRANSFER_H

#include <regex>
#include <QObject>
#include <headers/form.h>
#include <headers/formfactory.h>
#include <headers/session.h>
#include <headers/currency.h>
class Transfer: public QObject
{
    Q_OBJECT

 public:

    //! Sets the data model of the form
    explicit Transfer(QObject *parent=nullptr);

    //! delets the form object
    ~Transfer();
public slots:

    //! Returns the header of the form
    QString getheader(){return "Make a transfer";}

    //! Updates the data of the accounts that took part in the transfer
    bool make_transfer(const Currency & currency);

    //! Validates if the data given by the user is valid
    bool validet_input();

private:

    //! A pointer to a form object, that holds the data inputed by the user and
    //! handles the gui changes of the form
    Form *form=NULL;

    //! Points to the database instance
    Data_base *db ;
private:

    //! Validates the title of the transfer
    bool validateTitle(const QVariant&);

    //! Validate the account number of the reviever
    bool validateAccountNumber(const QVariant&);

    //! Validates the transfer amount given by the user
    bool validateTransferAmount(const QVariant&);

};


#endif // TRANSFER_H
