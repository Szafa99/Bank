#ifndef LOGIN_H
#define LOGIN_H
#include <QObject>
#include <headers/database.h>
#include <headers/session.h>
#include<QQmlApplicationEngine>
#include <QQmlContext>



class Login:public QObject{

    Q_OBJECT

    Q_PROPERTY(QString pin READ getpin WRITE setpin NOTIFY pinChanged);
    Q_PROPERTY(QString username READ getusername WRITE setusername NOTIFY usernameChanged);
    Q_PROPERTY(QString loginerror READ getloginerror NOTIFY loginerrorChanged);



public:
    explicit Login(Session *session=nullptr,QObject *parent = nullptr);
      ~Login();
public:
    Q_INVOKABLE bool loguserin(const QString &pin,const QString &username);

public slots:
    QString getpin()const{return pin;};
    QString getusername()const{return username;};
    QString getloginerror()const{return loginerror;}
    bool setusername(const QString &name);
    bool setpin(const QString &newpin);
signals:
    void loginerrorChanged();
    void usernameChanged();
    void pinChanged();
private:
    QString clientid;
    Session *startsession;
    Data_base *client_db;
    QString pin;
    QString username;
    QString loginerror;



};


#endif // LOGIN_H
