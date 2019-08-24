import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0

Rectangle
{
    id: button_1
    property string button_text: ""
    anchors.margins: 2
    width: ((parent.width-24)/5)
    height: 30
    color: "transparent"
    property bool button_bottom_line_visibility: false
    Rectangle
    {
        id: inner_box
        anchors.fill: parent
        opacity: 0.3
        gradient: Gradient{
            GradientStop{position: 0.0; color: "#9a9a9a"} //"#606fb5"
            GradientStop{position: 0.80; color: "#9a9a9a"}
            GradientStop{position: 1.0; color: "#ffffff"}
        }
    }
    Rectangle
    {
        id: button_bottom_line
        anchors.bottom: inner_box.bottom
        anchors.left: inner_box.left
        anchors.right: inner_box.right
        height:2
        color: "#ffffff"
        visible: button_bottom_line_visibility
    }
    Text
    {
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "#ffffff"
        text: button_text
        font.family: "Comic Sans MS"
        font.pointSize: 10
    }
    MouseArea
    {
        anchors.fill: parent
        hoverEnabled: true
        //onClicked: {clickedmouse}
        onPressed:  {clickedmouse}
        onEntered:
        {
            button_bottom_line_visibility=true
        }
        onExited:
        {
            button_bottom_line_visibility=false
        }
    }
}
