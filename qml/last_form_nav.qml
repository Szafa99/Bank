import QtQuick 2.0
import QtQuick.Layouts 1.3

Item{
    anchors.fill: parent
    property string lastobject:""
    Row{
        id: last_page
        anchors.fill: parent
        spacing: 2

        Rectangle{
            height: parent.height
            width: parent.width/2
            color: backmousearea.pressed ? "darkred" : "red"
            radius:10
            Text{
                anchors.centerIn: parent
                color:"white"
                text: "Go Back"
            }

            MouseArea
            {
                id:backmousearea
                anchors.fill: parent
                onClicked: {
                    Form.update()
                    navigationloader.source="qrc:/qml/first_form_nav.qml"
                    formloader.source="qrc:/qml/user_info_form.qml"
                }
            }
        }

        Rectangle{
            height: parent.height
            width: parent.width/2
            color: registermousearea.pressed ? "darkred" : "red"
            radius:10
            Text{
                anchors.centerIn: parent
                color:"white"
                text: "register account"
            }

            MouseArea
            {
                id:registermousearea
                anchors.fill: parent
                onClicked: {
                      Form.update()
                  if(Register.validet_input() && Register.register_user() )
                     mainpage.source="qrc:/qml/login.qml"
                    }

            }
        }

    }

}



