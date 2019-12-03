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

    PinchArea {

        anchors.fill: parent

        /*
        pinch.target: content
        pinch.minimumScale: 0.1
        pinch.maximumScale: 10
        */

        property real previousPoint1x: 0
        property real previousPoint1y: 0
        property real previousPoint2x: 0
        property real previousPoint2y: 0

        Item {
            id: content

            x: 0
            y: 0
            width: mainWindow.width
            height: mainWindow.height

            Rectangle {
                x: 10; y: 10; width: 10; height: 10
                color: "red"
            }

            Rectangle {
                x: 200; y: 10; width: 10; height: 10
                color: "green"
            }

            Rectangle {
                x: 10; y: 200; width: 10; height: 10
                color: "blue"
            }

            Rectangle {
                x: 200; y: 200; width: 10; height: 10
                color: "yellow"
            }

            Rectangle {
                x: 100; y: 100; width: 10; height: 10
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
        }

        onPinchStarted: {
            previousPoint1x = pinch.point1.x;
            previousPoint1y = pinch.point1.y;
            previousPoint2x = pinch.point2.x;
            previousPoint2y = pinch.point2.y;
        }

        onPinchUpdated: {

            //var oldScale = content.scale;

            var panOffset1X = pinch.point1.x - previousPoint1x;
            var panOffset1Y = pinch.point1.y - previousPoint1y;
            var panOffset2X = pinch.point2.x - previousPoint2x;
            var panOffset2Y = pinch.point2.y - previousPoint2y;

            // scroll scaled to pinched position
            //var widthDiff = (content.width * content.scale) - (content.width * oldScale);
            //var heightDiff = (content.height * content.scale) - (content.height * oldScale);

            //content.x -= widthDiff / 2;
            //content.y -= heightDiff / 2;

            content.x += panOffset1X * content.scale;
            content.x += panOffset2X * content.scale;
            content.y += panOffset1Y * content.scale;
            content.y += panOffset2Y * content.scale;

            content.scale += (pinch.scale - pinch.previousScale);

            // don't scale to negative
            if (content.scale < 0.1)
                content.scale = 0.1;

            // update previous point values
            previousPoint1x = pinch.point1.x;
            previousPoint1y = pinch.point1.y;
            previousPoint2x = pinch.point2.x;
            previousPoint2y = pinch.point2.y;
        }

        onPinchFinished: {
            //content.update();
        }
    }

}
