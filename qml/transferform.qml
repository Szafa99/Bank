import QtQuick 2.12
import QtQuick.Controls 2.12
import Action_enum 1.0


Item{

    property int input_height: form.height/18
    property int form_spacing:form.height/18
    property double input_rec_scale: 1.2

    Connections{
        target: users_currencys
        function onChoosencurrencyChanged(){
            users_currencys.hidelist()
            users_currencys.modelReset()
            activecurrency.text = users_currencys.getactivecurrency().type
            Form.form_editedChanged()
        }
    }




    Column{

        id:form
        activeFocusOnTab: true
        anchors.fill: parent

        spacing: form_spacing
        Rectangle{
            property string bordercolor: "lightgrey"
            id:first_rec
            height:input_height*input_rec_scale
            border.color: bordercolor
            width: parent.width
            border.width: 1

            TextInput{
                objectName: "RecieverName"
                activeFocusOnTab: true
                color: "grey"
                anchors.fill: parent
                font.pixelSize: input_height
                text: Form.get_form_cell("RecieverName")



                onTextChanged: Form.setForm({"RecieverName":text},Cell_action.Data_changed)
                onActiveFocusChanged: {
                    if(activeFocus)
                        Form.setForm({"RecieverName":parent.text},Cell_action.Clicked)
                    else
                        Form.setForm({"RecieverName":text},Cell_action.Editing_Finished)
                }
            }
        }

        Rectangle{

            property string bordercolor: "lightgrey"
            width: parent.width
            height: input_height*input_rec_scale
            border.color: bordercolor
            border.width: 1
            TextInput{
                objectName: "AccountNumber"
                anchors.fill: parent

                text: Form.get_form_cell("AccountNumber")
                font.pixelSize: input_height
                activeFocusOnTab: true
                color: "grey"
                inputMethodHints:Qt.ImhDigitsOnly
                inputMask: "0000 0000 0000 0000"
                overwriteMode: true
                cursorPosition: activeFocus ? 0 : 0

                onTextChanged: Form.setForm({"AccountNumber":text},Cell_action.Data_changed )
                onActiveFocusChanged: {
                    if(activeFocus)
                        Form.setForm({"AccountNumber":parent.text},Cell_action.Clicked);
                    else
                        Form.setForm({"AccountNumber":text},Cell_action.Editing_Finished)
                }
            }

        }


        Rectangle{
            property string bordercolor: "lightgrey"
            width: parent.width
            height: input_height*input_rec_scale
            border.color: bordercolor
            border.width: 1
            TextInput{
                objectName: "Title"
                activeFocusOnTab: true
                anchors.fill: parent
                text: Form.get_form_cell("Title")
                font.pixelSize: input_height
                color: "grey"


                onTextChanged: Form.setForm({"Title":text},Cell_action.Data_changed)
                onActiveFocusChanged: {
                    if(activeFocus)
                        Form.setForm({"Title":parent.text},Cell_action.Clicked)
                    else
                        Form.setForm({"Title":text},Cell_action.Editing_Finished)
                }
            }
        }


        //
        Rectangle{
            property string bordercolor: "lightgrey"
            width: parent.width
            height: input_height*input_rec_scale
            border.color: bordercolor
            border.width: 1
            TextInput{
                id:amount_input
                objectName: "TransferAmount"
                z:110
                activeFocusOnTab: true
                anchors.left: parent.left
                width: parent.width*0.2
                height: parent.height

                text: Form.get_form_cell("TransferAmount")
                color: "grey"
                font.pixelSize: input_height

                cursorPosition: activeFocus ? 0 : 0
                inputMethodHints:Qt.ImhDigitsOnly
                inputMask:"00.00"
                overwriteMode: true
                onTextChanged: Form.setForm({"TransferAmount":text},Cell_action.Data_changed)
                onActiveFocusChanged: {
                    if(activeFocus){
                        Form.setForm({"TransferAmount":parent.text},Cell_action.Clicked)
                    }
                    else
                        Form.setForm({"TransferAmount":text},Cell_action.Editing_Finished)
                }
            }

            Label{
                id: activecurrency
                anchors{left:amount_input.right; leftMargin: 5; verticalCenter: parent.verticalCenter }
                font.pixelSize: input_height
                z:110
                text: users_currencys.getactivecurrency().type
                color:amount_input.activeFocus ? "black" : "grey"
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



    }

}
