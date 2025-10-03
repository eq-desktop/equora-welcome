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
        anchors.centerIn: parent
        opacity: 0
        scale: 1
        property real blur: 1
        property real shadowOpacity: 0

        Behavior on shadowOpacity { NumberAnimation { duration: 80; easing.type: Easing.InOutQuad } }
        Behavior on blur { NumberAnimation { duration: 2000 } }
        Behavior on opacity { NumberAnimation { duration: 1000 } }
        Behavior on scale { NumberAnimation { duration: 2000; easing.type: Easing.OutBack; easing.overshoot: 1 } }

        Component.onCompleted: {
            scale = 1.2
            blur = 0
            opacity = 1
            shadowOpacity = 1
        }
        font.pixelSize: 50
        font.family: sfPro.font.family
        layer.enabled: true
        layer.effect: MultiEffect {
            blurEnabled: true
            shadowEnabled: true
            shadowColor: "white"
            shadowBlur: 1
            shadowOpacity: welcome.shadowOpacity
            blur: welcome.blur
            blurMax: 64
        }

        Timer {
            interval: 4000 
            running: true 
            onTriggered: {
                welcome.blur = 1 
                welcome.shadowOpacity = 1 
                welcome.opacity = 0
            }
        }

        Timer {
            interval: 2000 
            running: true 
            onTriggered: {
                flicker.start()
            }
        }

        SequentialAnimation {
            id: flicker
            loops: Animation.Infinite
            NumberAnimation { target: welcome; property: "shadowOpacity"; to: 0.6; duration: 80 }
            NumberAnimation { target: welcome; property: "shadowOpacity"; to: 1; duration: 120 }
            NumberAnimation { target: welcome; property: "shadowOpacity"; to: 0.8; duration: 60 }
            NumberAnimation { target: welcome; property: "shadowOpacity"; to: 1; duration: 150 }
        }
    }
}