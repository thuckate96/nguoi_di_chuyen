import QtQuick 2.6
import QtQuick.Window 2.2
import "qml"
import QtQuick.Controls 1.4
import imageChange 1.0
import myTimer 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Moving")
    id: root
    function updateImage(){
        timer.start()
        changeMyImg.changedImage()
    }
    //This is Rectangle containt Image and three Rectangle have position To move Image to
    Rectangle{

        width: root.width
        height: root.height
        id: page
        // Using QTimer to delay Image
        QTimer{
            id: timer
            interval: 200
            onTimeout: {
                updateImage()
            }
        }
        //Using it in qml to Call the function defind in cpp file
        ImageChange{
            id: changeMyImg
        }


        Image {
            id: giaodien
            source: "images/giaodienbibi.png"
            width: page.width
            height: page.height
        }
        //Image with animation
        Image{

            id: imgMove
            width: 50
            height: 100
            x: topRect.x+50;
            y: topRect.y-50;
            source: changeMyImg.sourceImage


        }
        Rectangle{
            id: topRect
            width: 50;height: 50
            anchors{left: parent.left;bottom: parent.bottom ; leftMargin: 20; bottomMargin: 20}
            color: "red"; border.color: "Gray";radius: 6
            MouseArea{anchors.fill: parent; onClicked: {updateImage();page.state=""}}
        }
        Rectangle{
            id: midRightRect
            width: 50; height: 50
            anchors {right: parent.right;bottom: parent.bottom; rightMargin: 10; bottomMargin: 150 }
            color: "red" ; border.color: "gray"; radius: 6
            MouseArea{anchors.fill: parent;onClicked: {updateImage();page.state="moveMidRight"}}
        }

        states:
            State {
                name: "moveMidRight"
                PropertyChanges {
                    target: imgMove
                    x: midRightRect.x
                    y: midRightRect.y
                }
            }
        transitions: [
            Transition {
                from: "*"
                to: "moveMidRight"
                NumberAnimation{properties: "x,y"; easing.type: Easing.Linear; duration: 7000}
            },

            Transition {
                NumberAnimation{properties: "x,y"; easing.type: Easing.Linear; duration: 7000}
            }
        ]
    }
}
