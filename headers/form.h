#ifndef FORM_H
#define FORM_H
#include <QObject>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickItem>
#include "database.h"

class Form: public QObject
{
//    friend class Register;
//    friend class Transfer;
    friend class FormFactory;
//    friend class CurrencyAccountForm;
//    friend class Exchange;

    Q_OBJECT
    Q_ENUMS(Action_on_cell)
private:
    //! Form is private so that a form object can be created only by the from factory
    //! in the constructor a pointer to the qmlengine is set in order to manipulet qml properties
    Form(QObject *parent = nullptr,QObject *qmlengine=nullptr);

public:
    Q_PROPERTY(QVariantMap form MEMBER mform NOTIFY formChanged)
    Q_PROPERTY(QVariantMap form_edited MEMBER mform_edited NOTIFY form_editedChanged)
    Q_PROPERTY(QVariantMap error_info MEMBER merrorinfo NOTIFY error_infoChanged)

    //! This enum is used to handle the corensponding action on a cell
    enum Action_on_cell{
        Data_changed,
        Clicked,
        Editing_Finished
    };
public slots:

    //! Call this method if you want to pass a given value under the given key to the map without validation
    void forcedInput(const QVariant &value,const QString &key);

    //! Call this method with on of the action described in the enum Action_on_cell, to change and validated the data
    //! This method handles the user interaction if validation succeeded or failed
    //! @param value a map which key describes which form to edit and the value of the map is the data that should be processed
    void setForm( const QVariantMap & value,Action_on_cell action);

    //! Call this method to get the data from the form cell under the given key
    QVariant get_form_cell(QString key);

    //! this method returns information about the last error
    QVariant get_error_info();

    //! this method updates the lastcell that the user interacted with
    void update();
signals:

    //! this signal is emited when a form cell has changed
    void formChanged();

    //! this signal is emited when a form cell was edited
    void form_editedChanged();

    //! this signal is emited when a new error occurred info was added or handled by the user
    void error_infoChanged();
public:

    //! this method is used to set the data model. The data should come from an class that contains the form
     void setmodel(Data_base::dbtables tablename);
public:

     //! This method validates if data was inserted into the form cells. The class that contains an form object should implement a method
     //! that validates the data given by the user.
     //! NOTE! - this method won't be called for data that was inserted to the formcells using the forcedInputmethod()
     void validet_input();

    //! A pointer to the qml engine. Used to manipulate qml properties
    QObject * registergui=NULL;

    //! A pointer to the lastcell that the user interacted with.
    QQuickItem * lastcell;

    //! Holds the data that is inserted into the form cells
    QVariantMap mform;

    //! Holds the information whether an form cell was editet by the user or not
    QVariantMap mform_edited;

    //! Holds the information about the mistakes that the user made while inserting his data
    QVariantMap merrorinfo;

};
Q_DECLARE_METATYPE(Form::Action_on_cell)
#endif // FORM_H
