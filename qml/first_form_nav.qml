import QtQuick 2.0
import Action_enum 1.0
Item{
    anchors.fill: parent
    Rectangle{
        id: first_page
        anchors.fill: parent

        color: nextmousearea.pressed ? "darkred" : "red"
        radius:10
        Text{
            anchors.centerIn: parent
            color:"white"
            text: "Continue"
        }

        MouseArea
        {
            id:nextmousearea
            anchors.fill: parent

            onClicked: {
                Register.update()
                if(Register.validet_input() )
                {
                navigationloader.source="qrc:/qml/last_form_nav.qml"
                formloader.source="qrc:/qml/adres_form.qml"
                }
            }

        }
    }
}




