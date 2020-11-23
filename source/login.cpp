#include <headers/login.h>


Login::Login(QObject *parent):
    QObject(parent),
    client_db(new Data_base("localhost","root","","bank_clients","QMYSQL") ),
    pin("1234"),
    username("kowalski@gmail.com")
{


}

Login::~Login()
{
    delete client_db;
}


bool Login::setpin(const QString &mpin)
{    

    if(pin.length()==4)
    {
        pin=mpin;
        emit pinChanged();
        return true;
    }
    else{
        pin=mpin;
        emit pinChanged();
        loginerror="Pin must have 4 digits";
        emit loginerrorChanged();
        return false;
    }
}


bool Login::setusername(const QString &musername){

    loginerror.clear();
     username=musername;
        emit loginerrorChanged();
    bool contains_at,contains_dot=false;
    for(int i =0;i<musername.length();i++)
    {
        if(musername[i]=="." && contains_at)contains_dot=true;
        if(musername[i]=="@")contains_at=true;
    }
    if(!contains_at || !contains_dot){
        loginerror+="Email is incorret";
                emit loginerrorChanged();
        return false;
    }
    else {
        return true;
    }
}


bool Login::loguserin(const QString &mpin,const QString &musername)
{
    qDebug()<<"username:"<<musername<<" pin :"<<mpin;
    if(setusername(musername) && setpin(mpin) && client_db->validet_user(musername,mpin)){
        return true;
    }

    else{
        loginerror="Wrong pin or username";
        emit loginerrorChanged();
        return false ;
    }
}













