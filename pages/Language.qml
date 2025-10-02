import QtQuick
import QtQuick.Effects
import QtQuick.VectorImage
import Quickshell
import Quickshell.Widgets
import qs

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
        source: Qt.resolvedUrl(Quickshell.shellDir + "/media/lang.svg")
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
        text: Translation.tr("Language")
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
            model: ListModel {
                ListElement { code: "en_US"; name: "English" }
                ListElement { code: "de_DE"; name: "Deutsch" }
                ListElement { code: "es_ES"; name: "Español" }
                ListElement { code: "it_IT"; name: "Italiano" }
                ListElement { code: "ja_JA"; name: "日本語" }
                ListElement { code: "fr_FR"; name: "Français"; disabled: true }
                ListElement { code: "pt_BR"; name: "Português"; disabled: true }
                ListElement { code: "zh_CN"; name: "中文"; disabled: true }
                ListElement { code: "ko_KR"; name: "한국어"; disabled: true }
                ListElement { code: "ru_RU"; name: "Русский"; disabled: true }
                ListElement { code: "pl_PL"; name: "Polski"; disabled: true }
            }
            delegate: Rectangle {
                width: parent.width
                height: 20
                color: Output.selectedLanguage == index && !disabled ? "#2369ff" : "#2e2e2e"
                radius: 0

                property bool hovered: false

                Text {
                    anchors.centerIn: parent
                    text: name
                    color: disabled ? "gray" : "white"
                    font.pixelSize: 12
                }

                MouseArea {
                    enabled: !disabled
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: hovered = true
                    onExited: hovered = false
                    onClicked: {
                        Output.selectedLanguage = index
                        Translation.languageCode = code
                    }
                }
            }
            spacing: 0
        }
    }

    VectorImage {
        id: continueButton
        anchors {
            bottom: parent.bottom
            right: parent.right
            bottomMargin: 15
            rightMargin: 20
        }
        source: Qt.resolvedUrl(Quickshell.shellDir + "/media/continue.svg")
        width: 25
        height: 25
        preferredRendererType: VectorImage.CurveRenderer
        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.continuePage()
            }
        }
    }
}