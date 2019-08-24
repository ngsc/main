/*
** Added by Ahmed Soliman
** For further information use the contact form at AhmedSoliman_1234@hotmail.com.
*/
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import Qt.labs.folderlistmodel 2.0

import com.Game.APIConnection 1.0
import com.Game.Player 1.0
import com.Game.SortFilterProxyModel 1.0

Rectangle {
    id: clubPage
    color: "transparent"
    border.color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    property string titleBar: managerUser.clubName
    property alias pModel: playerModel

    function setClub() {
        app_title_bar.title = managerUser.club.name
        app_title_bar.selectedclubname = qsTr("League %1").arg(
                    managerUser.club.leagueId === 0 ? "A" : "B")
        app_title_bar.selectedclubid = managerUser.club.id
        app_title_bar.backgroundColor = managerUser.club.background1Value
        app_title_bar.textColor = managerUser.club.foreground1Value
        app_title_bar.showselectedclubname = true
    }

    function setclubDetailsforManager() {
        app_title_bar.selectedclubid = managerUser.clubId
        app_title_bar.backgroundColor = managerUser.club.background1Value
        app_title_bar.textColor = managerUser.club.foreground1Value
        app_title_bar.showselectedclubname = true
    }

    PlayerModel {
        id: playerModel
    }

    Rectangle {
        id: firstRowrect
        width: parent.width - parent.width / 6
        height: label1.height + 20
        color: "transparent"
        border.color: "transparent"
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        RowLayout {

            id: firstRow
            anchors.fill: parent
            anchors.top: parent.top
            property double colMulti: firstRow.width / (3 + 1)
            function prefWidth(item) {
                return colMulti * item.Layout.columnSpan
            }

            Rectangle {
                id: position
                height: label1.height + 10
                Layout.columnSpan: 1
                Layout.preferredWidth: firstRow.prefWidth(this)
                Layout.alignment: Qt.AlignCenter
                color: "light gray"
                border.color: "black"
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                }
                Text {
                    id: label1
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    padding: 5
                    font.pointSize: 9
                    font.family: "Comic Sans MS"
                    text: qsTr("POSITION")
                }
                MouseArea {
                    id: moustAreaPosition
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: {
                        position.color = "grey"
                    }
                    onExited: {
                        position.color = "light gray"
                    }
                    onClicked: {
                        app.callinsidepage2(positionPage)

                        positionPage.setClub()
                        //                        positionPage.setSelectedClub();
                        //                        positionPage.setClubName("xxx");
                    }
                }
            }

            Rectangle {
                id: number
                height: label1.height + 10
                Layout.columnSpan: 1
                Layout.preferredWidth: firstRow.prefWidth(this)
                Layout.alignment: Qt.AlignCenter
                color: "light gray"
                border.color: "black"
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                }
                Text {
                    id: labelNumber
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    padding: 5
                    font.pointSize: 9
                    font.family: "Comic Sans MS"
                    text: qsTr("NUMBER")
                }
                MouseArea {
                    id: moustAreaNumber
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: {
                        number.color = "grey"
                    }
                    onExited: {
                        number.color = "light gray"
                    }
                    onClicked: {
                        app.callinsidepage2(numberPage)
                        numberPage.setClub()
                    }
                }
            }

            Rectangle {
                id: tactic
                height: label2.height + 10
                Layout.columnSpan: 1
                Layout.preferredWidth: firstRow.prefWidth(this)
                Layout.alignment: Qt.AlignCenter
                color: "light gray"
                border.color: "black"
                Text {
                    id: label2
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    padding: 5
                    font.pointSize: 9
                    font.family: "Comic Sans MS"
                    text: qsTr("TACTIC")
                }
                MouseArea {
                    id: mouseAreatTactic
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: {
                        tactic.color = "gray"
                    }
                    onExited: {
                        tactic.color = "light gray"
                    }
                    onClicked: {
                        app.callinsidepage2(tacticPage)
                        tacticPage.setPlayers(playerModel.players())
                    }
                }
            }
        }
    }

    Rectangle {
        id: secondRow
        anchors.top: firstRowrect.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - parent.width / 6
        height: parent.height - (firstRowrect.height + 20)
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        color: "transparent"
        border.color: "#55aaff"

        Rectangle {
            anchors.left: parent.left
            width: parent.width / 3
            height: parent.height
            color: "transparent"
            border.color: "transparent"
            Rectangle {
                id: goeli
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 20
                height: 30
                radius: 5
                gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: "#8b8bf1"
                    }
                    GradientStop {
                        position: 0.50
                        color: "#6c6cf3"
                    }
                    GradientStop {
                        position: 1.0
                        color: "#1a3a82"
                    }
                }
                Text {
                    id: goelitext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    padding: 5
                    font.pointSize: 9
                    text: qsTr("Goalie and Defender")
                    color: "white"
                }
            }

            ViewRectList {
                id: goeliListView
                width: parent.width + 20
                height: parent.height
                anchors.top: goeli.bottom
                anchors.topMargin: 5
                anchors.left: parent.left

                listmodel: SortFilterProxyModel {
                    id: goelSortFilterModel
                    sourceModel: playerModel
                    sortCaseSensitivity: Qt.CaseInsensitive
                    sortRole: "name"
                    sortOrder: Qt.AscendingOrder
                    filterRole: "proposedPosition" //filter by position
                    filterString: "GK|SW|D C|D R|D L|D RC|D LC|D RL|D RLC|WB R|WB L|WB RL"
                    filterSyntax: SortFilterProxyModel.RegExp
                    filterCaseSensitivity: Qt.CaseInsensitive
                }
                onDoubleClicked: {
                    if (id != 0) {
                        var player = playerModel.player(id)
                        APIConnection.getPlayerDetails(managerUser.token, id)
                        app.busyIndicator.running = true
                        //                        if(player.isGoalkeeper === true) {
                        //                             APIConnection.getPlayerDetails(managerUser.token, id)
                        //                            app.callinsidepage2(goalkeeperProfile)
                        //                            goalkeeperProfile.setPlayer(player)
                        //                        }
                        //                        else {
                        //                            APIConnection.getPlayerDetails(managerUser.token, id)
                        //                            app.callinsidepage2(playerProfile)
                        //                            playerProfile.setPlayer(player);
                        //                        }
                    }
                }
            }
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width / 3
            height: parent.height
            color: "transparent"
            border.color: "transparent"
            Rectangle {
                id: midfielder
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 20
                height: 30
                radius: 5
                gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: "#71ed57"
                    }
                    GradientStop {
                        position: 0.50
                        color: "#55da3a"
                    }
                    GradientStop {
                        position: 1.0
                        color: "#2c821a"
                    }
                }
                Text {
                    id: midfieldertext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    padding: 5
                    font.pointSize: 9
                    text: qsTr("Midfielder")
                    color: "white"
                }
            }

            ViewRectList {
                id: midfielderListView
                width: parent.width + 20
                height: parent.height
                anchors.top: midfielder.bottom
                anchors.topMargin: 5
                x: midfielder.x - 5
                listmodel: SortFilterProxyModel {
                    id: midfielderSortFilterModel
                    sourceModel: playerModel
                    sortCaseSensitivity: Qt.CaseInsensitive
                    sortRole: "name"
                    sortOrder: Qt.AscendingOrder
                    filterRole: "proposedPosition"
                    filterString: "DM|M C|M R|M L|M RC|M LC| M RL|M RLC|AM C|AM R|AM L|AM RC|AM LC|AM RLC|AM RL"
                    filterSyntax: SortFilterProxyModel.RegExp
                    filterCaseSensitivity: Qt.CaseInsensitive
                }
                onDoubleClicked: {
                    if (id != 0) {
                        var player = playerModel.player(id)
                        APIConnection.getPlayerDetails(managerUser.token, id)
                        app.busyIndicator.running = true
                        //                        app.callinsidepage2(playerProfile)
                        //                        playerProfile.setPlayer(player);
                    }
                }
            }
        }

        Rectangle {
            anchors.right: parent.right
            width: parent.width / 3
            height: parent.height
            anchors.rightMargin: 10
            color: "transparent"
            border.color: "transparent"
            Rectangle {
                id: attacker
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 20
                height: 30
                radius: 5
                gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: "#f65454"
                    }
                    GradientStop {
                        position: 0.50
                        color: "#f81a1a"
                    }
                    GradientStop {
                        position: 1.0
                        color: "#9e0c0c"
                    }
                }
                Text {
                    id: attackertext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    padding: 5
                    font.pointSize: 9
                    text: qsTr("Attacker")
                    color: "white"
                }
            }

            ViewRectList {
                id: attackerListView
                anchors.top: attacker.bottom
                width: parent.width + 20
                height: parent.height
                anchors.topMargin: 5
                listmodel: SortFilterProxyModel {
                    id: attackerSortFilterModel
                    sourceModel: playerModel
                    sortCaseSensitivity: Qt.CaseInsensitive
                    sortRole: "name" //filter by position
                    sortOrder: Qt.AscendingOrder

                    filterRole: "proposedPosition"
                    filterString: "AM C|AM R|AM L|AM RC|AM LC|AM RLC|AM RL|ST"
                    filterSyntax: SortFilterProxyModel.RegExp
                    filterCaseSensitivity: Qt.CaseInsensitive
                }
                onDoubleClicked: {
                    console.log("id: " + id)
                    if (id != 0) {
                        var player = playerModel.player(id)
                        APIConnection.getPlayerDetails(managerUser.token, id)
                        app.busyIndicator.running = true
                        //                        app.callinsidepage2(playerProfile)
                        //                        playerProfile.setPlayer(player);
                    }
                }
                x: attacker.x - 5
            }
        }
    }

    Connections {
        target: APIConnection
        onGetPlayersFinished: {
            app.busyIndicator.running = false
            playerModel.setPlayers(players)
        }


    }

    function loadClubPlayers(id) {
        app.busyIndicator.running = true
        APIConnection.getClubPlayers(managerUser.token, id)
    }
}
