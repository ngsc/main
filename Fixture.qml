import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import com.Game.APIConnection 1.0
import com.Game.Match 1.0
import com.Game.SimpleUser 1.0
import com.Game.Invitation 1.0
import com.Game.SortFilterProxyModel 1.0

Rectangle {
    id: root
    color: "transparent"

    property string titleBar: qsTr("Fixture Page")
    property alias simpleUserModelPtr: onlineUsersModel
    property alias invitationModel: invitationModel
    property alias getUsersTimer: getUsersTimer
    property var lastInvitationDate
    property int lastInviteeId: -1
    property int lastInvitedClubId: -1


    MatchModel {
        id: matchModel
    }

    SimpleUserModel {
        id: onlineUsersModel
    }

    InvitationModel {
        id: invitationModel
    }

    TableView {
        id: matchesTable
        width: parent.width
        anchors.left: parent.left
        anchors.top: parent.top
        height: parent.height/2
        backgroundVisible: false
        frameVisible: false
        sortIndicatorColumn: 4
        sortIndicatorOrder: Qt.DescendingOrder

        TableViewColumn {
            id: idCol
            role: "id"
            visible: false
        }

        TableViewColumn {
            id: homeClubNameCol
            role: "homeClubName"
            title: qsTr("Home Club")
            width: parent.width/3
            resizable: false
        }

        TableViewColumn {
            id: awayClubNameCol
            role: "awayClubName"
            title: qsTr("Guest Club")
            width: parent.width/3
            resizable: false
        }

        TableViewColumn {
            id: dateTimeCol
            role: "dateTime"
            title: qsTr("Date/Time")
            width: parent.width/3 - 20
            resizable: false
        }

        model: matchModel

        style: TableViewStyle {
            headerDelegate: Rectangle {
                color: "gray"
                border.color: Qt.lighter("gray")
                height: 20
                Text {
                    id: textHeader
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    verticalAlignment: Text.AlignVCenter
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
                    //visible: styleData.column === sortIndicatorColumn && sortIndicatorOrder === Qt.AscendingOrder
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
                    //visible: styleData.column === sortIndicatorColumn && sortIndicatorOrder === Qt.DescendingOrder
                }
            }

            itemDelegate: Rectangle {
                color: "transparent"
                height: 15
                radius: 5
                //border.color: "transparent"
                Text {
                    id: textItem
                    anchors.fill: parent
                    anchors.leftMargin: 30
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: styleData.column === 3 ? Text.AlignHCenter : Text.AlignLeft
                    text: (styleData.value)
                    elide: Text.ElideRight
                    color: "white"
                    renderType: Text.NativeRendering
                    font.family: "Comic Sans MS"
                    font.pointSize: 9
                }
            }

            rowDelegate: Rectangle {
                color: styleData.selected ? "blue" : "transparent"
                radius: 5
            }

            handle: Rectangle {
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
                //implicitHeight: overViewTable.height-(30)+10
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
            }
        }
    }

    TabView {
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: matchesTable.bottom
        anchors.topMargin: 15
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom


        Tab {
            title: qsTr("Invite to Friendly Game")
            sourceComponent: onlineUsersTab
        }
        Tab {
            title: qsTr("Invitations")
            sourceComponent: invitationsTab

        }

        style: TabViewStyle {
            frameOverlap: 1
            tab: Rectangle {
                color: styleData.selected ? "steelblue" :"lightsteelblue"
                border.color:  "steelblue"
                implicitWidth: Math.max(text.width + 20, 80)
                implicitHeight: 40
                radius: 2
                Text {
                    id: text
                    anchors.centerIn: parent
                    text: qsTr(styleData.title)
                    font.pointSize: 10
                    font.family: "Comic Sans MS"
                    color: styleData.selected ? "white" : "black"
                }
            }
            frame: Rectangle { color: "transparent" }
        }

    }

    Component {
        id: onlineUsersTab
        Rectangle {
            color: "transparent"
            /*
            Rectangle
            {
                id: inviteMatchLabel
                width: parent.width
                anchors.top: parent.top
                height: 30
                color: "#1b4caf"
                //radius: width/6
                //anchors.horizontalCenter: parent.horizontalCenter
                //anchors.top: matchesTable.bottom
                //anchors.topMargin: 5

                Rectangle {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.right: parent.right
                    color: "white"
                    height: 1
                }

                Text
                {
                    id: txt
                    anchors.centerIn: parent
                    color: "#ffffff"
                    font.pointSize: 10
                    font.family: "Comic Sans MS"
                    text: "Invite Players"
                }
            }*/

            TableView {
                id: onlineUsersTable
                anchors.fill: parent

                selectionMode: SelectionMode.ExtendedSelection

                backgroundVisible: false
                frameVisible: false
                sortIndicatorColumn: 4
                sortIndicatorOrder: Qt.DescendingOrder

                TableViewColumn {
                    id: userIdCol
                    role: "userId"
                    visible: false
                }
                TableViewColumn {
                    id: clubIdCol
                    role: "clubId"
                    visible: false
                }
                TableViewColumn {
                    id: userNameCol
                    role: "username"
                    title: qsTr("User Name")

                    //width: parent.width/onlineUsersTable.colNumber
                }
                TableViewColumn {
                    id: clubNameCol
                    role: "clubName"
                    title: qsTr("Club Name")
                    //width: parent.width/onlineUsersTable.colNumber
                }
                TableViewColumn {
                    id: onlineCol
                    role: "online"
                    title: qsTr("Status")
                    //visible: false
                }

                model: SortFilterProxyModel {
                    id: filterModel
                    sourceModel: onlineUsersModel
                    sortCaseSensitivity: Qt.CaseInsensitive
                    sortRole: userNameCol.role
                    sortOrder: Qt.DescendingOrder
                    filterRole: onlineCol.role
                    filterSyntax: SortFilterProxyModel.RegExp
                    filterCaseSensitivity: Qt.CaseInsensitive
                    //filterString: "true"
                }


                style: TableViewStyle {
                    headerDelegate: Rectangle {
                        color: "gray"
                        border.color: Qt.lighter("gray")
                        height: 20
                        Text {
                            id: textHeader2
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            verticalAlignment: Text.AlignVCenter
                            text: qsTr(styleData.value)
                            elide: Text.ElideRight
                            color: "white"
                            renderType: Text.NativeRendering
                            font.family: "Comic Sans MS"
                            font.pointSize: 10
                            font.bold: true
                        }
                        Rectangle {
                            id: sortArrowUp2
                            anchors.left: textHeader2.right
                            anchors.leftMargin: 10
                            anchors.verticalCenter: textHeader2.verticalCenter
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
                            id: sortArrowDown2
                            anchors.left: textHeader2.right
                            anchors.leftMargin: 10
                            anchors.verticalCenter: textHeader2.verticalCenter
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
                        height: 15
                        radius: 5
                        //border.color: "transparent"
                        Text {
                            id: textItem2
                            anchors.fill: parent
                            anchors.leftMargin: 30
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: styleData.column === 3 ? Text.AlignHCenter : Text.AlignLeft
                            text: (styleData.role === onlineCol.role ? (styleData.value === true ? qsTr("Online") : qsTr("Offline")) : styleData.value)
                            elide: Text.ElideRight
                            color: "white"
                            renderType: Text.NativeRendering
                            font.family: "Comic Sans MS"
                            font.pointSize: 9
                        }
                    }

                    rowDelegate: Rectangle {
                        color: styleData.selected ? "blue" : "transparent"
                        radius: 5
                    }

                    handle: Rectangle {
                        id: search_scroll_view_handle2
                        implicitWidth: 15
                        radius: width/2
                        color: "#55aaff"
                        border.color: "#577fa9"
                        border.width: 2
                    }
                    scrollBarBackground: Rectangle {
                        id: search_scroll_background2
                        implicitWidth: 15
                        radius: 7
                        color: "#3b76b1"
                        border.color: "#34537a"
                        border.width: 1
                    }
                    decrementControl: Rectangle {
                        id: search_scroll_view_dec_control2
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
                        id: search_scroll_view_inc_control2
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
                    }
                }
            }

            MyButtonNormal
            {
                id: inviteButton
                anchors.right: parent.right
                anchors.rightMargin: 25
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                text: qsTr("Invite")
                enabled: onlineUsersTable.selection.count > 0
                onClicked: {
                    onlineUsersTable.selection.forEach(function(rowIndex) {
                        var row = onlineUsersTable.model.get(rowIndex)
                        console.log(row.username + ", " + row.userId + ", " + row.clubId + ", " + row.clubName + ", " + row.online)
                        root.lastInvitationDate = new Date();
                        root.lastInviteeId = row.userId;
                        root.lastInvitedClubId = row.clubId;
                        APIConnection.sendInvitation(managerUser.token, managerUser.id, row.userId);
                        APIConnection.getInvitations(managerUser.token, row.userId);
                    })
                    onlineUsersTable.selection.clear();
                }
            }
            MyButtonNormal
            {
                id: cancel_button
                anchors.right: inviteButton.left
                anchors.rightMargin: 10
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                text: qsTr("Clear")
                onClicked: { onlineUsersTable.selection.clear() }
            }
        }
    }

    Component {
        id: invitationsTab
        Rectangle {
            color: "transparent"
            TableView {
                id: invitationTable
                anchors.fill: parent

                selectionMode: SelectionMode.SingleSelection

                backgroundVisible: false
                frameVisible: false
                sortIndicatorColumn: 4
                sortIndicatorOrder: Qt.DescendingOrder

                TableViewColumn {
                    id: idCol
                    role: "id"
                    visible: false
                }
                TableViewColumn {
                    id: homeClubId
                    role: "homeClubId"
                    visible: false
                }
                TableViewColumn {
                    id: homeClubName
                    role: "homeClubName"
                    title: qsTr("Home Club")
                }
                TableViewColumn {
                    id: awayClubId
                    role: "awayClubId"
                    title: qsTr("Away Name")
                    visible: false
                }
                TableViewColumn {
                    id: awayClubName
                    role: "awayClubName"
                    title: qsTr("Away Name")
                }

                TableViewColumn {
                    id: dateId
                    role: "date"
                    title: qsTr("Invitation Time")
                    //width: parent.width/onlineUsersTable.colNumber
                }

                model: SortFilterProxyModel {
                    id: invitationFilterModel
                    sourceModel: invitationModel
                    sortCaseSensitivity: Qt.CaseInsensitive
                    sortRole: idCol.role
                    sortOrder: Qt.DescendingOrder
                    //filterRole: onlineCol.role
                    //filterSyntax: SortFilterProxyModel.RegExp
                    //filterCaseSensitivity: Qt.CaseInsensitive
                    //filterString: "true"
                }


                style: TableViewStyle {
                    headerDelegate: Rectangle {
                        color: "gray"
                        border.color: Qt.lighter("gray")
                        height: 20
                        Text {
                            id: textHeader2
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            verticalAlignment: Text.AlignVCenter
                            text: qsTr(styleData.value)
                            elide: Text.ElideRight
                            color: "white"
                            renderType: Text.NativeRendering
                            font.family: "Comic Sans MS"
                            font.pointSize: 10
                            font.bold: true
                        }
                        Rectangle {
                            id: sortArrowUp2
                            anchors.left: textHeader2.right
                            anchors.leftMargin: 10
                            anchors.verticalCenter: textHeader2.verticalCenter
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
                            id: sortArrowDown2
                            anchors.left: textHeader2.right
                            anchors.leftMargin: 10
                            anchors.verticalCenter: textHeader2.verticalCenter
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
                        height: 15
                        radius: 5
                        //border.color: "transparent"
                        Text {
                            id: textItem2
                            anchors.fill: parent
                            anchors.leftMargin: 30
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: styleData.column === 3 ? Text.AlignHCenter : Text.AlignLeft
                            text: styleData.value   //styleData.role === onlineCol.role ? (styleData.value === true ? qsTr("Online") : qsTr("Offline")) : styleData.value
                            elide: Text.ElideRight
                            color: "white"
                            renderType: Text.NativeRendering
                            font.family: "Comic Sans MS"
                            font.pointSize: 9
                        }
                    }

                    rowDelegate: Rectangle {
                        color: styleData.selected ? "blue" : "transparent"
                        radius: 5
                    }

                    handle: Rectangle {
                        id: search_scroll_view_handle2
                        implicitWidth: 15
                        radius: width/2
                        color: "#55aaff"
                        border.color: "#577fa9"
                        border.width: 2
                    }
                    scrollBarBackground: Rectangle {
                        id: search_scroll_background2
                        implicitWidth: 15
                        radius: 7
                        color: "#3b76b1"
                        border.color: "#34537a"
                        border.width: 1
                    }
                    decrementControl: Rectangle {
                        id: search_scroll_view_dec_control2
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
                        id: search_scroll_view_inc_control2
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
                    }
                }
            }

            MyButtonNormal
            {
                id: accept_button
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 20
                text: qsTr("Invite")
                enabled: invitationFilterModel.get(invitationTable.currentRow).awayUserId === managerUser.clubId && invitationFilterModel.get(invitationTable.currentRow).status === "active"
                visible: enabled
                onClicked: {
                    APIConnection.acceptInvitation(managerUser.token, invitationFilterModel.get(invitationTable.currentRow).id)
                }
            }
            MyButtonNormal
            {
                id: cancel_button
                anchors.right: accept_button.left
                anchors.rightMargin: 20
                anchors.bottom: parent.bottom
                text: qsTr("Decline")
                enabled: accept_button.enabled
                visible: true//enabled
                onClicked: {
                    APIConnection.declineInvitation(managerUser.token, invitationFilterModel.get(invitationTable.currentRow).id)
                    // invitationFilterModel.get(invitationTable.currentRow).active = false
                }

            }

        }
    }

    Timer {
        id: getUsersTimer
        interval: 10000
        running: false//stackView.__currentItem === fixturePage
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            APIConnection.getUsers(managerUser.token)
        }
    }
    Connections {
        target: monitorControl
        onTcpFullMessageReceived:
        {
            app.busyIndicatorMatchStart.running = false;
        }
    }

    Connections {
        target: APIConnection

        onGetMatchesFinished: {
            app.busyIndicator.running = false;
            matchModel.setMatches(matches);
        }

        onGetUsersFinished: {
            console.log(managerUser.username)
            onlineUsersModel.setUsers(users, managerUser.username);
//            annonucement_board.userAnnouncenemtList.setUserHistory(users, managerUser.username);
        }

        onGetInvitationsFinished: {

            invitationModel.setInvitations(invitations);
            if (invitationModel.isLastInvitationAccepted(root.lastInvitationDate, root.lastInviteeId))
            {
                callinsidepage2(monitor);
                monitor.hideButtonsStartMatchOnClicked(false);
                monitorControl.startMatchServerCmd(managerUser.clubId, root.lastInvitedClubId);
                app.busyIndicatorMatchStart.running = true;
                root.lastInviteeId = -1;
            }
            app.canResign = !invitationModel.areThereInvetationNews()
        }
    }

    function loadFixtures() {
        app.busyIndicator.running = true
        APIConnection.getMatches(managerUser.token);
    }
}
