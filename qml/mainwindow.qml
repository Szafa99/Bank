import QtQuick 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import QtQuick.Window 2.12
import Transfer_list 1.0



Window {
    id:root
    minimumHeight: 180
    minimumWidth: 340
    width: 640
    height: 480
    visible: true
    title: qsTr("Welcome!")


    Rectangle{
        id:generallinforec
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: root.height/3
        color: "#626262"
        ColumnLayout{

            id:generallinfo
            anchors.fill:parent
            anchors.margins: 10

            Text {
                id: firstname
                width:text.width
                height: generallinfo.height/12
                color: "#f7f6f6"
                text: "Hello,"+ session.get_data_from_clients_table("FirstName")
                font.pixelSize: height
                anchors.horizontalCenter: parent.horizontalCenter

            }



            Text {
                id: balance1

                width:text.width
                height: generallinfo.height/12
                color: "#eae9e9"
                text: qsTr("Your account balance:")
                font.pixelSize: height
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id:balance2
                width:text.width
                height: balance1.height
                anchors.horizontalCenter: parent.horizontalCenter
                text: session.get_data_from_clients_table("acountbalance")
                font.pixelSize:height
                color: "#eae9e9"
            }
            // buttons of maketransfer and so on
            RowLayout{
                Layout.alignment: Qt.AlignBottom
                anchors.left: balance1.left
                Layout.fillWidth: true
                height:firstname.height
                anchors.margins: 2
                Rectangle{
                    id:signmask
                    width: balance1.width/6
                    height: width
                    radius: width/2
                    clip: true
                    visible: false
                }
                        Image {
                            id: transferimage
                            anchors.fill:signmask
                            source: "../images/transfersign.png"
                            fillMode: Image.PreserveAspectCrop
                                    layer.enabled: true
                                    layer.effect: OpacityMask {
                                        maskSource: signmask
                                    }
                                }

                            Image {
                                id: menuimage
                                width: transferimage.width
                                height: transferimage.height

                            source: "../images/transfersign.png"
                            fillMode: Image.PreserveAspectCrop
                                    layer.enabled: true
                                    layer.effect: OpacityMask {
                                        maskSource: signmask
                                    }
                                }

                            Image {
                                id: accountinfoimage
                                width: transferimage.width
                                height: transferimage.height

                            source: "../images/agh.jpg"
                            fillMode: Image.PreserveAspectCrop
                                    layer.enabled: true
                                    layer.effect: OpacityMask {
                                        maskSource: signmask
                                    }
                                }
            }

        }

    }



    // recent operations list
    ListView {
        id: listView
        x: 29
        y: 226
        width: 566
        height: 200


        model: Transfer_list {
            client_transfer_data:session.gettransfers()
        }

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

                    text: "-" + model.transferamount + "PLN"
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text {
                    anchors.left: datetxt.right
                    anchors.leftMargin: 10

                    text: "Titile: " + model.transfername
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                }
                Text {
                    text: "Date: " + model.Date
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    font.bold: true
                }

                spacing: 10
            }
        }
    }
}



