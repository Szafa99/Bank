import QtQuick 2.12
import QtQuick.Controls 2.12
import Currency_list 1.0
import QtGraphicalEffects 1.0
import Action_enum 1.0
Item {
    id:root
    anchors.fill: parent


    // ============== MASKS
    Connections{
        target: users_currencys
        function onChoosencurrencyChanged(){
            users_currencys.hidelist()
            users_currencys.modelReset()
            inputype.text = " " + users_currencys.getactivecurrency().type
            Form.form_editedChanged()
        }
    }

    Rectangle{
        id:bigmask
        visible: false
        height: root.height*0.3
        width: height
        radius:height/2
        clip: true
    }
    Rectangle{
        id:smallmask
        visible: false
        height: bigmask.height * 0.5
        width: height
        radius:height/2
        clip: true
    }
    //=============================


    //======================================




    ListView {
        id: currencylist
        anchors.fill: parent
        clip: true
        z:2
        model: users_currencys


        delegate: Rectangle {
            id: currencyrec

            z:10
            width: currencylist.width
            height: root.height/list_el_displayed
            color: index==0 ? "#acd3e8" :"white"


            MouseArea{
                id:currencyarea
                anchors.fill: parent
                onPressed: parent.color="#65b2db"
                onReleased:  {
                    if(index==0)
                        parent.color= "#acd3e8"
                    else parent.color= "white"
                }
                onClicked: {
                    users_currencys.setactivecurrency(index)
                }

            }
            Rectangle {
                width: parent.width
                height: 2
                color: "grey"
            }

            Text {
                text: "1 " + model.type
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: flag.left
                anchors.leftMargin: root.width*0.1
                font.bold: true
            }


            Item{
                id:flag
                anchors.right: parent.right
                anchors.rightMargin: root.width*0.3
                height: bigmask.height
                width:root.height*0.04
                anchors.verticalCenter: parent.verticalCenter

                Image{
                    id:bigimage
                    anchors.verticalCenter: parent.verticalCenter
                    anchors{left:parent.left;top: parent.top}
                    width: bigmask.width
                    height: bigmask.height


                    source: model.filepath
                    fillMode: Image.PreserveAspectCrop
                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: bigmask
                    }
                }
                Image {
                    //anchors{right: parent.right;bottom: parent.bottom}
                    x:bigimage.x+bigimage.width*0.6
                    y:bigimage.y+bigimage.height*0.6
                    height: smallmask.height
                    width: smallmask.width

                    visible: true //handle logic later
                    z:1
                    source: index==0 ? "../images/check.jpg" : ""
                    fillMode: Image.PreserveAspectCrop
                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: smallmask
                    }
                }

            }




        }
    }


}
