import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0

import com.Game.APIConnection 1.0
import com.Game.Club 1.0
import com.Game.SortFilterProxyModel 1.0

Rectangle {
    id: root
    color: "transparent"
    property string titleBar: qsTr("League B")
    property int currentLeague: 1

    ClubModel {
        id: clubModel
    }

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

        Row {
            id: searchrow
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 10
            height: 30
        }

        TableView {
            id: clubsTable
            width: parent.width-10
            anchors.top: searchrow.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 10
            backgroundVisible: false
            sortIndicatorVisible: true
            sortIndicatorColumn: 4
            sortIndicatorOrder: Qt.DescendingOrder
            flickableItem.flickableDirection: Flickable.HorizontalAndVerticalFlick

            TableViewColumn {
                role: "id"
                title: "id"
                visible: false
            }

            TableViewColumn {
                id: positionCol
                role: "position"
                title: qsTr("Position")
            }

            TableViewColumn {
                id: nameCol
                role: "name"
                title: qsTr("Team")
            }
            TableViewColumn {
                id: matchesCol
                role: "matches"
                title: qsTr("Match Playes")

            }
            TableViewColumn {
                id: wonCol
                role: "won"
                title: qsTr("Won")
            }
            TableViewColumn {
                id: drewCol
                role: "drew"
                title: qsTr("Drew")
            }
            TableViewColumn {
                id: lostCol
                role: "lost"
                title: qsTr("Lost")
            }
            TableViewColumn {
                id: goalsForCol
                role: "goalsFor"
                title: qsTr("Goals For")
            }
            TableViewColumn {
                id: goalsAgainstCol
                role: "goalsAgainst"
                title: qsTr("Goals Against")
            }
            TableViewColumn {
                id: goalsDifferenceCol
                role: "goalsDifference"
                title: qsTr("Goals Difference")
            }
            TableViewColumn {
                id: pointsCol
                role: "points"
                title: qsTr("Points")
            }
            TableViewColumn {
                id: ownerCol
                role: "ownerName"
                title: qsTr("Owner")
            }

            model: SortFilterProxyModel {
                id: filterModel
                sourceModel: clubModel
                sortCaseSensitivity: Qt.CaseInsensitive
                sortRole: "value"
                sortOrder: Qt.DescendingOrder
                filterRole: "name"
                filterSyntax: SortFilterProxyModel.RegExp
                filterCaseSensitivity: Qt.CaseInsensitive

                onFilterRoleChanged: {
                    console.log("filter role changed to " + role)
                    currentFilter = role
                }
            }

            /*onSortIndicatorColumnChanged: {
                filterModel.sortRole = clubsTable.getColumn(sortIndicatorColumn).role
                filterModel.sortOrder = sortIndicatorOrder
            }

            onSortIndicatorOrderChanged: {
                filterModel.sortRole = clubsTable.getColumn(sortIndicatorColumn).role
                filterModel.sortOrder = sortIndicatorOrder
            }*/

            style: TableViewStyle {
                headerDelegate: Rectangle {
                    color: "gray"
                    border.color: Qt.lighter("gray")
                    height: 30
                    Text {
                        id: textHeader
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        text: qsTr(styleData.value)
                        elide: Text.ElideRight
                        color: "white"
                        renderType: Text.NativeRendering
                        font.family: "Comic Sans MS"
                        font.pointSize: 10
                        font.bold: true
                    }
                    Rectangle {
                        id: sortArrowUp
                        anchors.left: textHeader.right
                        anchors.leftMargin: 10
                        anchors.verticalCenter: textHeader.verticalCenter
                        implicitWidth: 15
                        implicitHeight: implicitWidth
                        color: "transparent"    //"#34537a"
                        Image
                        {
                            anchors.fill: parent
                            anchors.margins: 1
                            fillMode: Image.Stretch
                            source: "qrc:/icons/arrow-orange-up.png"
                            opacity: 1
                        }

                        visible: false
                    }
                    Rectangle {
                        id: sortArrowDown
                        anchors.left: textHeader.right
                        anchors.leftMargin: 10
                        anchors.verticalCenter: textHeader.verticalCenter
                        implicitWidth: 15
                        implicitHeight: implicitWidth
                        color: "transparent"    //"#34537a"
                        Image
                        {
                            anchors.fill: parent
                            anchors.margins: 1
                            fillMode: Image.Stretch
                            source: "qrc:/icons/arrow-orange-down.png"
                            opacity: 1
                        }
                        visible: false
                    }
                }

                itemDelegate: Rectangle {
                    color: "transparent"
                    height: 35
                    Text {
                        id: textItem
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        text: qsTr(styleData.value.toString())
                        elide: Text.ElideRight
                        color: clubsTable.model.get(styleData.row).foreground1Value ? clubsTable.model.get(styleData.row).foreground1Value : "black"
                        renderType: Text.NativeRendering
                        font.family: "Comic Sans MS"
                        font.pointSize: 10

                    }
                }

                rowDelegate: Rectangle {
                    color: clubsTable.model.get(styleData.row).background1Value ? clubsTable.model.get(styleData.row).background1Value : "white"
                    height: 35
                }

                /*handle: Rectangle {
                    id: search_scroll_view_handle
                    implicitWidth: 15
                    radius: width/2
                    color: "#55aaff"
                    border.color: "#577fa9"
                    border.width: 2
                }
                scrollBarBackground: Rectangle {
                    id: search_scroll_background
                    implicitWidth: 15
                    implicitHeight: clubsTable.height-(30)+10
                    radius: 7
                    color: "#3b76b1"
                    border.color: "#34537a"
                    border.width: 1
                }
                decrementControl: Rectangle {
                    id: search_scroll_view_dec_control
                    implicitWidth: 15
                    implicitHeight: implicitWidth
                    color: "#34537a"
                    Image
                    {
                        anchors.fill: parent
                        anchors.margins: 1
                        fillMode: Image.Stretch
                        source: "qrc:/icons/arrow-orange-up.png"
                        opacity: 1
                    }
                }
                incrementControl: Rectangle {
                    id: search_scroll_view_inc_control
                    implicitWidth: 15
                    implicitHeight: implicitWidth
                    color: "#34537a"
                    Image
                    {
                        anchors.fill: parent
                        anchors.leftMargin: 1
                        fillMode: Image.Stretch
                        source: "qrc:/icons/arrow-orange-down.png"
                        opacity: 1
                    }
                }*/
            }

            onClicked: {
                //overViewTable.enabled = false
                app.busyIndicator.running = true;
                app.clubDetailsforManager = false
                APIConnection.getClubDetails(managerUser.token,filterModel.get(row).id)//(managerUser.token, filterModel.get(row).id)
                clubPage.loadClubPlayers(filterModel.get(row).id)
                callinsidepage2(clubPage)
            }
        }

    }

    Club {
        id: c
    }

    Connections {
        target: APIConnection

        onGetClubsFinished: {
            if(stackView.__currentItem === leaguePage){
                app.busyIndicator.running = false
                clubModel.setClubs(clubs);
                if(clubModel.rowCount() > 0)
                {
                    var lid = clubModel.get(0).leagueId
                    root.currentLeague = parseInt(lid)
                    app_title_bar.showselectedclubname = true
                    if(root.currentLeague === 0)
                    {
                        app_title_bar.title = qsTr("League A");
                        app_title_bar.selectedclubname = qsTr("League B");
                    }
                    else
                    {
                        app_title_bar.title = qsTr("League B");
                        app_title_bar.selectedclubname = qsTr("League A");
                    }
                }
            }
        }
    }

    function loadLeagueClubs(id) {
        app.busyIndicator.running = true
        APIConnection.getLeagueClubs(managerUser.token, id);
        app_title_bar.showselectedclubname = true
    }

    function flipLeague() {
        app.busyIndicator.running = true
        if(root.currentLeague == 0){
            root.currentLeague = 1
        }
        else {
            root.currentLeague = 0
        }
        APIConnection.getClubsByLeague(managerUser.token, root.currentLeague);
    }
}
