import QtQuick 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import Transfer_list 1.0
import Transfer 1.0



Item {
    id:root
    anchors.fill: parent
    property bool currencychoosen: false
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
            anchors.margins: spacing
            Row{
                height: parent.height*0.2
                width: parent.width
            Image{
            id:listcaller
            anchors.left: parent.left
            height: parent.height*0.8
            width: height
            source: "../images/call_list.jpg"
            MouseArea{
            anchors.fill: parent
            onClicked: {
                if(!currencychoosen){
                    currencychoosen=true
                     currencys = Qt.createQmlObject('import Currency_list 1.0;Currency_list{id:list;}',mainpage,"allcurrencys.qml")
                }
                listloader.source == "" ? listloader.source="qrc:/qml/currencyaccounts.qml" : listloader.source = ""
            }

            }
            }
            Loader{
             id:listloader
             anchors.top: listcaller.bottom
             width: root.width*0.3
             height: root.height*0.1
            }
            Rectangle{
                anchors.right: parent.right
                id: backtologin

                width: parent.width*0.1
                height: parent.height
                color: backtologinarea.pressed ? "darkred" : "red"
                radius:10
                Text{
                    fontSizeMode:Text.HorizontalFit
                    anchors.centerIn: parent
                    color:"white"
                    text: "Logout"

                }
                MouseArea
                {
                    id:backtologinarea
                    anchors.fill: parent
                    onClicked: {mainpage.source="qrc:/qml/login.qml"

                    }
                }
            }
}


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
                text: session.get_data_from_clients_table("AccountBalance")+" PLN"
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

                            formtype = Qt.createQmlObject('import QtQuick 2.12;import Transfer 1.0; Transfer{id:transfer;}',
                                                          mainpage,"mainform.qml")
                            formcontent="qrc:/qml/transferform.qml"
                            formcontent_nav="qrc:/qml/transfer_form_nav.qml"
                            mainpage.source = "qrc:/qml/mainform.qml"

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
                            formtype = Qt.createQmlObject('import CurrencyAccountForm 1.0;CurrencyAccountForm{id:accountform;}',
                                                          mainpage,"mainform.qml")
                            currencys = Qt.createQmlObject('import Currency_list 1.0;Currency_list{id:list;}',mainpage,"allcurrencys.qml")
                            currencys.setallcurrency()
                            currencys.modelReset()
                            formcontent="qrc:/qml/currency_account_form.qml"
                            formcontent_nav="qrc:/qml/accountcreation_nav.qml"
                            mainpage.source = "qrc:/qml/mainform.qml"

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




    Label{
        anchors.bottom: transferlist.top
        text: "Recent transfer:"
        height: balance1.height*1.5
        width: transferlist.width
    }
ListView {
    id: transferlist
    anchors.top:generallinforec.bottom
    anchors.topMargin: generallinforec.height/4
    anchors.horizontalCenter: parent.horizontalCenter
    width: generallinforec.width-10
    height:generallinforec.height*1.5
    clip:true



    model: Transfer_list{
        id:transferlistmodel
       client_transfer_data:session.gettransfers()
      }

    delegate: Rectangle {
        width: parent.width
        height: balance1.height*1.5
        Rectangle {
            width: parent.width
            height: 2
            color: "grey"
        }

        Text {
            id:amount
            color: model.transferamount[0]==="-" && model.transferamount !== ""  ? "red" : "green"
            text: model.transferamount !== "" ? model.transferamount + "PLN" : "Make your first transfer"
            anchors.verticalCenter: parent.verticalCenter
        }
        Text {
            anchors.left:   amount.right
            anchors.leftMargin: 10

            text:  model.transfername !== "" ? "Titile: " + model.transfername : ""
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
        }
        Text {
            text: model.Date !== "" ? "Date: " + model.Date : ""
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            font.bold: true
        }


    }

}


}



