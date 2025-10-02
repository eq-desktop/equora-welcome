import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland
import qs
import qs.pages

PanelWindow {
    id: panelWindow
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    exclusiveZone: -1
    anchors {
        top: true
        left: true
        right: true
        bottom: true
    }

    color: "transparent"

    FontLoader { id: sfPro; source: Qt.resolvedUrl(Quickshell.shellDir + "/SF-Pro-Display-Regular.otf") }

    Rectangle {
        id: root
        anchors.fill: parent
        color: "black"
        focus: true

        Keys.onEscapePressed: {
            Quickshell.execDetached(["pkill", "qs"])
        }

        Image {
            id: image
            anchors.fill: parent
            opacity: 0
            source: Qt.resolvedUrl(Quickshell.shellDir + "/Star-Lens.jpg")
            Component.onCompleted: {
                image.opacity = 1
            }
            Behavior on opacity { NumberAnimation { duration: 5000 } }
            layer.enabled: true
            layer.effect: MultiEffect {
                blurEnabled: true
                blur: 1
                blurMax: 64
            }
        }

        Rectangle {
            id: vignette
            anchors.fill: parent
            anchors.margins: -30
            color: "#20000000"
            border {
                width: 30
                color: "black"
            }
            radius: 0
            layer.enabled: true
            layer.effect: MultiEffect {
                blurEnabled: true
                blur: 1
                blurMax: 64
            }
        }

        Loader {
            id: welcomeLoader
            anchors.fill: parent
            property Component welcome: Welcome  { id: welcome }
            active: true
            sourceComponent: welcome
        }
        Timer { running: true; interval: 6000; onTriggered: {setupLoader.active = true } }
        Loader {
            id: setupLoader
            anchors.fill: parent
            property Component setup: Setup  {
                property Component language: Language  { id: language; onContinuePage: setup.continuePage(); }
                property Component country:  Country   { id: country;  onContinuePage: setup.continuePage(); onPreviousPage: setup.previousPage(); }
                id: setup
                pages: [
                    language,
                    country
                ]
            }
            active: true
            sourceComponent: setup
        }
    }
}