import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

Window{
    visible: false
    minimumHeight: 180
    minimumWidth: 340
    width: 640
    height: 480

     Loader{
         id:mainpage
         anchors.fill: parent
         focus:true
         source: "qrc:/qml/login.qml"

     }


}
