import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

Item {
    id: confirmationbox
    visible: false

    width: question_text.width > 430 ? question_text.width + 20 : 430
    height: 150

    property alias title: title_text.text
    property alias question: question_text.text
    property alias cancel_button_text: ct.text
    property alias confirm_button_text: ct2.text

    signal confirm_clicked()
    signal cancel_clicked()

    Rectangle{
        id: confirmingbox_rect
        //x:parent.width/2-width/2
        //y:parent.height/2-height/2
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
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.margins: 50
                font.family: "Comic Sans MS"
                font.pointSize: 15
                font.bold: true
                color: "white"
            }
            Text {
                id: question_text
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.margins: 50
                font.family: "Comic Sans MS"//"Kristen ITC"
                font.pointSize: 15
                font.bold: false
                color: "white"
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere

            }
            RowLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle{
                    id :cancel_rect
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
                        //onPressed: {
                        onClicked: {
                            confirmingbox.visible = false
                            cancel_clicked()
                        }
                    }

                    Text{
                        id: ct
                        //text : "cancel"
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        anchors.fill: parent
                        font.family: "Comic Sans MS"
                        font.pointSize: 15
                        font.bold: true
                        color: "white"
                    }
                }
                Rectangle{
                    id: confirm_rect
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
                        //onPressed: {
                        onClicked: {
                            confirm_clicked()
                        }
                    }

                    Text{
                        id: ct2
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        anchors.fill: parent
                        //text : "Exit"
                        font.family: "Comic Sans MS"//"Kristen ITC"
                        font.pointSize: 15
                        font.bold: true
                        color: "white"
                    }
                }
            }
        }
    }
}
