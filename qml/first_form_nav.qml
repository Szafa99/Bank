import QtQuick 2.0
import Action_enum 1.0
import QtQuick.Controls 2.12

Item{
    anchors.fill: parent

    Rectangle{
        id: first_page
        anchors.fill: parent

        color: nextmousearea.pressed ? "darkred" : "red"
        radius:10
        TextInput{
            anchors.centerIn: parent
            color:"white"
            text: "Continue"

        }

        MouseArea
        {
            id:nextmousearea
            anchors.fill: parent

            onClicked: {
                Form.update()
                //Form.setForm({"BirthDay":day.text+"-"+month.text+"-"+year.text},Cell_action.Data_changed)

                if(Register.validet_input() )
                {
                navigationloader.source="qrc:/qml/last_form_nav.qml"
                formloader.source="qrc:/qml/adres_form.qml"
                }
            }

        }
    }
}




