import QtQuick.Window 2.12
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import Action_enum 1.0

Window {
    id:root
    minimumHeight: 180
    minimumWidth: 340
    width: 640
    height: 480
    visible: true
    title: qsTr("Welcome!")
    property int input_height: form.height/16
    property double input_rec_scale: 1.2



    Rectangle{
        id:border_rec
        anchors.fill: parent
        border.color: "lightgrey"
        border.width: 5


        Label{
            id: createlabel
            height: root.height/14
            anchors.top: border_rec.top
            anchors.topMargin: user_interface_rec.y/2
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: height
            text: "Create an account with BankName"
        }

        Rectangle{

            id:user_interface_rec
            clip: true
            anchors.top:createlabel.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: 10
            anchors.bottomMargin: 50
            anchors.horizontalCenter: createlabel.horizontalCenter
            radius: 5
            border.width:2
            z:1
            border.color: "red"
            width: root.width/2.2
            Column{

                id:form
                anchors.fill: parent
                anchors.margins: 10
                spacing:firstname_rec.height


                Rectangle{
                    id:firstname_rec
                    height:input_height*input_rec_scale
                    width: parent.width
                    border.color: "lightgrey"
                    border.width: 1

                    TextInput{
                        id:firstname_input
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
                    height: secondname_input.font.pixelSize*input_rec_scale
                    border.color: "lightgrey"
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
                    height: email_input.font.pixelSize*input_rec_scale
                    border.color: "lightgrey"
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
                    border.color: "lightgrey"
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
                    height: citizenship_input.font.pixelSize*input_rec_scale
                    border.color: "lightgrey"
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
                    height: birtplace_input.font.pixelSize*input_rec_scale
                    border.color: "lightgrey"
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
                    width: parent.width
                    height: mothername_input.font.pixelSize*input_rec_scale
                    border.color: "lightgrey"
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


            }
        }
    }
}
