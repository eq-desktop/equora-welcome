import QtQuick
import QtQuick.Effects
import QtQuick.VectorImage
import Quickshell
import qs

Item {
    id: root
    anchors.fill: parent
    opacity: 0
    Component.onCompleted: {
        opacity = 1
    }
    function continuePage() {
        root.currentPage++
        if (root.currentPage >= root.pages.length) {
            
        }
    }
    function previousPage() {
        root.currentPage--
    }
    property list<var> pages: []
    property int currentPage: 0
    Behavior on opacity { NumberAnimation { duration: 500 } }
    Rectangle {
        id: background
        anchors.centerIn: parent
        color: '#1e1e1e'
        radius: 20
        width: parent.width * 0.5
        height: parent.height * 0.6
        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
        }

        Loader {
            anchors.fill: parent
            active: true
            sourceComponent: root.pages[root.currentPage]
        }
    }
    Text {
        width: background.width - 40
        anchors {
            top: background.bottom
            topMargin: 20
            horizontalCenter: background.horizontalCenter
        }
        wrapMode: Text.WordWrap
        color: "#fff"
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
        text: Translation.tr("By using this software, you agree to the terms of the software license agreement for the software. You can view the terms of the software license agreement at https://github.com/eq-desktop/eqsh/blob/master/LICENSE")
    }
}