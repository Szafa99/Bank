import QtQuick.Window 2.12
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
//import Action_enum 1.0

Window {
    id:root
    minimumHeight: 180
    minimumWidth: 340
    width: 640
    height: 480
    visible: true
    title: qsTr("Welcome!")




    Rectangle{
        id:border_rec
        anchors.fill: parent
        border.color: "lightgrey"
        border.width: 5


        Label{
            id: createlabel
            height: root.height/14
            anchors.top: border_rec.top
            anchors.topMargin: user_interface_rec.y/2
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: height
            text: "Create an account with BankName"
        }

        Rectangle{

            id:user_interface_rec
            clip: true
            anchors.top:createlabel.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: 10
            anchors.bottomMargin: 50
            anchors.horizontalCenter: createlabel.horizontalCenter
            radius: 5
            border.width:2
            z:1
            border.color: "red"
            width: root.width/2.2

            /////////////////////////////////////////////////////Load form

            Loader{
                id:formloader
                anchors.fill: parent
                focus: true
                source: "qrc:/qml/user_info_form.qml"

            }
        }
    }
    //=============================================================================
    Rectangle {
        height: root.height*0.08
        width: root.width * 0.4
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: root.height * 0.01

        Loader{
            id:navigationloader
            anchors.fill: parent
            focus: true

            source: "qrc:/qml/first_form_nav.qml"
        }
    }

}
