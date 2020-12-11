#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <headers/login.h>
#include <headers/transfer_list.h>
#include <QVector>
#include <QMap>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    qmlRegisterType<Transfer_list>("Transfer_list",1,0,"Transfer_list");

    qRegisterMetaType<QVector<QVariant>>("transfertype");


    QQmlApplicationEngine engine;
//    Session session;
//    Login log(&session);

//    engine.rootContext()->setContextProperty("log",&log);
//    engine.rootContext()->setContextProperty("session",&session);


    const QUrl url(QStringLiteral("qrc:qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);



    return app.exec();
}
