import QtQuick
import QtQuick.Effects
import Quickshell
import qs

Item {
    id: root
    anchors.fill: parent
    Text {
        id: welcome
        text: Config.welcome
        color: "white"
        anchors {
            top: parent.top
            topMargin: (root.height/2) - (welcome.implicitHeight/2)
            horizontalCenter: parent.horizontalCenter
        }
        opacity: 0
        scale: 1
        Component.onCompleted: {
            scale = 1.2
            blur = 0
            opacity = 1
            shadowOpacity = 1
        }
        property real blur: 1
        property int shadowOpacity: 0
        Behavior on blur { NumberAnimation { duration: 2000 } }
        Behavior on opacity { NumberAnimation { duration: 2000 } }
        Behavior on shadowOpacity { NumberAnimation { duration: 2000 } }
        Behavior on scale { NumberAnimation { duration: 2000; easing.type: Easing.OutBack; easing.overshoot: 1 } }
        font.pixelSize: 50
        font.family: sfPro.font.family
        layer.enabled: true
        layer.effect: MultiEffect {
            id: welcomeEffect
            blurEnabled: true
            shadowEnabled: true
            shadowColor: "white"
            shadowBlur: 1
            shadowOpacity: welcome.shadowOpacity
            blur: welcome.blur
            blurMax: 64
        }
        renderType: Text.CurveRendering
        Timer {
            interval: 4000
            running: true
            onTriggered: {
                welcome.blur = 1
                welcome.shadowOpacity = 1
                welcome.opacity = 0
            }
        }
    }
}