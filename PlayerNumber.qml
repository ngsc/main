import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.0

import com.Game.APIConnection 1.0
import com.Game.Player 1.0

Rectangle {
    id: root
    color: "transparent"

    property string titleBar: qsTr("Number Page")
    function setClub() {
        app_title_bar.title = qsTr("%1 Numbers").arg(managerUser.clubName)
        app_title_bar.backgroundColor = managerUser.club.background1Value
        app_title_bar.textColor = managerUser.club.foreground1Value
        gridView.model = 0
        gridView.model = clubPage.pModel
    }

    GridView {
        id: gridView

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: separator.top
        anchors.bottomMargin: 5

        cellWidth: parent.width/2   // - 20
        cellHeight: height/12
        layoutDirection: GridView.FlowLeftToRight
        verticalLayoutDirection: GridView.TopToBottom

        clip: true

        model: clubPage.pModel
        delegate: Row {
            id: row
            height: gridView.cellHeight
            width: gridView.cellWidth
            spacing: 10

            DropItem {
                id: drop
                width: parent.width*0.2
                height: parent.height
                text: number === 0 ? "" : number

                onTextChanged: {
                    var p = clubPage.pModel.player(player_id.text);
                    if(p.number !== parseInt(text)) {
                        p.number = parseInt(text);
                        APIConnection.updatePlayerNumber(managerUser.token, p);
                    }
                    if(text === "0")
                        text = ""
                }

                MouseArea {
                    id: mouse
                    anchors.fill : parent
                    acceptedButtons: Qt.LeftButton
                    onClicked: {
                        drop.text = ""
                        var p = clubPage.pModel.player(player_id.text);
                        p.number = 0
                        APIConnection.updatePlayerNumber(managerUser.token, p);
                        text = ""
                    }
                }
            }
            Text {
                id: player_id
                text: id
                visible: false
            }

            Text {
                id: name_field
                height: parent.height
                width: parent.width*0.6
                color: "white"
                font.pointSize: 10
                font.family: "Comic Sans MS"
                text: name
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
            }

            Text {
                id: position_field
                height: parent.height
                width: parent.width*0.2
                color: "#ff0000"
                font.pointSize: 10
                font.family: "Comic Sans MS"
                text: proposedPosition
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }

    Rectangle {
        id: separator
        color: "black"
        height: 3
        width: parent.width

        anchors.left: parent.left
        anchors.leftMargin: 30

        anchors.right: parent.right
        anchors.rightMargin: 30

        anchors.bottom: flickable.top
        anchors.bottomMargin: 5
    }

    Flickable {
        id: flickable

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.topMargin: 5
        contentHeight: flow.height
        height: 80
        clip: true

        Flow{
            id: flow
            width: parent.width
            height: 60
            spacing: 5
            Repeater {
                anchors.verticalCenter: parent.verticalCenter
                model: 26

                delegate: DragItem {
                    //width: drop.width
                    height: 20
                    text: modelData
                }
            }
        }
    }
}
