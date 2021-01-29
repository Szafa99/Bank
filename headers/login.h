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

public:
    //! This method will log the user in and start a new session if username and pin are valid
    Q_INVOKABLE bool loguserin(const QString &pin,const QString &username);

public slots:

    //! Returns the pin inserted by the user
    QString getpin()const;

    //!Returns the username inserted by the user
    QString getusername()const;
    //! Returns the information about an error that occurred while loging in
    QString getloginerror()const;

    //! Sets the username inserted by the user
    bool setusername(const QString &name);

    //! Setsthe the pin inserted by the user
    bool setpin(const QString &newpin);
signals:

    //! This signal is emitted when a error occurred or was handled
    void loginerrorChanged();

    //! This signal is emitted when the username was changed
    void usernameChanged();

    //! This signal is emitted when the pin was changed
    void pinChanged();
private:

    //! Holds the id of the user that is being loged in
    QString clientid;

    //! Holds a pointer to a session object. Is used to expose the data of the client that was loged in
    Session *startsession;

    //! Holds a pointer to the database
    Data_base *client_db;

    //! Holds data about the pin
    QString pin;

    //! Holds data about the username
    QString username;

    //! Holds data about mistakes made by the user while login in
    QString loginerror;



};


#endif // LOGIN_H
