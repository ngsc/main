import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0
import Constants 1.0

Rectangle
{
    id: root

    property alias text: txt.text
    property int shadowVertOffset : 6
    property int shadowHorizOffset: 6

    signal clicked

    width: 100
    height: 30
    color: "#989898"
    radius: width/3
    layer.enabled: true
    layer.effect:  DropShadow {
        id: rootShadow
        //cached: true
        horizontalOffset: shadowVertOffset
        verticalOffset: shadowVertOffset
        radius: 3
        samples: 7
        color: "#80000000"
    }

    Text
    {
        id: txt
        anchors.centerIn: parent
        color: "#e6e6e6"
        font.pointSize: 10
        font.family: Constants.primaryFont ? Constants.primaryFont.name: null
        text: qsTr("Button")
    }

    MouseArea
    {
        id: mouseArea
        anchors.fill: parent
        z: 1
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked:
        {
            root.clicked();
        }
        onEntered:
        {
            root.state = "entered";
        }
        onExited:
        {
            root.state = "exited";
        }

        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
    }
    states: [
        State {
            name: "pressed"; when: mouseArea.pressed
            PropertyChanges { target: root; anchors.rightMargin: anchors.rightMargin - 3; anchors.bottomMargin: anchors.bottomMargin - 3; shadowHorizOffset: 0; shadowVertOffset: 0 }
        },
        State{
            name: "entered";
            PropertyChanges { target: root; scale: 1.03 }
            PropertyChanges { target: txt; color: "#ffffff" }
        },
        State{
            name: "exited";
            PropertyChanges { target: txt; color: "#e6e6e6" }
        }]

    transitions: Transition {
        NumberAnimation  { properties: "shadowHorizOffset,shadowVertOffset"; duration:100; easing.type: Easing.InOutQuad }
        NumberAnimation { properties: "scale"; duration: 100; easing.type: Easing.InOutQuad }
    }
}
