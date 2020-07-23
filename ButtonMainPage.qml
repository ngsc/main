import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import Constants 1.0


Rectangle
{
    id: my_button
    height: 100
    width: 200
    radius: width/2
    color: "transparent"
    property string button_text:""
    property bool boldfont: true
    property bool italicfont: false
    Rectangle
    {
        id: inner_box
        anchors.fill: parent
        opacity: 0.6
        radius: parent.radius
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#6d6b79" }
            GradientStop { position: 0.50; color: "#bfbbd3" }
            GradientStop { position: 1.0; color: "#bfbbd3" }
        }
    }
    Text
    {
        id : text
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#34537a"
        font.family: Constants.primaryFont ? Constants.primaryFont.name: null//"Kristen ITC"
        font.pointSize: 15
        font.bold: boldfont
        font.italic: italicfont
        text: qsTr(button_text)
    }
    states: [
        State {
            name: "clicked"
            PropertyChanges {
                target: inner_box
                border.color: "#fdc807"
                border.width: 3
            }
        },
        State {
            name: "unclicked"
            PropertyChanges {
                target: inner_box
                border.color: "transparent"
            }
        }
    ]
}
