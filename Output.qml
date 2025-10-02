pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property alias selectedLanguage: adapter.selectedLanguage
    property alias selectedCountry: adapter.selectedCountry

    Component.onCompleted: {
        root.selectedLanguage = 0
        root.selectedCountry = 0
    }

    FileView {
		id: fileViewer
        path: Qt.resolvedUrl(Quickshell.shellDir + "/output.json")
		blockLoading: true
        watchChanges: true
		onAdapterUpdated: writeAdapter()
		JsonAdapter {
			id: adapter
			property int selectedLanguage: 0
			property int selectedCountry: 0
		}
	}

    Process {
        command: ["ls", Quickshell.shellDir + "/output.json"]
        running: true; stderr: StdioCollector { onStreamFinished: if (this.text != "") Quickshell.execDetached(["touch", Quickshell.shellDir + "/output.json"]); }
    }
}