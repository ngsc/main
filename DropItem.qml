import QtQuick 2.7

DropArea {
    id: root

    property string text
    property alias dropProxy: root

    width: 64; height: 64

    onDropped: {
        console.log("drag.source: " + root.drag.source.text)

        if (drop.proposedAction == Qt.MoveAction || drop.proposedAction == Qt.CopyAction) {
            root.text = drop.text
            console.log("root.txt: " + root.text);
            drop.accept(Qt.CopyAction);
            drop.accepted = true
        }
    }

    Rectangle {
        id: droprect

        anchors.fill: parent
        color: "white"
        radius: width/9;

        Text
        {
            id: txt
            anchors.centerIn: parent
            color: "green"
            font.pointSize: 10
            font.family: "Comic Sans MS"
            text: qsTr(root.text)
            }

        states: [
            State {
                when: root.containsDrag
                PropertyChanges {
                    target: droprect
                    color: "grey"
                }
            }
        ]
    }
}

