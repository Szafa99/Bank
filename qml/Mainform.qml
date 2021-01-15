import QtQuick 2.12
import QtQuick.Controls 2.12
import Transfer 1.0
import Register 1.0


Item {
    id:root
    anchors.fill: parent

    Rectangle{
        id:border_rec
        anchors.fill: parent
        border.color: "lightgrey"
        border.width: 5


        Label{
            id: createlabel
            height: root.height/14
            anchors.top: border_rec.top
            anchors.topMargin: user_interface_rec.y*0.1
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: height
            text: "Create account with NameBank"
        }

        Rectangle{

            id:user_interface_rec
            clip: true
            anchors.top:createlabel.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: createlabel.height*0.5
            anchors.bottomMargin: createlabel.height*1.5
            anchors.horizontalCenter: createlabel.horizontalCenter
            radius: 5
            border.width:2
            z:1
            border.color: "red"
            width: root.width/2.2

            /////////////////////////////////////////////////////Load form
Column{

    anchors.fill: parent
     anchors.margins: 10
    spacing: 2
    Loader{
                id: formloader
                width: parent.width
                height: parent.height*0.95
                focus: true
                source: formcontent

            }

            Label{
                id:errorinfo
                width: parent.width
                height: parent.height*0.5
                anchors.horizontalCenter:parent.horizontalCenter

                fontSizeMode: Text.HorizontalFit
                font.bold:true
                text: Form.get_error_info()
                color: "red"

            }

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
            source: formcontent_nav



        }
    }

}
