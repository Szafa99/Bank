import QtQuick 2.0
import Action_enum 1.0
import QtQuick.Controls 2.12
import Transfer 1.0


Item{
    anchors.fill: parent

    // here is a transfer object created which contains a form object to control the content of this qmlfile


    Row{
        anchors.fill: parent
        spacing:5
    Rectangle{
        id: first_page
        width: parent.width*0.5
        height: parent.height
        color: nextmousearea.pressed ? "darkred" : "red"
        radius:10
        Text{
            anchors.centerIn: parent
            color:"white"
            text: "Abort"

        }
        MouseArea
        {
            id:nextmousearea
            anchors.fill: parent
            onClicked: {
                formtype.destroy()
                mainpage.source="qrc:/qml/mainwindow.qml"
            }

        }
    }
    Rectangle{
        id: backtologin
        width: parent.width*0.5
        height: parent.height
        color: backtologinarea.pressed ? "darkred" : "red"
        radius:10
        Text{
            fontSizeMode:Text.HorizontalFit
            anchors.centerIn: parent
            color:"white"
            text: "Send Transfer"

        }
        MouseArea
        {
            id:backtologinarea
            anchors.fill: parent
            onClicked: {
                if(formtype.validet_input() && formtype.make_transfer(users_currencys.getactivecurrency()) )
                {                   
                    session.settransfers(); // set the uodated new transfer list
                    users_currencys.setList(); // set the updated currency list
                    session.setcurrency(users_currencys.getactivecurrency()) // set the active currency
                    users_currencys.destroy()
                    formtype.destroy()
                    mainpage.source="qrc:/qml/mainwindow.qml"
                }
            }
        }

        }
    }
}




