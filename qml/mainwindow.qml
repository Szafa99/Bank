
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12



Window {
    id:root
    minimumHeight: 180
    minimumWidth: 340
    width: 640
    height: 480
    visible: true
    title: qsTr("Log in")

    Text {
        id: text1
        x: 262
        y: 20
        width: 232
        height: 32
        visible: true
        color: "#f7f6f6"
        text: qsTr("Hello,clientname")
        font.pixelSize: 30
        anchors.horizontalCenter: parent.horizontalCenter
        transformOrigin: Item.Center
        z: 1
        clip: false
    }

    Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: 640
        height: 166
        color: "#626262"

        Text {
            id: text2
            x: 118
            y: 69
            width: 158
            height: 28
            color: "#eae9e9"
            text: qsTr("Available founds:")
            font.pixelSize: 17
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: text3
            x: 252
            y: 90
            width: 136
            height: 26
            text: qsTr("loaddatafrom databse")
            font.pixelSize: 12
        }

        ListView {
            id: listView
            x: 29
            y: 226
            width: 566
            height: 200
            delegate: Item {
                x: 5
                width: parent.width
                height: 40
                Row {
                    anchors.fill: parent
                    id: row1
                    Rectangle {
                        width: parent.width
                        height: 2
                        color: "grey"

                    }


                    Text {
                        id:datetxt
                        text: Date +" : "
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        anchors.left: datetxt.right
                        anchors.leftMargin: 5
                        text: transfername
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                    }
                    Text {
                        text: transferamount
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        font.bold: true
                    }

                    spacing: 10
                }
            }
            model: ListModel {
                ListElement {
                    transfername: "mcdonalds"
                    transferamount: "44 PLN"
                    Date: "26.02.2020"

                }

                ListElement {
                    transfername: "mcdonalds"
                    transferamount: "44 PLN"
                    Date: "26.02.2020"
                }

                ListElement {
                    transfername: "mcdonalds"
                    transferamount: "44 PLN"
                    Date: "26.02.2020"
                }

                ListElement {
                    transfername: "mcdonalds"
                    transferamount: "44 PLN"
                    Date: "26.02.2020"
                }
            }
        }

        ItemDelegate {
            id: itemDelegate
            x: -379
            y: 118
            text: qsTr("Item Delegate")
        }

        Row {
            id: row
            x: 0
            y: 147
            width: 640
            height: 33
        }

        Rectangle{
            x: 57
            y: 147

            radius: width/2
            color: "white"
            width: 50
            height: 50
            clip:false
            Image {
                anchors.centerIn: parent
                id: image
                source: "../images/transfersign.png"
                width: parent.width/1.5
                height:width
                // fillMode: Image.PreserveAspectFit
            }
        }
        Image {
            id: image1
            x: 298
            y: 147
            width: 44
            height: 33
            source: "qrc:/qtquickplugin/images/template_image.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: image2
            x: 521
            y: 147
            width: 50
            height: 33
            source: "qrc:/qtquickplugin/images/template_image.png"
            fillMode: Image.PreserveAspectFit
        }
    }

    Text {
        id: text4
        x: 12
        y: 194
        width: 366
        height: 30
        text: qsTr("Recent operations:")
        font.pixelSize: 12
        minimumPixelSize: 21
    }


}



