import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import Register 1.0
import Transfer 1.0

Window{
    id:mainprog
    title: "Bank"
    visible: true
    minimumHeight: 180
    minimumWidth: 340
    width: 640
    height: 480
    property string formcontent
    property string formcontent_nav
    property QtObject formtype

        Loader{

        anchors.fill: parent
         id:mainpage

         focus:true
         source: "qrc:/qml/login.qml"
     }


}
