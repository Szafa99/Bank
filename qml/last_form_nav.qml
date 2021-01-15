import QtQuick 2.0
import QtQuick.Layouts 1.3

Item{
    anchors.fill: parent

    Row{
        id: last_page
        anchors.fill: parent
        anchors.centerIn: parent
        spacing: 2

        Rectangle{
            height: parent.height
            width: parent.width*0.4
            color: backmousearea.pressed ? "darkred" : "red"
            radius:10
            Text{
                anchors.centerIn: parent
                color:"white"
                text: "Go Back"
                fontSizeMode:Text.HorizontalFit
            }

            MouseArea
            {
                id:backmousearea
                anchors.fill: parent
                onClicked: {
                    Form.update()
                    formcontent="qrc:/qml/first_form_nav.qml"
                    formcontent_nav="qrc:/qml/user_info_form.qml"
                }
            }
        }
        Rectangle{
            height: parent.height
            width: parent.width*0.4
            color: backloginmousearea.pressed ? "darkred" : "red"
            radius:10
            Text{
               fontSizeMode:Text.HorizontalFit
                anchors.centerIn: parent
                color:"white"
                text: "Log in"
            }

            MouseArea
            {
                id:backloginmousearea
                anchors.fill: parent
                onClicked: {
                    mainpage.source="qrc:/qml/login.qml"
                }
            }
        }

        Rectangle{
            height: parent.height
            width: parent.width*0.4
            color: registermousearea.pressed ? "darkred" : "red"
            radius:10
            Text{
                fontSizeMode:Text.HorizontalFit
                anchors.centerIn: parent
                color:"white"
                text: "Register Account"
            }

            MouseArea
            {
                id:registermousearea
                anchors.fill: parent
                onClicked: {
                      Form.update()
                  if(formtype.validet_input() && formtype.register_user() )

                      formtype.destroy()
                     mainpage.source="qrc:/qml/login.qml"
                    }
            }
        }

    }

}



