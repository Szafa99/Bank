#include "headers/formfactory.h"




FormFactory &FormFactory::getInstance()
{
        static FormFactory factory;
        return factory;
}

Form * FormFactory::CreateForm(QString qmlObjectName)
{
        if(!QmlEngine)
            return NULL;
        else{
            Form *form =new Form(nullptr,QmlEngine);
            appEngine->rootContext()->setContextProperty(qmlObjectName,form);
            return form;
        }
}

void FormFactory::setAppEngine(QQmlEngine *engine)
{
    if(engine)
    appEngine=engine;
}

void FormFactory::setQmlEngine(QObject *engine)
{
        QmlEngine=engine;
};
