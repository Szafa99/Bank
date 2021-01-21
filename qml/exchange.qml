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

            id:first_rec
            height:input_height*input_rec_scale
            border.color: "grey"
            width: parent.width
            border.width: 1

            TextInput{
                id:amount
                activeFocusOnTab: true
                color: "grey"
                anchors.fill: parent
                font.pixelSize: input_height

                inputMethodHints:Qt.ImhDigitsOnly
                inputMask: "00.00"+"PL\\N\\"
                overwriteMode: true
                cursorPosition: activeFocus ? 0 : 0


            }
        }


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
                height: parent.height*3
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
                text: "Choose currencyn"
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


            height:input_height*input_rec_scale
            border.color: bordercolor
            width: parent.width
            border.width: 1

            Text{
                id:result
                activeFocusOnTab: true
                color: "grey"
                anchors.fill: parent
                font.pixelSize: input_height

                text: formtype.getresult("2.00",1)


            }
        }


    }


}


