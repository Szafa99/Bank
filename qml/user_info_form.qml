import QtQuick 2.12
import QtQuick.Controls 2.12
import Action_enum 1.0

Item{

    property int input_height: form.height/18
    property double input_rec_scale: 1.2

    Connections{
    target: Register
    onError_infoChanged:{errorinfo.text=Register.get_error_info();console.log("errorChanged")}
    }
    Column{

        id:form
        anchors.fill: parent
        anchors.margins: 10
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

                color: "grey"
                anchors.fill: parent
                font.pixelSize: input_height
                text: Register.get_form_cell("FirstName")



                onTextChanged: Register.setForm({"FirstName":text},Cell_action.Data_changed)
                onEditingFinished: Register.setForm({"FirstName":text},Cell_action.Editing_Finished)
                MouseArea{
                    anchors.fill:parent
                    onClicked: Register.setForm({"FirstName":parent.text},Cell_action.Clicked)
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
                id:secondname_input
                objectName: "SecondName"

                anchors.fill: parent
                text: Register.get_form_cell("SecondName")
                font.pixelSize: input_height
                color: "grey"

                onTextChanged: Register.setForm({"SecondName":text},Cell_action.Data_changed )
                onEditingFinished: Register.setForm({"SecondName":text},Cell_action.Editing_Finished)
                MouseArea{
                    anchors.fill:parent
                    onClicked: Register.setForm({"SecondName":parent.text},Cell_action.Clicked)
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

                anchors.fill: parent
                anchors.centerIn: parent
                text: Register.get_form_cell("Email")
                font.pixelSize: input_height
                color: "grey"

                onEditingFinished: Register.setForm({"Email":text},Cell_action.Editing_Finished)
                onTextChanged: Register.setForm({"Email":text},Cell_action.Data_changed)
                MouseArea{
                    anchors.fill:parent
                    onClicked: Register.setForm({"Email":parent.text},Cell_action.Clicked)
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
                id:pesel_input
                objectName: "Pesel"

                anchors.fill: parent
                anchors.centerIn: parent
                text: Register.get_form_cell("Pesel")
                color: "grey"
                font.pixelSize: input_height

                onTextChanged: Register.setForm({"Pesel":text},Cell_action.Data_changed)
                onEditingFinished: Register.setForm({"Pesel":text},Cell_action.Editing_Finished)
                MouseArea{
                    anchors.fill:parent
                    onClicked: Register.setForm({"Pesel":parent.text},Cell_action.Clicked)
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

                anchors.fill: parent
                anchors.centerIn: parent
                color: "grey"
                text: Register.get_form_cell("CitizenShip")
                font.pixelSize: input_height

                onEditingFinished: Register.setForm({"CitizenShip":text},Cell_action.Editing_Finished)
                onTextChanged: Register.setForm({"CitizenShip":text},Cell_action.Data_changed)
                MouseArea{
                    anchors.fill:parent
                    onClicked: Register.setForm({"CitizenShip":parent.text},Cell_action.Clicked)
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

                anchors.fill: parent
                anchors.centerIn: parent
                color: "grey"
                text: Register.get_form_cell("BirthPlace")
                font.pixelSize: input_height

                onEditingFinished: Register.setForm({"BirthPlace":text},Cell_action.Editing_Finished)
                onTextChanged: Register.setForm({"BirthPlace":text},Cell_action.Data_changed)
                MouseArea{
                    anchors.fill:parent
                    onClicked: Register.setForm({"BirthPlace":parent.text},Cell_action.Clicked)
                }
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

                anchors.fill: parent
                anchors.centerIn: parent
                color: "grey"
                text: Register.get_form_cell("MotherName")
                font.pixelSize: input_height

                onEditingFinished: Register.setForm({"MotherName":text},Cell_action.Editing_Finished)
                onTextChanged: Register.setForm({"MotherName":text},Cell_action.Data_changed)
                MouseArea{
                    anchors.fill: parent
                    onClicked: Register.setForm({"MotherName":parent.text},Cell_action.Clicked)
                }
            }
        }

        Label{
            id:errorinfo
            fontSizeMode: Text.Fit
            font.bold:true
            width: parent.width

            height: input_height*input_rec_scale
            text: Register.get_error_info()

            color: "red"
            }

    }

}
