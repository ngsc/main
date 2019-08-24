/*
** Added by Ahmed Soliman
** For further information use the contact form at AhmedSoliman_1234@hotmail.com.
*/
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
Rectangle
{
    id: inside_1
    color: "transparent"
    property string titleBar: "Inside 1"

    Rectangle
    {
        anchors.fill: parent
        color: "transparent"
        ColumnLayout
        {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 300
            height: 250
            z:parent.z+1
            ButtonMainPage
            {
                id: solo
                width: 300
                property bool boldfont_1: false
                property bool italicfont_1: false
                boldfont: solo.boldfont_1
                italicfont: solo.italicfont_1
                anchors.leftMargin: 30
                button_text: qsTr("Solo Trials")
                z:parent.z+1
                Rectangle{
                    id: solohint
                    x:300
                    y:50
                    radius: 10
                    width: solohinttext.width+2
                    height: solohinttext.height+2
                    visible: false
                    ///anchors.leftMargin: 30
                    color: "#DAF7A6"
                    Text {
                        id :solohinttext
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        padding: 5
                        font.pointSize: 9
                        text: qsTr("standalone mode for beginners")
                        color:"gray"
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        app.callinsidepage2(inside_2)
                    }
                    acceptedButtons: Qt.LeftButton
                    onPressed: {parent.state="clicked"}
                    onReleased: {parent.state="unclicked"}
                    onEntered: {
                        solo.boldfont_1 = true
                        solo.italicfont_1 = true
                        solohint.visible = true
                    }
                    onExited: {
                        solo.boldfont_1 = false
                        solo.italicfont_1 = false
                        solohint.visible = false
                    }
                }
            }

            ButtonMainPage
            {
                id: net
                width: 300
                property bool boldfont_1: false
                property bool italicfont_1: false
                boldfont: net.boldfont_1
                italicfont: net.italicfont_1
                anchors.leftMargin: 30
                button_text: qsTr("Net Challenge")
                z:parent.z+1
                Rectangle{
                    id: nethint
                    x:300
                    y:50
                    radius: 10
                    width: nethinttext.width+2
                    height: nethinttext.height+2
                    visible: false
                    color: "#DAF7A6"
                    Text {
                        id : nethinttext
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        padding: 5
                        font.pointSize: 9
                        text: qsTr("you cannot access this phase\nuntil you pass though Solo Trails")
                        color:"gray"
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton
                    onPressed: {parent.state="clicked"}
                    onReleased: {parent.state="unclicked"}
                    onHoveredChanged: {
                        if(net.boldfont_1 === false){
                            net.boldfont_1 = true
                            net.italicfont_1 = true
                            nethint.visible = true
                        }else{
                            net.boldfont_1 = false
                            net.italicfont_1 = false
                            nethint.visible = false
                        }
                    }
                }
            }
        }
        MouseArea{
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
        }
    }
}
