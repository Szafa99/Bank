import QtQuick 2.12
import QtQuick.Controls 2.12
import Action_enum 1.0
import Currency_list 1.0
import CurrencyAccountForm 1.0
Item{
    id:root
    anchors.fill: parent
    property int input_height: form.height/15
    property int form_spacing:form.height/10
    property double input_rec_scale: 1.2
    property int listsize:currencys.rowCount(currencys.parent)

    Connections{
        target: Form
        onFormChanged:accountumber.text=Form.get_form_cell("AccountNumber")


    }




    Column{
        anchors.fill: parent

        id:form
        activeFocusOnTab: true

        spacing: form_spacing


        Rectangle{
            id:chooseaccount
            property string bordercolor: "lightgrey"
            border.color: bordercolor
            border.width: 1

            anchors.horizontalCenter: parent.horizontalCenter
            height:input_height*input_rec_scale
            width: parent.width

            Loader{
                id:currencyloader
                anchors.left: parent.left
                height: parent.height*list_el_displayed
                width: parent.width
                z:100
            }
            Text{
                z:1
                clip: true
                color: "grey"
                anchors.centerIn: parent
                anchors.bottom: parent.bottom
                anchors.bottomMargin: height*0.2
                height: parent.height*0.8
                font.pixelSize: height*0.5
                text: "Choose currencyn of your account"
            }

            MouseArea{
                id:listcallerarea
                anchors.fill: parent
                onClicked: {
                    currencyloader.source="qrc:/qml/allcurrencys.qml"
                }
            }

        }

        Rectangle{
            z:-1
            property string bordercolor: "lightgrey"
            id:first_rec
            height:input_height*input_rec_scale
            border.color: bordercolor
            width: parent.width
            border.width: 1

            Text{
                id:accountumber
                objectName: "AccountNumber"
                color: "grey"
                anchors.bottomMargin: height*0.2
                anchors.bottom: parent.bottom
                height: parent.height*0.8
                font.pixelSize: height*0.5
                text: Form.get_form_cell("AccountNumber")

            }
        }
        Rectangle{
            z:-1
            property string bordercolor: "lightgrey"

            height:input_height*input_rec_scale
            border.color: bordercolor
            width: parent.width
            border.width: 1

            Text{
                color: "grey"
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.bottomMargin: height*0.2
                height: parent.height*0.8
                font.pixelSize: height*0.5
                text: "Add a currencycard to your acccount."

            }
            CheckBox{
                anchors{ right: parent.right;rightMargin: parent.width*0.05;verticalCenter: parent.verticalCenter;}
                height: parent.height*0.95
                width: height

            }
        }


    }





}
