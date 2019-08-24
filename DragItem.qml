import QtQuick 2.7

Item {
    id: root

    width: 64; height: 64

    property color rect_color: "#1b4caf"
    property string text: modelData

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        drag.target: dragrect

        onReleased: {
            parent = dragrect.Drag.target !== null ? dragrect.Drag.target : root
            dragrect.Drag.drop();
        }

        Rectangle {
            id: dragrect
            z: root.z + 1

            width: root.width
            height: root.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: rect_color
            radius: width/9

            Drag.active: mouseArea.drag.active
            Drag.mimeData: { "text/plain": root.text }
            Drag.dragType: Drag.Automatic
            Drag.hotSpot.x: width/2
            Drag.hotSpot.y: height/2
            //Drag.onDragFinished: txt.color = "red"

            Text
            {
                id: txt
                anchors.fill: parent
                color: "#ffffff"
                font.pointSize: 10
                font.family: "Comic Sans MS"
                text: qsTr(root.text)
                horizontalAlignment:Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            states: State {
                when: mouseArea.drag.active
                ParentChange { target: dragrect; parent: root }
                AnchorChanges { target: dragrect; anchors.verticalCenter: undefined; anchors.horizontalCenter: undefined }
            }

        }
    }
}

