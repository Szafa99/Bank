import QtQuick 2.12
import QtQuick.Window 2.12

Item {


    id:root
    anchors.fill: parent

    Connections{
    target: logoanim
    onFinished:mainpage.source="qrc:/qml/mainwindow.qml";
    }

    SequentialAnimation{
        id:logoanim
        running: true
        ScaleAnimator{

            id:logoanim1
            target: logo
            from:0.5
            to:2
            running: true
            duration: 1000

        }
        ParallelAnimation{

            id:logoanim2
            ScaleAnimator{
                target: logo
                from:2
                to:1.5
                easing.type: Easing.OutExpo
                duration: 800


            }

            OpacityAnimator {
                id:lastanim
                target: logo
                from:1
                to:0.3
                easing.type: Easing.OutExpo
                duration: 1000

            }

        }

    }
    Rectangle{
        id:animre
        anchors.fill: parent
        color: "black"

        Image{

            anchors.centerIn: parent
            id:logo
            source: "../images/agh.jpg"
            width :200
            height: 200
        }



    }
}
