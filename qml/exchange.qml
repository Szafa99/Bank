import QtQuick 2.12
import QtQuick.Controls 2.12
import Action_enum 1.0


Item{
    id:exchangeroot
    property int input_height: form.height/18
    property int form_spacing:form.height/18
    property double input_rec_scale: 1.2


    Connections{
        target: Form
       function onError_infoChanged(){
            errorinfo.text=Form.get_error_info();console.log("errorChanged")
        }

    }
    Column{

        id:form
        activeFocusOnTab: true
        anchors.fill: parent

        spacing: form_spacing*3



        Rectangle{
            id:chooseaccount
            property string bordercolor: "lightgrey"
            border.color: bordercolor
            border.width: 1

            anchors.horizontalCenter: parent.horizontalCenter
            height:input_height*input_rec_scale
            width: parent.width
            Row{
                id:input
                z:110
                objectName: "Amount"
                height: parent.height
                width: parent.width*0.2
                clip: true
                anchors{left:parent.left;leftMargin: parent.width*0.1;horizontalCenter: parent.horizontalCenter}
                spacing: 2
                TextInput{
                    id:integers
                    activeFocusOnTab: true

                    z:110
                    color: "grey"
                    font.pixelSize: parent.height
                    text: "0"
                    cursorPosition: activeFocus ? 0 : 0
                    overwriteMode: true
                    inputMethodHints:Qt.ImhDigitsOnly
                    onTextChanged: Form.setForm({"Amount":text+"."+doubels.text},Cell_action.Data_changed)
                }
                Label{
                    z:110
                    color: "grey"
                    font.pixelSize: parent.height
                    text: "."
                    }
                TextInput{
                    id:doubels
                    font.pixelSize: parent.height
                    activeFocusOnTab: true
                    z:110
                    maximumLength:2
                    color: "grey"
                    text: "0"
                    cursorPosition: activeFocus ? 0 : 0
                    overwriteMode: true
                    inputMethodHints:Qt.ImhDigitsOnly
                    onTextChanged: Form.setForm({"Amount":integers.text+"."+text},Cell_action.Data_changed)
                }
                Label{
                    z:110
                    color: "grey"
                    font.pixelSize: parent.height
                    text: " "+users_currencys.getactivecurrency().type
                    }

            }

            Loader{

                id:currencyloader
                anchors.left: parent.left
                height: parent.height*list_el_displayed
                width: parent.width
                z:100
                source: "../qml/Currency_exchange_input.qml"

            }
            MouseArea{
                id:listcallerarea
                anchors.fill: parent
                onClicked: users_currencys.hidelist()
            }
        }


        Rectangle{
            id:choosecurrency

            property string bordercolor: "lightgrey"
            border.color: bordercolor
            border.width: 1

            anchors.horizontalCenter: parent.horizontalCenter
            height:input_height*input_rec_scale
            width: parent.width
            Loader{
                anchors.left: parent.left
                height: parent.height*list_el_displayed
                width: parent.width
                z:99
                source: "../qml/Currency_exchange_output.qml"
                focus: true
            }
            MouseArea{
                anchors.fill: parent
                onClicked: currencys.hidelist()
            }
        }

    }


}


