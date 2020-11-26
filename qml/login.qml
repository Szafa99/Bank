
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12



Window {
    id:root
    minimumHeight: 180
    minimumWidth: 340
    width: 640
    height: 480

    visible: true
    color:"black"
    title: qsTr("Log in")




    function startsession(){
        var component = Qt.createComponent("qrc:/example.qml")
                    var window = component.createObject(root)
                    window.show()
    }

    Connections{
        target: logintxt
        onEditingFinished: {
            if(logintxt.text.length > 1 )
                loginrect.loginmodified=true
            if(!log.setusername(logintxt.text) )
                console.log(log.getloginerror())
        }
    }



    Connections{
        target:log
        onLoginerrorChanged:{login_error_msg.text=log.getloginerror();console.log("logerror changed")}

    }


    ListModel
    {
        id:keyboard_model
        ListElement{name: "button0"
            number:"0"}

        ListElement{name: "button1"
            number:"1"}

        ListElement{name: "button2"
            number:"2"}

        ListElement{name: "button3"
            number:"3"}

        ListElement{name: "button4"
            number:"4"}

        ListElement{name: "button5"
            number:"5"}

        ListElement{name: "button6"
            number:"6"}

        ListElement{name: "button7"
            number:"7"}

        ListElement{name: "button8"
            number:"8"}

        ListElement{name: "button9"
            number:"9"}

        ListElement{name: "button_del"
            file: "../images/backspace.jpg"
        }

        ListElement{name: "button_enter"
            file: "../images/enter.png"
        }
    }


    Component{
        id: keyboard_component
        Rectangle{
            id:keyboard_button_rec
            color: input_area.pressed ? "lightgrey" : "white"
            border.width: 2
            border.color: "lightgrey"
            height: width
            width:{
                var x= pinrect.width
                return (x-(keyboard_grid.columns-1)*keyboard_grid.spacing)/keyboard_grid.columns
            }


            MouseArea{
                id:input_area
                anchors.fill:parent
                onClicked:{
                    pinrect.state="using_keyboard"
                    if(model.name==="button_del")pin.remove(pin.length-1,pin.length)
                    else{ pin.insert(pin.length,model.number);
                        pinrect.pinmodified=true;
                        if(pinrect.pinmodified)
                            console.log("pin modified")
                    }

                }
            }
            Image {
                id:button_img
                smooth: true
                height: parent.height/2
                width: parent.width/2
                anchors.centerIn:parent
                anchors.margins:5
                source: model.file
            }
            Text{
                id:button_nr
                anchors.centerIn:parent
                color:"black"
                text:model.number
            }

        }
    }

    Rectangle{
        id:border_rec
        anchors.fill: parent
        border.color: "lightgrey"
        border.width: 5
        Rectangle{
            id: welcomerec
            clip: true
            color: "lightgrey"
            height: parent.height/6
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: radius
            radius: height/4
            Text {
                anchors.centerIn: parent
                id: welcometxt
                text: qsTr("Welcome to NazwaBanku")
                color:"black"
                width:text.width
                height: text.height
                font.pixelSize:parent.height/2 < parent.width/2 ? parent.height/2 : parent.width/2
            }
        }


        Rectangle{

            id:user_interface_rec
            clip: true
            anchors.top:welcomerec.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: 10
            anchors.bottomMargin: 50
            anchors.horizontalCenter: welcomerec.horizontalCenter
            radius: 5
            border.width:2
            z:1
            border.color: "red"
            width: root.width/2.2
            //            height: root.height-root.height/3

            Text {
                id: login_error_msg
                anchors.top:parent.top
                anchors.horizontalCenter:parent.horizontalCenter
                anchors.margins: 5
                text: log.getloginerror()
                width: loginrect.width
                height: loginrect.height/2
                color: "red"

            }

            Rectangle{
                property bool loginmodified:false

                id:loginrect
                anchors.top: login_error_msg.bottom
                anchors.horizontalCenter:parent.horizontalCenter
                anchors.margins: 5
                width: parent.width/2
                height: parent.height/15
                color:"lightgrey"

                TextInput{
                    id:logintxt
                    readOnly: false
                    anchors.fill: parent
                    color:"darkgrey"
                    clip: true
                    text: if(!loginrect.loginmodified) log.getusername()


                }
                MouseArea{
                    id:logtxtarea
                    anchors.fill:parent
                    onClicked: pinrect.state="adding_login";
                }


            }

            // PIN input
            Rectangle{
                property bool pinmodified:false
                id:pinrect
                anchors.top: loginrect.bottom
                anchors.horizontalCenter:parent.horizontalCenter
                anchors.margins: 10
                width: parent.width/2
                height: parent.height/15
                color:"lightgrey"
                TextInput  {
                    id:pin
                    echoMode: pinrect.pinmodified ? TextInput.Password : TextInput.Normal
                    anchors.centerIn: parent
                    clip:true
                    focus:false
                    width:text.width*4
                    height:parent.height-4
                    text: if(!pinrect.pinmodified) log.getpin()
                    font.pixelSize: height/1.2
                    color:"darkgrey"
                    maximumLength: 4
                    passwordMaskDelay:200
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:pinrect.state="using_keyboard"
                }


                states:[
                    State{
                        name:"adding_login"
                        PropertyChanges {target: loginrect; color:"darkgray"}
                        PropertyChanges {
                            target:logintxt;
                            color:"black";
                            text: if(!loginrect.loginmodified) ""
                            focus:true
                        }
                    },

                    State{
                        name:"not_adding_login"
                        PropertyChanges {target: loginrect; color:"lightgray"}
                        PropertyChanges {target:logintxt;color:"darkgray";focus:false; }

                    },

                    State {
                        name: "using_keyboard"
                        PropertyChanges {
                            target: pin
                            cursorVisible: false
                            passwordMaskDelay:100
                            echoMode:TextInput.Password
                            text: if(!pinrect.pinmodified) ""
                            color:"black"

                        }
                        PropertyChanges{ target: pinrect;color:"darkgrey" }
                    },

                    State{
                        name:"not_using_keyboard"
                        PropertyChanges {
                            target: pin
                            passwordMaskDelay:100
                            echoMode: pinrect.pinmodified ? TextInput.Password : TextInput.Normal
                            text: if(!pinrect.pinmodified)log.getpin()
                            color:"darkgrey"

                        }
                        PropertyChanges{   target: pinrect;color:"lightgrey" }

                    }
                ]

            }


            Grid{
                id:keyboard_grid

                rows:4;columns:3;spacing: 2
                anchors{top:pinrect.bottom;left: pinrect.left;right: pinrect.right }

                Repeater{
                    id:grid_repeater
                    model:keyboard_model
                    delegate:keyboard_component
                }
            }

            Rectangle{

                height: pinrect.height*1.5
                anchors.bottomMargin: 10
                anchors.left: keyboard_grid.left
                anchors.right: keyboard_grid.right
                anchors.top:keyboard_grid.bottom
                anchors.topMargin: pinrect.height/4
                color: confirm_area.pressed ? "darkred" : "red"
                radius:10


                Text{
                    anchors.centerIn: parent
                    color:"white"
                    text: "Log in"
                }

                MouseArea
                {
                    id : confirm_area
                    anchors.fill: parent
                    onClicked: {
                        if(log.loguserin(pin.text,log.getusername()) ){
                            console.log("logged in")
                            mainpage.source="qrc:/qml/loginanimation.qml"
                        }
                    }

                }
            }


        }
    }
}



