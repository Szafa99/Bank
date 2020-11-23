import QtQuick 2.12
import QtQuick.Window 2.12

Window {


    id:root
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")


    Rectangle
    {
        id: calculator
        anchors.fill:parent
        color: "#c4c4c4"
        border
        {
            width: 10
            color: "#5e6360"
        }


        Flipable{
            id: square
            anchors.centerIn: parent
            width:root.height/4
            height: root.height/4
            property bool flipped: false

            front:Rectangle{
                anchors.centerIn: parent
                width:root.height/4
                height: root.height/4
                color: "darkred"

            }
            back:Rectangle{
                anchors.centerIn: parent
                width:root.height/4
                height: root.height/4
                color: "red"
            }

            transform: Rotation
            {
                axis.x:1;axis.y:1;axis.z:1
                angle: square.flipped ? 180 : 0

                origin.y: square.height/2
                origin.x: square.width/2
             
                Behavior on angle
                {
                    NumberAnimation{duration: 500}
                }
            }

            MouseArea{
                anchors.fill: parent
                onClicked: square.flipped=!square.flipped
            }


        }

    }


}
