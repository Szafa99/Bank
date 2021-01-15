#ifndef FORMFACTORY_H
#define FORMFACTORY_H
#include "form.h"
#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include <QQmlContext>


class Form;
class FormFactory
{
public:
    static FormFactory& getInstance()
        {
            static FormFactory factory;
            return factory;
        };
public:
        Form * CreateForm(QString qmlObjectName);
        void setAppEngine(QQmlEngine *engine);
        void setQmlEngine(QObject *engine);
        FormFactory(FormFactory const&)=delete;
        void operator=(FormFactory const&)=delete;

private:
        FormFactory(){};

private:
        QObject *QmlEngine=NULL;
        QQmlEngine * appEngine=NULL;
};

#endif // FORMFACTORY_H
