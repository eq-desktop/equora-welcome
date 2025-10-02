pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick


Singleton {
    property string version: "0.1.0"
    property string welcome: Translation.tr("Welcome to Equora")
    property string image: "Star-Lens.jpg"
}