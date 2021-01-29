import QtQuick 2.0
import QtQuick.Layouts 1.3

Item{

    anchors.fill: parent
    anchors.horizontalCenter: parent.horizontalCenter
    property int buttonwidth: width/3
    Row{
        id: last_page
        anchors.fill: parent
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 5

        Rectangle{
            height: parent.height
            width: buttonwidth
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
                    formcontent_nav="qrc:/qml/first_form_nav.qml"
                    formcontent="qrc:/qml/user_info_form.qml"
                }
            }
        }
        Rectangle{
            height: parent.height
            width: buttonwidth
            color: backloginmousearea.pressed ? "darkred" : "red"
            radius:10
            Text{
               fontSizeMode:Text.HorizontalFit
                anchors.centerIn: parent
                color:"white"
                text: "Back to login"
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
            width: buttonwidth
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
                  if(formtype.validet_input() && formtype.register_user() ){

                      formtype.destroy()
                     mainpage.source="qrc:/qml/login.qml"
                  }
                    }
            }
        }

    }

}



