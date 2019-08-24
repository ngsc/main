import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import com.Game.Player 1.0

Rectangle
{
    id: mainPage
    color: "transparent"
    property string titleBar: qsTr("Snarky Manager Online")

    function setButtonEnable(enabled){
        my_button1.enabled = enabled
        my_button2.enabled = enabled
    }
    MonitorControl{
        id: monitorControl
    }
    ButtonMainPage
    {
        id: my_button1
        //        anchors.left: parent.left
        //        anchors.verticalCenter: parent.verticalCenter
        x : parent.width/5
        y : parent.height/5
        anchors.leftMargin: 30
        button_text: qsTr("Start")
        MouseArea
        {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                callinsidepage2(signinPage)//(inside_1)
            }
            onPressed: {parent.state="clicked"}
            onReleased: {parent.state="unclicked"}
        }
    }

    ButtonMainPage
    {
        id: my_button2
        //        anchors.left: my_button1.right
        //        anchors.verticalCenter: parent.verticalCenter
        x : 3*parent.width/5
        y : 3*parent.height/5
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
        //        anchors.left: my_button2.right
        //        anchors.verticalCenter: parent.verticalCenter
        x : 3*parent.width/5
        y : parent.height/5
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
        //        anchors.left: my_button3.right
        //        anchors.verticalCenter: parent.verticalCenter
        x : parent.width/5
        y : 3*parent.height/5
        anchors.leftMargin: 30
        button_text: qsTr("Monitor")
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

