import QtQuick 2.12
import QtQuick.Controls 2.12
import Action_enum 1.0

Item{
    id:calendarr


    property int inputheight: myrow.height*0.9
    property int inputwidth: myrow.width*0.25

    property string name

    Connections
    {
        target: year
        function onActiveFocusChanged(){
            if(activeFocus)
                Form.setForm({"BirthDay":day.text+"-"+month.text+"-"+year.text},Cell_action.Data_changed)
            else
                Form.setForm({"BirthDay":day.text+"-"+month.text+"-"+year.text},Cell_action.Editing_Finished)
        }
    }
    Connections
    {
        target: month
        function onActiveFocusChanged()
        {
            Form.setForm({"BirthDay":day.text+"-"+month.text+"-"+year.text},Cell_action.Data_changed)
        }
    }

    Connections
    {
        target: year
        function onActiveFocusChanged()
        {
            Form.setForm({"BirthDay":day.text+"-"+month.text+"-"+year.text},Cell_action.Data_changed)
        }

    }

    function getday(){
       name = Form.get_form_cell("BirthDay")
        return name.charAt(0)+name.charAt(1)
    }

    function getmonth(){
       name = Form.get_form_cell("BirthDay")

        return name.charAt(3)+name.charAt(4)
    }

    function getyear(){
       name = Form.get_form_cell("BirthDay")

        return name[6]+name[7]+name[8]+name[9]
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
            text: getday()
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
            text: getmonth()

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
            text: getyear()


            validator: IntValidator{bottom: 0 ;top:1000}
            overwriteMode: true
            cursorPosition: focus ? 0 : 0



        }

    }
}

