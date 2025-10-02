import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.VectorImage
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs
import qs.ui

Item {
    id: root

    anchors.fill: parent
    opacity: 1

    signal continuePage()
    signal previousPage()
    VectorImage {
        id: vectorImage
        anchors {
            top: parent.top
            topMargin: 50
            horizontalCenter: parent.horizontalCenter
        }
        source: Qt.resolvedUrl(Quickshell.shellDir + "/media/globe.svg")
        width: 65
        height: 65
        preferredRendererType: VectorImage.CurveRenderer
        layer.enabled: true
        layer.effect: MultiEffect {
            colorization: 1
            colorizationColor: '#1884ff'
        }
    }

    Text {
        id: text
        anchors {
            top: vectorImage.bottom
            topMargin: 20
            horizontalCenter: parent.horizontalCenter
        }
        text: Translation.tr("Select Your Country or Region")
        color: "white"
        font.pixelSize: 25
        font.weight: 600
    }

    ClippingRectangle {
        width: 250
        height: 250
        anchors {
            top: text.bottom
            topMargin: 20
            horizontalCenter: parent.horizontalCenter
        }
        color: "#2e2e2e"
        radius: 0
        ListView {
            id: languageList
            anchors.fill: parent
            width: 250
            FileView {
                id: fileViewer
                path: Qt.resolvedUrl(Quickshell.shellDir + "/data/countries.json")
                blockLoading: true
                JsonAdapter {
                    id: adapter
                    property list<var> countries: []
                }
            }
            model: adapter.countries
            delegate: Rectangle {
                width: 250
                height: 20
                color: Output.selectedCountry == index ? "#2369ff" : "#2e2e2e"
                radius: 0

                property bool hovered: false

                Text {
                    anchors.centerIn: parent
                    text: modelData.name
                    color: "white"
                    font.pixelSize: 12
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: hovered = true
                    onExited: hovered = false
                    onClicked: {
                        Output.selectedCountry = index
                    }
                }
            }
            spacing: 0
        }
    }

    CFButton {
        id: backButton
        anchors {
            bottom: parent.bottom
            right: continueButton.left
            bottomMargin: 15
            rightMargin: 10
        }
        text: Translation.tr("Back")
        onClicked: {
            root.previousPage()
        }
    }

    CFButton {
        id: continueButton
        anchors {
            bottom: parent.bottom
            right: parent.right
            bottomMargin: 15
            rightMargin: 20
        }
        text: Translation.tr("Continue")
        onClicked: {
            root.continuePage()
        }
    }
}