import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Rectangle {
    id: popup

    color: "red"
    border.color: "black"; border.width: 1
    radius: width/2

    y: parent.height // off "screen"
    anchors.horizontalCenter: parent.horizontalCenter
    width: 600
    height: label.height + 5

    opacity: 0

    function show(text, color) {
        if(!color)
            color = "red"
        popup.color = color
        label.text = text
        popup.state = "visible"
        timer.start()
        console.log("from alters showing: " + text);
    }
    states: State {
        name: "visible"
        PropertyChanges { target: popup; opacity: 1 }
        //PropertyChanges { target: popup; y: (parent.height-popup.height)/2 }
    }

    transitions: [
        Transition { from: ""; PropertyAnimation { properties: "opacity,y"; duration: 300 } },
        Transition { from: "visible"; PropertyAnimation { properties: "opacity,y"; duration: 1000 } }
    ]

    Timer {
        id: timer
        interval: 2500

        onTriggered: popup.state = ""
    }

    Text {
        id: label
        anchors.centerIn: parent
        color: "#ffffff"
        font.family: "Comic Sans MS"
        font.pointSize: 12
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        smooth: true
    }
}
