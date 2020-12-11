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

        Column{

            id:generallinfo
            anchors.fill:parent
            spacing: height/14


            Text {
                id: firstname
                width:text.width
                height: generallinfo.height/4
                color: "#f7f6f6"
                text: "Hello,"//+ session.get_data_from_clients_table("FirstName")
                font.pixelSize: height
                anchors.horizontalCenter: parent.horizontalCenter
            }



            Text {
                id: balance1

                width:text.width
                height: generallinfo.height/6
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
                text: "test"//+session.get_data_from_clients_table("acountbalance")
                font.pixelSize:height
                color: "#eae9e9"
            }
            ///////////////////////////////////////////////////// buttons of maketransfer and so on
            Row{
                id: userbuttons
                spacing: generallinfo.width/4
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle{
                    id:signmask
                    width: balance1.width/8
                    height: width
                    radius: width/2
                    clip: true
                    visible: false
                }

                Image {

                    id: transferimage
                    source: "../images/transfersign.png"
                    width: balance1.width/8
                    height: width
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
                    opacity:1
                    source: "../images/transfersign.png"

                    fillMode: Image.PreserveAspectCrop
                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: signmask
                    }
                    MouseArea{
                        id:accountinfobutton
                        anchors.fill: parent
                        onClicked: {
                            accountinfoimage.width=width+1
                            accountinfoimage.height=height+1
                            accountinfoimage.opacity=0.8
                        }
                    }
                }
            }
        }
    }







//////////////////////////////////////////////////// recent operations list




ListView {
    id: transferlist
    anchors.top:generallinforec.bottom
    anchors.topMargin: generallinforec.height/4
    anchors.horizontalCenter: parent.horizontalCenter
    width: generallinforec.width-10
    height:generallinforec.height*1.5

    model:ListModel{
        ListElement{
            transferamount:"123"
            Date:"22.03.2021"
            transfername:"Spotify"
        }

        ListElement{
            transferamount:"123"
            Date:"22.03.2021"
            transfername:"Spotify"
        }

        ListElement{
            transferamount:"123"
            Date:"22.03.2021"
            transfername:"Spotify"
        }


    }

    /* Transfer_list {
            client_transfer_data:session.gettransfers()
      }*/

    delegate: Rectangle {
        width: parent.width
        height: balance1.height*1.5
        //anchors.fill: parent
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


    }

}
}




