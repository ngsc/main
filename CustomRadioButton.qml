import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Item {
    id: radio_button
    width: 150
    height: 50
    property alias exclusiveGroup: control.exclusiveGroup
    property alias text: control.text
    property color border_color: "#55aaff"
    property int border_width: 1
    property int box_margin: 20

    property bool boldfont: false
    property bool italicfont: false


    property bool checked: false

    signal radioButtonClick()

    Rectangle {
        id: radio_button_rect
        color: "transparent"
        anchors.fill: parent
        border.color: parent.border_color
        border.width: 2
        height: control.height
        radius: 15

        RadioButton {
            id: control
            width: parent.width
            checked: radio_button.checked

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 5

            onClicked:{
                radioButtonClick()
            }

            style: RadioButtonStyle {
                label: Text {
                    text: qsTr(control.text)
                    font.family: "Comic Sans MS"
                    font.pointSize: 11
                    font.italic: radio_button.italicfont
                    font.bold: radio_button.boldfont
                    color: "#e1e100"
                    horizontalAlignment: Text.left
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    width: control.width
                }
                indicator: Rectangle {
                    implicitWidth: 16
                    implicitHeight: 16
                    radius: 9
                    border.color: control.activeFocus ? "green" : "red"
                    border.width: 2
                    Rectangle {
                        anchors.fill: parent
                        visible: control.checked
                        color: "#55aaff"
                        radius: 9
                        anchors.margins: 4
                    }
                }
            }
        }
    }
}
