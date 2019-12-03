import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.12

ApplicationWindow {

    id: mainWindow

    visible: true
    width: 640
    height: 480
    title: qsTr("Pinch Example")

    visibility: Window.AutomaticVisibility
/*
    Rectangle {
        id: redRect
        width: 200
        height: 200
        color: "red"

        Rectangle {
            id: blueRect
            //x: 75; y: 75
            x: 85; y: 85
            width: 50; height: 50
            color: "blue"

            Rectangle {
                id: greenRect
                x: 10; y: 10
                width: 10; height: 10
                color: "green"
            }
        }

        Rectangle {
            id: yellowRect
            x: 95; y: 95
            width: 10; height: 10
            color: "yellow"
        }

        Rectangle {
            x: 0; y: 99
            width: 200; height: 2
            color: "black"
        }

        Rectangle {
            x: 99; y: 0
            width: 2; height: 200
            color: "black"
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                console.log("blueRect:", blueRect.x, blueRect.y, blueRect.width, blueRect.height, blueRect.scale);

                var point = blueRect.mapFromItem(yellowRect, 5, 5);
                console.log("point:", point.x, point.y);

                blueRect.scale += 1

                var point2 = blueRect.mapFromItem(yellowRect, 5, 5);
                console.log("point2:", point2.x, point2.y);

                blueRect.x += ((point2.x - point.x) * blueRect.scale)
                blueRect.y += ((point2.y - point.y) * blueRect.scale)
            }
        }
    }
    */
    PinchArea {

        id: pinchArea
        anchors.fill: parent

        //pinch.target: content
        //pinch.minimumScale: 0.1
        //pinch.maximumScale: 10

        Rectangle {
            id: centerMark
            x: 0; y:0
            width: 5; height: 5
            color: "red"
            radius: 5
        }

        Item {
            id: content

            x: 0
            y: 0
            width: 500
            height: 500

            Rectangle {
                x: 10; y: 10; width: 10; height: 10
                color: "red"
            }

            Rectangle {
                x: 180; y: 10; width: 10; height: 10
                color: "green"
            }

            Rectangle {
                x: 10; y: 180; width: 10; height: 10
                color: "blue"
            }

            Rectangle {
                x: 180; y: 180; width: 10; height: 10
                color: "yellow"
            }

            Rectangle {
                x: 95; y: 95; width: 10; height: 10
                color: "gray"
            }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            drag.target:  content
            property Rectangle highlightItem : null;
            property var originPointX : null;
            property var originPointY : null;
            onClicked: {
                content.x = 0;
                content.y = 0;
                content.scale = 1;
            }
        }

        onPinchUpdated: {

            // store mapping before and after scaling
            var point = content.mapFromItem(pinchArea, pinch.previousCenter.x, pinch.previousCenter.y);

            // apply scaling
            content.scale += (pinch.scale - pinch.previousScale);

            var point2 = content.mapFromItem(pinchArea, pinch.previousCenter.x, pinch.previousCenter.y);

            // move content according to movement of translated points
            content.x += ((point2.x - point.x) * content.scale)
            content.y += ((point2.y - point.y) * content.scale)

            // dragging
            content.x += pinch.center.x - pinch.previousCenter.x;
            content.y += pinch.center.y - pinch.previousCenter.y;
        }

        onPinchFinished: {
            //content.update();
        }
    }
}
