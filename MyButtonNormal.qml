import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0

Rectangle
{
    id: root

    property alias text: txt.text

    signal clicked

    width: 100
    height: 30
    color: "#1b4caf"
    radius: width/3

    Text
    {
        id: txt
        anchors.centerIn: parent
        color: "#ffffff"
        font.pointSize: 10
        font.family: "Comic Sans MS"
        text: "Button"
    }

    MouseArea
    {
        id: mouseArea
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: { root.clicked() }
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
    }
}
