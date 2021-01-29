#ifndef FORMFACTORY_H
#define FORMFACTORY_H
#include "form.h"
#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include <QQmlContext>


class Form;
//! \class FormFactory is an singelton which creates form object and makes them available to qml
class FormFactory
{
public:

    //! this method returns a instance of a formfactory
    static FormFactory &getInstance();
public:

        //! This method should be called to created a form object. It makes the object available to qml
        Form * CreateForm(QString qmlObjectName);

        //! Call this method from main to set the appegine
        void setAppEngine(QQmlEngine *engine);

        //! Call this method from main to set the qmlegine
        void setQmlEngine(QObject *engine);

        //! This is a singleton. Can't make copy of this object
        FormFactory(FormFactory const&)=delete;

        //! This is a singleton. Can't make copy of this object
        void operator=(FormFactory const&)=delete;

private:
        //! This is a singleton, the contstructor is private
        FormFactory(){};
private:
        //! Point to the qml engine
        QObject *QmlEngine=NULL;

        //! Points to the app enigne
        QQmlEngine * appEngine=NULL;
};

#endif // FORMFACTORY_H
