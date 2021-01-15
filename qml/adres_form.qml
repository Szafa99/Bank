import QtQuick 2.12
import QtQuick.Controls 2.12
import Action_enum 1.0

Item{

    property int input_height: form.height/18
    property int form_spacing:form.height/18
    property double input_rec_scale: 1.2

    Connections{
        target: Form
        onError_infoChanged:{errorinfo.text=Form.get_error_info();console.log("errorChanged")}
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
                objectName: "City"
                activeFocusOnTab: true
                color: "grey"
                anchors.fill: parent
                font.pixelSize: input_height
                text: Form.get_form_cell("City")



                onTextChanged: Form.setForm({"City":text},Cell_action.Data_changed)
                onActiveFocusChanged: {
                    if(activeFocus)
                        Form.setForm({"City":parent.text},Cell_action.Clicked)
                    else
                        Form.setForm({"City":text},Cell_action.Editing_Finished)
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
                activeFocusOnTab: true
                anchors.fill: parent
                text: Form.get_form_cell("StreetName")
                font.pixelSize: input_height
                color: "grey"

                onTextChanged: Form.setForm({"StreetName":text},Cell_action.Data_changed )
                onActiveFocusChanged: {
                    if(activeFocus)
                        Form.setForm({"StreetName":parent.text},Cell_action.Clicked)
                    else
                        Form.setForm({"StreetName":text},Cell_action.Editing_Finished)
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
                activeFocusOnTab: true
                anchors.fill: parent
                anchors.centerIn: parent
                text: Form.get_form_cell("HouseNumber")
                font.pixelSize: input_height
                color: "grey"


                onTextChanged: Form.setForm({"HouseNumber":text},Cell_action.Data_changed)
                onActiveFocusChanged: {
                    if(activeFocus)
                        Form.setForm({"HouseNumber":parent.text},Cell_action.Clicked)
                    else
                        Form.setForm({"HouseNumber":text},Cell_action.Editing_Finished)
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
                activeFocusOnTab: true
                anchors.fill: parent
                anchors.centerIn: parent
                text: Form.get_form_cell("PostalCode")
                color: "grey"
                font.pixelSize: input_height

                onTextChanged: Form.setForm({"PostalCode":text},Cell_action.Data_changed)
                onActiveFocusChanged: {
                    if(activeFocus)
                        Form.setForm({"PostalCode":parent.text},Cell_action.Clicked)
                    else
                        Form.setForm({"PostalCode":text},Cell_action.Editing_Finished)
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
                activeFocusOnTab: true
                anchors.fill: parent
                anchors.centerIn: parent
                color: "grey"
                text: Form.get_form_cell("Pin")
                font.pixelSize: input_height


                onTextChanged: Form.setForm({"Pin":text},Cell_action.Data_changed)
                onActiveFocusChanged: {
                    if(activeFocus)
                        Form.setForm({"Pin":parent.text},Cell_action.Clicked)
                    else
                        Form.setForm({"Pin":text},Cell_action.Editing_Finished)
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
                activeFocusOnTab: true

                color: "grey"
                text: Form.get_form_cell("CheckPin")
                font.pixelSize: input_height

                onTextChanged: Form.setForm({"CheckPin":text},Cell_action.Data_changed)
                onActiveFocusChanged: {
                    if(activeFocus)
                        Form.setForm({"CheckPin":parent.text},Cell_action.Clicked)
                    else
                        Form.setForm({"CheckPin":text},Cell_action.Editing_Finished)
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
                activeFocusOnTab: true
                color: "grey"
                text: Form.get_form_cell("Password")
                font.pixelSize: input_height

                onTextChanged: Form.setForm({"Password":text},Cell_action.Data_changed)
                onActiveFocusChanged: {
                    if(activeFocus)
                        Form.setForm({"Password":parent.text},Cell_action.Clicked)
                    else
                        Form.setForm({"Password":text},Cell_action.Editing_Finished)
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
                activeFocusOnTab: true
                anchors.fill: parent
                anchors.centerIn: parent
                color: "grey"
                text: Form.get_form_cell(objectName)
                font.pixelSize: input_height


                onTextChanged: Form.setForm({"CheckPassword":text},Cell_action.Data_changed)
                onActiveFocusChanged: {
                    if(activeFocus)
                        Form.setForm({"CheckPassword":parent.text},Cell_action.Clicked)
                    else
                        Form.setForm({"CheckPassword":text},Cell_action.Editing_Finished)
                }
            }
        }

    }

}
