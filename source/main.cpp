#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QVector>

#include <headers/login.h>
#include <headers/transfer_list.h>
#include <headers/register.h>
#include <headers/form.h>
#include <headers/formfactory.h>
#include <headers/transfer.h>
 QString Session::client_id=0;
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    qmlRegisterType<Transfer_list>("Transfer_list",1,0,"Transfer_list");


    qRegisterMetaType<QVector<QVariantMap>>("transfertype");
    qRegisterMetaType<Form::Action_on_cell>("Action_on_cell");
    qmlRegisterType<Transfer>("Transfer",1,0,"Transfer");
    qmlRegisterType<Register>("Register",1,0,"Register");

    qmlRegisterUncreatableType<Form>("Action_enum", 1, 0, "Cell_action",
                                            "Not creatable as it is an enum type.");


    QQmlApplicationEngine engine;
    FormFactory::getInstance().setAppEngine(&engine);

    Session session;
    Login log(&session);



    engine.rootContext()->setContextProperty("log",&log);
    engine.rootContext()->setContextProperty("session",&session);


    const QUrl url(QStringLiteral("qrc:qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    FormFactory::getInstance().setQmlEngine(engine.rootObjects().at(0));
//    Register reg;
//    engine.rootContext()->setContextProperty("Register",&reg);




    return app.exec();
}
