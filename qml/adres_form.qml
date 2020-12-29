import QtQuick 2.12
import QtQuick.Controls 2.12
import Action_enum 1.0

Item{

    property int input_height: form.height/18
    property int form_spacing:form.height/18
    property double input_rec_scale: 1.2

    Connections{
    target: Register
    onError_infoChanged:{errorinfo.text=Register.get_error_info();console.log("errorChanged")}
    }
    Column{

        id:form
        anchors.fill: parent
        anchors.margins: 10
        spacing: form_spacing
        Rectangle{
            property string bordercolor: "lightgrey"
            id:first_rec
            height:input_height*input_rec_scale
            width: parent.width

            border.color: bordercolor
            border.width: 1

            TextInput{
                objectName: "City"

                color: "grey"
                anchors.fill: parent
                font.pixelSize: input_height
                text: Register.get_form_cell("City")



                onTextChanged: Register.setForm({"City":text},Cell_action.Data_changed)
                onEditingFinished: Register.setForm({"City":text},Cell_action.Editing_Finished)
                MouseArea{
                    anchors.fill:parent
                    onClicked: Register.setForm({"City":parent.text},Cell_action.Clicked)
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
                objectName: "StreetName"

                anchors.fill: parent
                text: Register.get_form_cell("StreetName")
                font.pixelSize: input_height
                color: "grey"

                onTextChanged: Register.setForm({"StreetName":text},Cell_action.Data_changed )
                onEditingFinished: Register.setForm({"StreetName":text},Cell_action.Editing_Finished)
                MouseArea{
                    anchors.fill:parent
                    onClicked: Register.setForm({"StreetName":parent.text},Cell_action.Clicked)
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
                objectName: "HouseNumber"

                anchors.fill: parent
                anchors.centerIn: parent
                text: Register.get_form_cell("HouseNumber")
                font.pixelSize: input_height
                color: "grey"

                onEditingFinished: Register.setForm({"HouseNumber":text},Cell_action.Editing_Finished)
                onTextChanged: Register.setForm({"HouseNumber":text},Cell_action.Data_changed)
                MouseArea{
                    anchors.fill:parent
                    onClicked: Register.setForm({"HouseNumber":parent.text},Cell_action.Clicked)
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
                objectName: "PostalCode"

                anchors.fill: parent
                anchors.centerIn: parent
                text: Register.get_form_cell("PostalCode")
                color: "grey"
                font.pixelSize: input_height

                onTextChanged: Register.setForm({"PostalCode":text},Cell_action.Data_changed)
                onEditingFinished: Register.setForm({"PostalCode":text},Cell_action.Editing_Finished)


                MouseArea{
                    anchors.fill:parent

                    onClicked: Register.setForm({"PostalCode":parent.text},Cell_action.Clicked)
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
                objectName: "Pin"

                anchors.fill: parent
                anchors.centerIn: parent
                color: "grey"
                text: Register.get_form_cell("Pin")
                font.pixelSize: input_height

                onEditingFinished: Register.setForm({"Pin":text},Cell_action.Editing_Finished)
                onTextChanged: Register.setForm({"Pin":text},Cell_action.Data_changed)
                MouseArea{
                    anchors.fill:parent
                    onClicked: Register.setForm({"Pin":parent.text},Cell_action.Clicked)
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
                objectName: "CheckPin"
                anchors.fill: parent

               // anchors.centerIn: parent
                color: "grey"
                text: Register.get_form_cell("CheckPin")
                font.pixelSize: input_height

                onEditingFinished: Register.setForm({"CheckPin":text},Cell_action.Editing_Finished)
                onTextChanged: Register.setForm({"CheckPin":text},Cell_action.Data_changed)

                onActiveFocusChanged: Register.setForm({"CheckPin":text},Cell_action.Editing_Finished)
                MouseArea{
                    onFocusChanged: Register.setForm({"CheckPin":parent.text},Cell_action.Editing_Finished)
                    anchors.fill:parent
                    onClicked: Register.setForm({"CheckPin":parent.text},Cell_action.Clicked)
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
                objectName: "Password"

                anchors.fill: parent
               // anchors.centerIn: parent
                color: "grey"
                text: Register.get_form_cell("Password")
                font.pixelSize: input_height

                onEditingFinished: Register.setForm({"Password":text},Cell_action.Editing_Finished)
                onTextChanged: Register.setForm({"Password":text},Cell_action.Data_changed)
                MouseArea{
                    anchors.fill: parent
                    onClicked: Register.setForm({"Password":parent.text},Cell_action.Clicked)
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
                objectName: "CheckPassword"

                anchors.fill: parent
                anchors.centerIn: parent
                color: "grey"
                text: Register.get_form_cell(objectName)
                font.pixelSize: input_height

                onEditingFinished: Register.setForm({"CheckPassword":text},Cell_action.Editing_Finished)
                onTextChanged: Register.setForm({"CheckPassword":text},Cell_action.Data_changed)
                MouseArea{
                    anchors.fill: parent
                    onClicked: Register.setForm({"CheckPassword":parent.text},Cell_action.Clicked)
                }
            }
        }
        Text{
            id: errorinfo
            width: parent.width
            fontSizeMode: Text.Fit
            font.bold:true
            height: input_height*input_rec_scale
            color: "red"

                text: Register.get_error_info()

            }
    }

}
