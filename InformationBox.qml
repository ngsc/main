import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import Constants 1.0

Item {
    id: informationbox
    visible: false

    width: 430
    height: 150

    property alias title: title_text.text
    property alias message: message_text.text
    property alias ok_text: btn_text.text

    signal ok()

    Rectangle{
        id: confirmingbox_rect
        anchors.fill: parent
        radius: 15
        opacity: 0.95
        border.color: "white"
        color:"#5a4f7e"

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#9087ab" }
            GradientStop { position: 0.50; color: "#3b76b1" }
            GradientStop { position: 1.0; color: "#3b76b1" }
        }

        ColumnLayout
        {
            anchors.fill: parent
            Text {
                id: title_text
                anchors.left: parent.left
                anchors.margins: 50
                font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                font.pointSize: 15
                font.bold: true
                color: "white"
            }
            Text {
                id: message_text
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.margins: 50
                font.family: Constants.primaryFont ? Constants.primaryFont.name: null//"Kristen ITC"
                font.pointSize: 15
                font.bold: false
                color: "white"

            }
            RowLayout {
                anchors.right: parent.right
                anchors.rightMargin: 10
                Rectangle{
                    id: ok_rect
                    width: 170
                    height: 50
                    border.color: "black"
                    radius: 10
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#9087ab" }
                        GradientStop { position: 0.50; color: "#3b76b1" }
                        GradientStop { position: 1.0; color: "#3b76b1" }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        acceptedButtons: Qt.LeftButton
                        onClicked: {
                            ok()
                        }
                    }

                    Text{
                        id: btn_text
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        anchors.fill: parent
                        text : qsTr("OK")
                        font.family: Constants.primaryFont ? Constants.primaryFont.name: null//"Kristen ITC"
                        font.pointSize: 15
                        font.bold: true
                        color: "white"
                    }
                }
            }

        }
    }
}
