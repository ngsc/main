import QtQuick 2.0
import Constants 1.0

Rectangle
{
    id: root
    property string teamName
    property int score
    property string teamColor
    radius: Constants.menuRectRadius
    visible: false
    color: teamColor
    Text
    {
        id: teamNameRect
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 20
        //color: "white"
        font.pointSize: Constants.defaultClubFontSize; font.bold: true
        font.family: Constants.primaryFont ? Constants.primaryFont.name: null
        text: teamName
    }
    Rectangle
    {
        id: scoreRect
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        width: height
        color: "white"
        border.width: 2
        border.color: "black"
        radius: Constants.menuRectRadius
        Text
        {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: Constants.defaultClubFontSize; font.bold: true
            font.family: Constants.primaryFont ? Constants.primaryFont.name: null
            text: score
            //text: "First team"
        }
    }
}
