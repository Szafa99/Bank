#ifndef REGISTER_H
#define REGISTER_H
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickItem>
#include <QtWidgets/QInputDialog>

#include "database.h"



class Register: public QObject
{
    Q_OBJECT
    Q_ENUMS(Action_on_cell)
public:

    enum Action_on_cell{
        Data_changed,
        Clicked,
        Editing_Finished
    };

    // key is name of form_cell | value is what the user has written to the cell
    Q_PROPERTY(QVariantMap form MEMBER mform NOTIFY formChanged)
    Q_PROPERTY(QVariantMap form_edited MEMBER mform_edited NOTIFY form_editedChanged)


    explicit Register(QObject *parent = nullptr);


public slots:
    void setForm( const QVariantMap & value,Action_on_cell action);

    QVariant get_form_cell(QString key);


signals:
    void formChanged();
    void form_editedChanged();


private:
    QObject *registergui=NULL;
    QVariantMap mform;
    QVariantMap mform_edited;
public:
    void setroot(QObject *engineroot);


};
Q_DECLARE_METATYPE(Register::Action_on_cell)




#endif // REGISTER_H
