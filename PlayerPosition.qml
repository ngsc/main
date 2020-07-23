import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.0

import com.Game.APIConnection 1.0
import com.Game.Player 1.0

Rectangle {
    id: root
    color: "transparent"

    property string titleBar: qsTr("Position Page")
    function setClub() {
        app_title_bar.title = qsTr("%1 Positions").arg(managerUser.clubName)
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
                text: model.assignedPosition

                onTextChanged: {
                    var p = clubPage.pModel.player(player_id.text);
                    if(p.assignedPosition !== text) {
                        p.assignedPosition = text;
                        APIConnection.updatePlayerPosition(managerUser.token, p);
                    }
                }

                MouseArea {
                    id: mouse
                    anchors.fill : parent
                    acceptedButtons: Qt.LeftButton
                    onClicked: {
                        drop.text = ""
                        var p = clubPage.pModel.player(player_id.text);
                        p.assignedPosition = "";
                        APIConnection.updatePlayerPosition(managerUser.token, p);
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
                font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                text: qsTr(name)
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
            }

            Text {
                id: position_field
                height: parent.height
                width: parent.width*0.2
                color: "#ff0000"
                font.pointSize: 10
                font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                text: qsTr(proposedPosition)
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
                model: ["GK",	//GoalKeeper
                    "SW",	//Sweeper

                    "D R",	//Right Defender(Full Back in map)
                    "D C",	//Central Defender
                    "D C",	//Central Defender
                    "D C",	//Central Defender
                    "D L",	//Left Defender(Full Back in map)

                    "WB R",	//Right WingBack(Right Defensive Midfielder in map)
                    "DM C",	//Central Defensive Midfielder(Defensive Midfielder in map)
                    "DM C",	//Central Defensive Midfielder(Defensive Midfielder in map)
                    "DM C",	//Central Defensive Midfielder(Defensive Midfielder in map)
                    "WB L",	//Left WingBack(left Defensive Midfielder in map)

                    "M R",	//Right Midfielder(Side Midfielder in map)
                    "M C",	//Central Midfielder(Midfielder in map)
                    "M C",	//Central Midfielder(Midfielder in map)
                    "M C",	//Central Midfielder(Midfielder in map)
                    "M L",	//Left Midfielder(Side Midfielder in map)

                    "AM R",	//Right Attacking Midfielder(Attacking Winger in map)
                    "AM C",	//Central Attacking Midfielder(Attacking Midfielder in map)
                    "AM L",	//Left Attacking Midfielder(Attacking Winger in map)

                    "ST",	//Forward
                    "ST",	//Forward
                    "ST",	//Forward

                    "SB1", "SB1","SB2","SB3","SB4","SB5","SB6","SB7","SB8","SB9","SB10","SB11"
                ]

                delegate: DragItem {
                    //width: drop.width
                    height: 20
                    text: qsTr(modelData)
                }
            }
        }
    }
}
