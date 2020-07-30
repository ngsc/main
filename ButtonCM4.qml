import QtQuick 2.0

import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import Constants 1.0


Rectangle
{
    id: root
    radius: Constants.menuRectRadius / 4
    color: "transparent"
    property string button_text:""
    property bool boldfont: true
    property bool italicfont: false
    property string imagePath: ""
    property string disabledImagePath: ""

    signal clicked

    Rectangle
    {
        id: inner_box
        anchors.fill: parent
        radius: parent.radius
        color: Constants.menuBackgroundColor
        border.width: 1
        opacity: root.enabled ? 1 : 0.5
        border.color: "transparent"
    }
    Image
    {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.Stretch
        anchors.margins: 5
        opacity: root.enabled ? 1 : 0.5
        source: root.enabled ? root.imagePath: root.disabledImagePath
    }
    Text
    {
        id : text
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        color: Constants.menuTextColor
        font.family: Constants.primaryFont ? Constants.primaryFont.name: null//"Kristen ITC"
        font.pointSize: 15
        font.bold: boldfont
        font.italic: italicfont
        text: qsTr(button_text)
    }
    MouseArea
    {
        id: mouseArea
        anchors.fill: parent
        z: 1
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        enabled: root.enabled
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
            PropertyChanges {
                target: inner_box
                border.color: Constants.buttonMarginColor
                border.width: 1
            }
        },
        State {
            name: "unclicked"; when: !mouseArea.pressed
            PropertyChanges {
                target: inner_box
                border.color: "transparent"
                border.width: 1
            }
        }
    ]
}
