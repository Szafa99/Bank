#ifndef FORM_H
#define FORM_H
#include <QObject>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickItem>


class Form: public QObject
{
    friend class Register;
    Q_OBJECT
    Q_ENUMS(Action_on_cell)
public:
    static Form& getInstance(){
        static Form form;
        return form;
    };
    Form(Form const&)=delete;
    void operator=(Form const&)=delete;

private:
    Form(QObject *parent = nullptr):QObject(parent) {}

public:
    Q_PROPERTY(QVariantMap form MEMBER mform NOTIFY formChanged)
    Q_PROPERTY(QVariantMap form_edited MEMBER mform_edited NOTIFY form_editedChanged)
    Q_PROPERTY(QVariantMap error_info MEMBER merrorinfo NOTIFY error_infoChanged)

    enum Action_on_cell{
        Data_changed,
        Clicked,
        Editing_Finished
    };
public slots:
    void setForm( const QVariantMap & value,Action_on_cell action);
    QVariant get_form_cell(QString key);
    QVariant get_error_info();
    void update();
signals:
    void formChanged();
    void form_editedChanged();
    void error_infoChanged();
public:
     void setroot(QObject *engineroot);
private:
     void validet_input();

private:
    QObject * registergui=NULL;
    QQuickItem * lastcell;
    QVariantMap mform;
    QVariantMap mform_edited;
    QVariantMap merrorinfo;

};
Q_DECLARE_METATYPE(Form::Action_on_cell)
#endif // FORM_H
