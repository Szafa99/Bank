#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QMap>
#include <QMultiMap>
#include <QVector>

#include <headers/login.h>
#include <headers/transfer_list.h>
#include <headers/register.h>
#include <headers/form.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    qmlRegisterType<Transfer_list>("Transfer_list",1,0,"Transfer_list");


    qRegisterMetaType<QVector<QVariantMap>>("transfertype");
    qRegisterMetaType<Form::Action_on_cell>("Action_on_cell");
    qmlRegisterType<Register>("Register",1,0,"Register");
    //qmlRegisterType<Form>("Form",1,0,"Form");


    qmlRegisterUncreatableType<Form>("Action_enum", 1, 0, "Cell_action",
                                            "Not creatable as it is an enum type.");


    QQmlApplicationEngine engine;
    Session session;
    Login log(&session);
    Register reg;

    engine.rootContext()->setContextProperty("Form",&Form::getInstance());
    engine.rootContext()->setContextProperty("Register",&reg);

    engine.rootContext()->setContextProperty("log",&log);
    engine.rootContext()->setContextProperty("session",&session);


    const QUrl url(QStringLiteral("qrc:qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    Form::getInstance().setroot(engine.rootObjects().at(0));


    return app.exec();
}
