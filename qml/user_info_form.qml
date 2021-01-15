import QtQuick 2.12
import QtQuick.Controls 2.12
import Action_enum 1.0

Item{

    property int input_height: form.height/19
    property double input_rec_scale: 1.2


    Connections{
        target: Form
        onError_infoChanged:errorinfo.text=Form.get_error_info();

    }

    Column{

        id:form
        anchors.fill: parent

        spacing:first_rec.height
        Rectangle{
            id:first_rec
            height:input_height*input_rec_scale
            width: parent.width
            property string bordercolor: "lightgrey"
            border.color: bordercolor
            border.width: 1

            TextInput{


                id:first_input
                objectName: "FirstName"
                activeFocusOnTab: true
                color: "grey"
                anchors.fill: parent
                font.pixelSize: input_height
                text: Form.get_form_cell("FirstName")

                onActiveFocusChanged: {
                    if(first_input.activeFocus)
                        Form.setForm({"FirstName":first_input.text},Cell_action.Clicked)
                    else
                        Form.setForm({"FirstName":text},Cell_action.Editing_Finished)
                }
                onTextChanged: Form.setForm({"FirstName":text},Cell_action.Data_changed)

            }
        }

        Rectangle{
            width: parent.width
            height: input_height*input_rec_scale
            property string bordercolor: "lightgrey"
            border.color: bordercolor
            border.width: 1
            TextInput{
                id:secondname_input
                objectName: "SecondName"
                activeFocusOnTab: true
                anchors.fill: parent
                text: Form.get_form_cell("SecondName")
                font.pixelSize: input_height
                color: "grey"

                onTextChanged: Form.setForm({"SecondName":text},Cell_action.Data_changed )
                onActiveFocusChanged: {
                    if(activeFocus)
                        Form.setForm({"SecondName":parent.text},Cell_action.Clicked)
                    else
                        Form.setForm({"SecondName":text},Cell_action.Editing_Finished)
                }


            }

        }


        Rectangle{

            width: parent.width
            height: input_height*input_rec_scale
            property string bordercolor: "lightgrey"
            border.color: bordercolor
            border.width: 1
            TextInput{
                id:email_input
                objectName: "Email"
                activeFocusOnTab: true
                anchors.fill: parent
                anchors.centerIn: parent
                text: Form.get_form_cell("Email")
                font.pixelSize: input_height
                color: "grey"

                onActiveFocusChanged: {
                    if(activeFocus)
                        Form.setForm({"Email":text},Cell_action.Clicked)
                    else
                        Form.setForm({"Email":text},Cell_action.Editing_Finished)
                }
                onTextChanged: Form.setForm({"Email":text},Cell_action.Data_changed)

            }
        }

        Rectangle{
            width: parent.width
            height: input_height*input_rec_scale
            property string bordercolor: "lightgrey"
            border.color: bordercolor
            border.width: 1
            TextInput{
                id:pesel_input
                objectName: "Pesel"
                activeFocusOnTab: true
                anchors.fill: parent
                anchors.centerIn: parent
                text: Form.get_form_cell("Pesel")
                color: "grey"
                font.pixelSize: input_height

                onTextChanged: Form.setForm({"Pesel":text},Cell_action.Data_changed)
                onActiveFocusChanged: {
                    if(activeFocus)
                        Form.setForm({"Pesel":text},Cell_action.Clicked)
                    else
                        Form.setForm({"Pesel":text},Cell_action.Editing_Finished)
                }
            }
        }
        Rectangle{
            width: parent.width
            height: input_height*input_rec_scale
            property string bordercolor: "lightgrey"
            border.color: bordercolor
            border.width: 1
            TextInput{
                id:citizenship_input
                objectName: "CitizenShip"
                activeFocusOnTab: true
                anchors.fill: parent
                anchors.centerIn: parent
                color: "grey"
                text: Form.get_form_cell("CitizenShip")
                font.pixelSize: input_height


                onTextChanged: Form.setForm({"CitizenShip":text},Cell_action.Data_changed)
                onActiveFocusChanged: {
                    if(activeFocus)
                        Form.setForm({"CitizenShip":text},Cell_action.Clicked)
                    else
                        Form.setForm({"CitizenShip":text},Cell_action.Editing_Finished)
                }
            }
        }

        Rectangle{
            width: parent.width
            height: input_height*input_rec_scale
            property string bordercolor: "lightgrey"
            border.color: bordercolor
            border.width: 1
            TextInput{
                id:birtplace_input
                objectName: "BirthPlace"
                activeFocusOnTab: true
                anchors.fill: parent
                anchors.centerIn: parent
                color: "grey"
                text: Form.get_form_cell("BirthPlace")
                font.pixelSize: input_height


                onTextChanged: Form.setForm({"BirthPlace":text},Cell_action.Data_changed)
                onActiveFocusChanged: {
                    if(activeFocus)
                        Form.setForm({"BirthPlace":text},Cell_action.Clicked)
                    else
                        Form.setForm({"BirthPlace":text},Cell_action.Editing_Finished)
                }
            }
        }

        Rectangle{
            width: parent.width
            height: input_height*input_rec_scale
            property string bordercolor: "lightgrey"
            border.color: bordercolor
            border.width: 1
            Loader{
                 objectName: "BirthDay"
                id:birthdayloader
                anchors.fill: parent
                focus: true
                source: "qrc:/qml/calendar.qml"

            }
        }




        Rectangle{
            property string bordercolor: "lightgrey"
            border.color: bordercolor
            width: parent.width
            height: input_height*input_rec_scale
            border.width: 1
            TextInput{
                id: mothername_input
                objectName: "MotherName"
                activeFocusOnTab: true
                anchors.fill: parent
                anchors.centerIn: parent
                color: "grey"
                text: Form.get_form_cell("MotherName")
                font.pixelSize: input_height


                onTextChanged: Form.setForm({"MotherName":text},Cell_action.Data_changed)
                onActiveFocusChanged: {
                    if(activeFocus)
                        Form.setForm({"MotherName":text},Cell_action.Clicked)
                    else
                        Form.setForm({"MotherName":text},Cell_action.Editing_Finished)
                }
            }
        }


    }

}
