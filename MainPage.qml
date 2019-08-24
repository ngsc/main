import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0

Rectangle
{
    id: mainPage
    color: "transparent"
    property string titleBar: qsTr("Snarky Manager Online")

    ButtonMainPage
    {
        id: my_button1
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 30
        button_text: qsTr("Start")
        MouseArea
        {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                callinsidepage2(inside_1)
            }
            onPressed: {parent.state="clicked"}
            onReleased: {parent.state="unclicked"}
        }
    }

    ButtonMainPage
    {
        id: my_button2
        anchors.left: my_button1.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 30
        button_text: qsTr("Reload")
        MouseArea
        {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            acceptedButtons: Qt.LeftButton
            onPressed: {parent.state="clicked"}
            onReleased: {parent.state="unclicked"}
        }
    }

    ButtonMainPage
    {
        id: my_button3
        anchors.left: my_button2.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 30
        button_text: qsTr("Config")
        MouseArea
        {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            cursorShape: Qt.PointingHandCursor
            onPressed: {parent.state="clicked"}
            onReleased: {parent.state="unclicked"}
            onClicked:
            {
                callinsidepage2(configPage)
            }
        }
    }

    ButtonMainPage
    {
        id: my_button4
        anchors.left: my_button3.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 30
        button_text: qsTr("Exit")
        MouseArea
        {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            acceptedButtons: Qt.LeftButton
            onPressed: {
                parent.state="clicked"
                confirmingbox.visible = true
            }
            onReleased: {parent.state="unclicked"}
        }
    }
    ButtonMainPage
    {
            id: my_button5
            anchors.left: my_button2.right
            anchors.top: my_button4.bottom
            anchors.verticalCenter: parent.verticalCenter + 30
            anchors.leftMargin: 30
            anchors.topMargin: 30
            button_text: "Monitor"
            MouseArea
            {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton
                onClicked: {
                    // monitorControl.monitorStart()
                    callinsidepage2(monitor)
                }
                onPressed: {parent.state="clicked"}
                onReleased: {parent.state="unclicked"}
            }
    }
}

