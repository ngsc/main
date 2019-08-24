import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0

Rectangle
{
    id: group_box
    color: "transparent"
    property string title_text: ""
    property color border_color: "#55aaff"
    property int border_width: 1
    property int box_margin: 20
    property alias box_content_item: box_main_content_item.children
    radius: group_box_content_inner_rect.radius
    Rectangle
    {
        id: group_box_content_background
        anchors.topMargin: group_box_title_text.font.pointSize
        anchors.fill: parent
        color: "transparent"
        //opacity: 0.3
        Rectangle
        {
            id: group_box_content_inner_rect
            anchors.fill: parent
            anchors.leftMargin: 2
            anchors.rightMargin: 3
            anchors.bottomMargin: 2
            color: "transparent"
            opacity: 0.3
            border.color: border_color//"#ffffff"
            border.width: border_width
            radius: 20
        }
        Rectangle
        {
            id: box_main_content_item
            anchors.fill: group_box_content_inner_rect
            anchors.topMargin: group_box_title_text.font.pointSize/2
            color: "transparent"
            radius: group_box_content_inner_rect.radius
            clip: true
        }
    }
    Rectangle
    {
        id: group_box_title
        anchors.verticalCenter: group_box_content_background.top
        anchors.left: group_box_content_background.left
        anchors.leftMargin: 30
        width: group_box_title_text.width + 10
        height: 25
        opacity: 0.3
        color: "transparent"
    }
    Text
    {
        id: group_box_title_text
        anchors.centerIn: group_box_title
        font.family: "Comic Sans MS"
        font.pointSize: 11
        color: "#e1e100"
        font.bold: true
        text: qsTr(title_text)
    }
}
