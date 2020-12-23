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
                text: "Hello,"+ session.get_data_from_clients_table("FirstName")
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
                text: session.get_data_from_clients_table("acountbalance")+" PLN"
                font.pixelSize:height
                color: "#eae9e9"
            }




     ////////////////////////////row with buttons from menu
            Row{

                id: userbuttons
                spacing: generallinfo.width/4
                anchors.horizontalCenter: parent.horizontalCenter

                //mask used to make the buttons round
                Rectangle{
                    id:signmask
                    width: balance1.width/8
                    height: width
                    radius: width/2
                    clip: true
                    visible: false
                }

                Image {

                    id: transfer_image
                    source: "../images/transfersign.png"
                    width: balance1.width/8
                    height: width

                    fillMode: Image.PreserveAspectCrop
                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: signmask
                    }
                    MouseArea{
                        hoverEnabled: true
                        id:transfer_button
                        anchors.fill: parent
                        onEntered:{
                            parent.width+=1.5
                            parent.height+=1.5
                            parent.opacity-=0.3
                        }
                        onExited:{
                            parent.width-=1.5
                            parent.height-=1.5
                            parent.opacity+=0.3
                        }
                        onClicked: {

                        }
                    }
                }



                Image {
                    id: menu_image
                    width: balance1.width/8
                    height: width
                    source: "../images/transfersign.png"
                    fillMode: Image.PreserveAspectCrop
                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: signmask
                    }
                    MouseArea{
                        hoverEnabled: true
                        id:menu_button
                        anchors.fill: parent
                        onEntered:{
                            parent.width+=1.5
                            parent.height+=1.5
                            parent.opacity-=0.3
                        }
                        onExited:{
                            parent.width-=1.5
                            parent.height-=1.5
                            parent.opacity+=0.3
                        }
                        onClicked: {

                        }
                    }
                }


                Image {
                    id: accountinfo_image
                    width: balance1.width/8
                    height: width
                    opacity:1
                    source: "../images/transfersign.png"

                    fillMode: Image.PreserveAspectCrop
                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: signmask
                    }
                    MouseArea{
                        hoverEnabled: true
                        id:accountinfo_button
                        anchors.fill: parent 
                        onEntered:{
                            parent.width+=1.5
                            parent.height+=1.5
                            parent.opacity-=0.3
                        }
                        onExited:{
                            parent.width-=1.5
                            parent.height-=1.5
                            parent.opacity+=0.3
                        }
                        onClicked: {

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




    model: Transfer_list{
       client_transfer_data:session.gettransfers()
      }

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




