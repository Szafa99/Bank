#ifndef REGISTER_H
#define REGISTER_H
#include <QRegularExpression>

#include "form.h"
#include "database.h"



class Register:public QObject
{
  Q_OBJECT
//    Q_ENUMS(Action_on_cell)
public:

//    enum Action_on_cell{
//        Data_changed,
//        Clicked,
//        Editing_Finished,
//        Date
//    };

    // key is name of form_cell | value is what the user has written to the cell
//    Q_PROPERTY(QVariantMap form MEMBER mform NOTIFY formChanged)
//    Q_PROPERTY(QVariantMap form_edited MEMBER mform_edited NOTIFY form_editedChanged)
//    Q_PROPERTY(QVariantMap error_info MEMBER merrorinfo NOTIFY error_infoChanged)


    explicit Register(QObject *parent =nullptr);


public slots:
//    void setForm( const QVariantMap & value,Action_on_cell action);
//    QVariant get_form_cell(QString key);
//    QVariant get_error_info();
//    void update();
    bool register_user();
    bool validet_input();
private:
    Form *form=NULL;


//signals:
//    void formChanged();
//    void form_editedChanged();
//    void error_infoChanged();


//private:
//    QObject *registergui=NULL;
//    QQuickItem *lastcell;
//    QVariantMap mform;
//    QVariantMap mform_edited;
//    QVariantMap merrorinfo;
public:
   // void setroot(QObject *engineroot);
    bool validate_email(const QVariant&);
    bool check_match(const QVariant&);
    bool validate_pin(const QVariant &);
    bool validate_password(const QVariant &);
    bool validate_birthdate(const QVariant &);
};
//Q_DECLARE_METATYPE(Register::Action_on_cell)




#endif // REGISTER_H
