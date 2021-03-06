import QtQuick 2.0
import Action_enum 1.0
import QtQuick.Controls 2.12
import Transfer 1.0


Item{
    anchors.fill: parent



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
                text: "Create account"

            }
            MouseArea
            {
                id:backtologinarea
                anchors.fill: parent
                onClicked: {
                        if(formtype.validateInput())
                        {
                            formtype.addcurencyaccount()
                            formtype.destroy()
                            mainpage.source="qrc:/qml/mainwindow.qml"
                        }
                }
            }

        }
    }
}




