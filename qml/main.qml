import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

Window{
    visible: false
 Loader{
     Loader{
         id:mainpage
         anchors.fill: parent
         source: "qrc:/qml/login.qml"

     }

 }

}
