import QtQuick 2.12
import QtQuick.Controls 2.12
import Action_enum 1.0

Item{
    id:calendarr


    property int inputheight: myrow.height*0.9
    property int inputwidth: myrow.width*0.25



        Connections
        {
            target: year
            onActiveFocusChanged:{
                if(activeFocus)
                Form.setForm({"BirthDay":day.text+"-"+month.text+"-"+year.text},Cell_action.Data_changed)
                else
                    Form.setForm({"BirthDay":day.text+"-"+month.text+"-"+year.text},Cell_action.Editing_Finished)
            }
        }
        Connections
        {
            target: month
            onActiveFocusChanged:Form.setForm({"BirthDay":day.text+"-"+month.text+"-"+year.text},Cell_action.Data_changed)
        }
        Connections
        {
            target: year
            onActiveFocusChanged:Form.setForm({"BirthDay":day.text+"-"+month.text+"-"+year.text},Cell_action.Data_changed)

        }




    Row{
        id: myrow

        anchors.fill: parent


        spacing: 10


            TextInput{
                id:day
                objectName: "dd"

                activeFocusOnTab: true
                height:inputheight
                width:inputwidth *0.5
                color: "grey"
                text: "dd"
                font.pixelSize: height


                validator: IntValidator{bottom: 0 ;top:10}
                overwriteMode: true
                cursorPosition: focus ? 0 : 0

            }


        Label{
            height: inputheight
            width: font.pixelSize
            text: "-"
            font.pixelSize: height
            font.bold: true
        }


            TextInput{
                height:inputheight
                width:inputwidth*0.5
                id:month
                objectName: "mm"
                font.pixelSize:height
                activeFocusOnTab: true
                color: "grey"
                text: "mm"

                validator: IntValidator{bottom: 0 ;top:10}
                overwriteMode: true
                cursorPosition: focus ? 0 : 0




       }
        Label{
            height: inputheight
            width: font.pixelSize
            text: "-"
            font.bold: true
            font.pixelSize: height
        }


            TextInput{
                id:year
                objectName: "yyyy"
                activeFocusOnTab: true
                width:inputwidth
                height:inputheight
                font.pixelSize:height
                color: "grey"
                text: "yyyy"


                validator: IntValidator{bottom: 0 ;top:1000}
                overwriteMode: true
            cursorPosition: focus ? 0 : 0



            }

    }
}

