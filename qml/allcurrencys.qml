import QtQuick 2.12
import QtQuick.Controls 2.12
import Currency_list 1.0
import QtGraphicalEffects 1.0
import Action_enum 1.0
Item {
    id:root
    anchors.fill: parent
    z:2
    property string accountnumber:Form.get_form_cell("AccountNumber")
    // ============== MASKS
    Connections{
        target: currencys
        onChoosencurrencyChanged:{
            currencys.hidelist()
            currencys.modelReset()
            listsize=currencys.rowCount(currencys.parent)
            Form.forcedInput(currencys.getcurrencyName(),"Currency")
            Form.forcedInput(currencys.getcurrencyName() + " " + accountnumber,"AccountNumber" )
        }
    }

        Rectangle{
            id:bigmask
            visible: false
            anchors.left: parent.left
            anchors.leftMargin: root.width*0.1
            height: root.height*0.035
            width: height
            radius:height/2
            clip: true
        }
        Rectangle{
            id:smallmask
            visible: false
            anchors.left: parent.left
            anchors.leftMargin: root.width*0.01
            height: root.height*0.015
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
            model: currencys


            delegate: Rectangle {
                id: currencyrec
//                objectName: "dd"+model.index
                z:2
                width: currencylist.width
                //height: root.height/currencys.rowCount(parent)
                height: root.height/3
                color: index==0 ? "#acd3e8" :"white" //handle logic later


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
                    currencys.setactivecurrency(index)
                }

                }
                Rectangle {
                    width: parent.width
                    height: 2
                    color: "grey"
                }



                Item{
                    id:flag
                    anchors.left: parent.left
                    anchors.leftMargin: root.height*0.21
                    height: bigmask.height
                    width:root.height*0.04
                    anchors.verticalCenter: parent.verticalCenter

                    Image{

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
                        anchors{right: parent.right;bottom: parent.bottom}
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


                Text {
                    anchors.left:flag.right
                    anchors.leftMargin: 5
                    text: model.type
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                }

                Text {
                    text: model.converter+"PLN"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: parent.width*0.07
                    font.bold: true
                }


            }
        }


}
