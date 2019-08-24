import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Rectangle {
    id: playerAttTableView
    property var listmodel

    color : "#6a6a8f"
    Rectangle {

        color: "transparent"
        border.color: "green"
        border.width: 1
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.topMargin: 10
        anchors.leftMargin: 10

        TableView {
            id: overViewTable
            width: parent.width
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: 10
            backgroundVisible: false
            frameVisible: false

            TableViewColumn {
                role: "pname"
                width: 100
            }
            TableViewColumn {
                role: "pvalue"
                width: 100
            }

            model: listmodel

            style: TableViewStyle {
                textColor: "white"
                alternateBackgroundColor: "transparent"

                headerDelegate: Rectangle {
                    height: 0
                    visible: false;
                }

                itemDelegate: Rectangle {
                    color: "transparent"
                    border.color: "transparent"
                    Text {
                        id: textItem
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: styleData.textAlignment
                        anchors.leftMargin: 12
                        text: styleData.value
                        elide: Text.ElideRight
                        color: "white"
                        renderType: Text.NativeRendering
                    }
                }

                rowDelegate: Rectangle {
                    color: styleData.selected ? "blue" : "transparent"
                    radius: 5
                }
            }
        }
    }
}
