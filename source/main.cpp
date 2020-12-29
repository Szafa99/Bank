#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QMap>
#include <QMultiMap>
#include <QVector>

#include <headers/login.h>
#include <headers/transfer_list.h>
#include <headers/register.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    qmlRegisterType<Transfer_list>("Transfer_list",1,0,"Transfer_list");


    qRegisterMetaType<QVector<QVariantMap>>("transfertype");
    qRegisterMetaType<Register::Action_on_cell>("Action_on_cell");


    qmlRegisterUncreatableType<Register>("Action_enum", 1, 0, "Cell_action",
                                            "Not creatable as it is an enum type.");


    QQmlApplicationEngine engine;
    Session session;
    Login log(&session);
    Register reg;

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

    reg.setroot(engine.rootObjects().at(0));


    return app.exec();
}
