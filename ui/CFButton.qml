import QtQuick
import QtQuick.Controls

Item {
    id: root
    width: 80
    height: 25
    property string text: "Button"
    signal clicked()
    signal hovered()
    signal unhovered()
    Rectangle {
        anchors.fill: parent
        color: "#2e2e2e"
        radius: 10
        border.color: "#555"
        border.width: 1
    }
    Text {
        anchors.centerIn: parent
        text: root.text
        color: "white"
        font.pixelSize: 12
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: root.hovered()
        onExited: root.unhovered()
        onClicked: {
            root.clicked()
        }
    }
}