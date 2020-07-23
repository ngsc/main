import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

import com.Game.APIConnection 1.0
import com.Game.SearchingPool 1.0
import com.Game.SortFilterProxyModel 1.0


Rectangle {
    id: searchingPool
    color : "#6a6a8f"

    property string titleBar: qsTr("Searching Pool")
    property alias poolModel: poolModel
    property alias sortIndicatorColumn: overViewTable.sortIndicatorColumn
    property alias sortIndicatorOrder: overViewTable.sortIndicatorOrder
    property alias currentFilter: filterModel.filterRole
    SearchingPoolModel {
        id: poolModel
    }

    onCurrentFilterChanged: {
        console.log("current filter: " + currentFilter)
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

            Rectangle
            {
                id: namesearchrect
                width: nameCol.width
                color: "transparent"
                radius: width/20
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                MouseArea{cursorShape: Qt.PointingHandCursor}
                property bool isActive: currentFilter === nameCol.role ? true : false
                onIsActiveChanged: {
                    console.log("is active: " + isActive + ", filterRole: " + filterModel.filterRole);
                }

                Rectangle
                {
                    border.color: parent.isActive ?  "#fdc807" : "gray"
                    border.width: 1
                    anchors.fill: parent
                    color: "gray"  //"#34537a"
                    opacity: 0.7
                    radius: parent.radius
                }
                TextField
                {
                    id: namesearch
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    placeholderText: qsTr("Filter by Name")
                    font.family: "Comic Sans MS"
                    font.pointSize: 10
                    style: TextFieldStyle{
                        textColor: "#ffffff"
                        background: Rectangle{
                            color: "transparent"
                        }
                    }
                    onTextChanged: {
                        filterModel.filterRole = nameCol.role
                        filterModel.filterString = namesearch.text ;
                        //parent.isActive = true;
                    }
                }
            }

            Rectangle
            {
                id: clubsearchrect
                width: clubCol.width
                color: "transparent"
                radius: width/20
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                MouseArea{cursorShape: Qt.PointingHandCursor}
                property bool isActive: currentFilter === clubCol.role ? true : false
                Rectangle
                {
                    border.color: parent.isActive ?  "#fdc807" : "gray"
                    border.width: 1
                    anchors.fill: parent
                    color: "gray"  //"#34537a"
                    opacity: 0.7
                    radius: parent.radius
                }
                TextField
                {
                    id: clubsearch
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    placeholderText: qsTr("Filter by Club")
                    font.family: "Comic Sans MS"
                    font.pointSize: 10
                    style: TextFieldStyle{
                        textColor: "#ffffff"
                        background: Rectangle{
                            color: "transparent"
                        }
                    }
                    onTextChanged: {
                        filterModel.filterRole = clubCol.role
                        filterModel.filterString = clubsearch.text ;
                    }
                }
            }

            Rectangle
            {
                id: positionsearchrect
                width: positionCol.width
                color: "transparent"
                radius: width/20
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                MouseArea{cursorShape: Qt.PointingHandCursor}
                property bool isActive: currentFilter === positionCol.role ? true : false
                Rectangle
                {
                    border.color: parent.isActive ?  "#fdc807" : "gray"
                    border.width: 1
                    anchors.fill: parent
                    color: "gray"  //"#34537a"
                    opacity: 0.7
                    radius: parent.radius
                }
                TextField
                {
                    id: positionsearch
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    placeholderText: qsTr("Filter by Position")
                    font.family: "Comic Sans MS"
                    font.pointSize: 10
                    style: TextFieldStyle{
                        textColor: "#ffffff"
                        background: Rectangle{
                            color: "transparent"
                        }
                    }
                    onTextChanged: {
                        filterModel.filterRole = positionCol.role
                        filterModel.filterString = positionsearch.text ;
                    }
                }
            }

            Rectangle
            {
                id: valuesearchrect
                width: valueCol.width
                color: "transparent"
                radius: width/20
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                MouseArea{cursorShape: Qt.PointingHandCursor}
                property bool isActive: currentFilter === valueCol.role ? true : false
                Rectangle
                {
                    border.color: parent.isActive ?  "#fdc807" : "gray"
                    border.width: 1
                    anchors.fill: parent
                    color: "gray"  //"#34537a"
                    opacity: 0.7
                    radius: parent.radius
                }
                TextField
                {
                    id: valuesearch
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    placeholderText: qsTr("Filter by value")
                    font.family: "Comic Sans MS"
                    font.pointSize: 10
                    style: TextFieldStyle{
                        textColor: "#ffffff"
                        background: Rectangle{
                            color: "transparent"
                        }
                    }
                    onTextChanged: {
                        filterModel.filterRole = valueCol.role
                        filterModel.filterString = valuesearch.text ;
                    }
                }
            }

            Rectangle
            {
                id: basedsearchrect
                width: basedCol.width
                color: "transparent"
                radius: width/20
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                MouseArea{cursorShape: Qt.PointingHandCursor}
                property bool isActive: currentFilter === basedCol.role
                Rectangle
                {
                    border.color: parent.isActive ?  "#fdc807" : "gray"
                    border.width: 1
                    anchors.fill: parent
                    color: "gray"  //"#34537a"
                    opacity: 0.7
                    radius: parent.radius
                }
                TextField
                {
                    id: basedsearch
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    placeholderText: qsTr("Filter by Based")
                    font.family: "Comic Sans MS"
                    font.pointSize: 10
                    style: TextFieldStyle{
                        textColor: "#ffffff"
                        background: Rectangle{
                            color: "transparent"
                        }
                    }
                    onTextChanged: {
                        filterModel.filterRole = basedCol.role
                        filterModel.filterString = basedsearch.text ;
                    }
                }
            }

            Rectangle
            {
                id: clearshearchrect
                color: "transparent"
                radius: width/20
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                MouseArea{cursorShape: Qt.PointingHandCursor}
                Rectangle
                {
                    border.color: parent.isActive ?  "#fdc807" : "gray"
                    border.width: 1
                    anchors.fill: parent
                    color: "gray"  //"#34537a"
                    opacity: 0.7
                    radius: parent.radius
                }
                Text
                {
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    text: qsTr("Clear")
                    font.family: "Comic Sans MS"
                    font.pointSize: 10
                    /*style: TextFieldStyle{
                        textColor: "#ffffff"
                        background: Rectangle{
                            color: "transparent"
                        }
                    }*/
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        clearFilters()
                    }
                    acceptedButtons: Qt.LeftButton
                    onPressed: {parent.state="clicked"}
                    onReleased: {parent.state="unclicked"}
                    onEntered: {
                        solo.boldfont_1 = true
                        solo.italicfont_1 = true
                        solohint.visible = true
                    }
                    onExited: {
                        solo.boldfont_1 = false
                        solo.italicfont_1 = false
                        solohint.visible = false
                    }
                }
            }

        }

        TableView {
            id: overViewTable
            width: parent.width-10
            anchors.top: searchrow.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.topMargin: 10
            backgroundVisible: false
            sortIndicatorVisible: true
            sortIndicatorColumn: 4
            sortIndicatorOrder: Qt.DescendingOrder

            TableViewColumn {
                role: "id"
                title: "id"
                visible: false
            }

            TableViewColumn {
                id: nameCol
                role: "name"
                title: qsTr("Name")
                width: parent.width/5.5
            }
            TableViewColumn {
                id: clubCol
                role: "clubName"
                title: qsTr("Club")
                width: parent.width/5.5
            }
            TableViewColumn {
                id: positionCol
                role: "position"
                title: qsTr("Position")
                width: parent.width/5.5
            }
            TableViewColumn {
                id: valueCol
                role: "value"
                title: qsTr("Value")
                width: parent.width/5.5
            }

            TableViewColumn {
                id: basedCol
                role: "based"
                title: qsTr("Based")
                width: parent.width/5.5
            }

            model: SortFilterProxyModel {
                id: filterModel
                sourceModel: poolModel
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

            onSortIndicatorColumnChanged: {
                filterModel.sortRole = overViewTable.getColumn(sortIndicatorColumn).role
                filterModel.sortOrder = sortIndicatorOrder
            }

            onSortIndicatorOrderChanged: {
                filterModel.sortRole = overViewTable.getColumn(sortIndicatorColumn).role
                filterModel.sortOrder = sortIndicatorOrder
            }

            style: TableViewStyle {
                //textColor: "white"
                //alternateBackgroundColor: Qt.lighter("gray")    //"transparent"

                headerDelegate: Rectangle {
                    color: "gray"
                    border.color: Qt.lighter("gray")
                    height: 20
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

                        visible: styleData.column === sortIndicatorColumn && sortIndicatorOrder === Qt.AscendingOrder
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
                        visible: styleData.column === sortIndicatorColumn && sortIndicatorOrder === Qt.DescendingOrder
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
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        text: (styleData.column === 4 ? currencyFormatter.currencyString(styleData.value): styleData.value)
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

                handle: ScrollBarHandle {}
                scrollBarBackground: ScrollBarBackground {
                    implicitWidth: 15
                    implicitHeight: overViewTable.height-(30)+10
                }
                decrementControl: ScrollBarDecrementControl{}
                incrementControl: ScrollBarIncrementControl{}
            }

            onClicked: {
                overViewTable.enabled = false
                app.busyIndicator.running = true;
                APIConnection.getPlayerDetails(managerUser.token, filterModel.get(row).id)
            }
        }
    }

    Connections {
        target: APIConnection
        onGetAllPlayersFinished: {
            app.busyIndicator.running = false;
            console.log(players);
            poolModel.setPlayers(players);
        }

        onGetPlayerDetailsFinished: {
            app.busyIndicator.running = false;
            overViewTable.enabled = true
            app.clubDetailsforManager = true
            if(player.isGoalkeeper === true) {
                app.callinsidepage2(goalkeeperProfile)
                goalkeeperProfile.setPlayer(player)
                if(goalkeeperProfile.player.clubId > 0){
                    APIConnection.getClubDetails(managerUser.token, goalkeeperProfile.player.clubId);
                }
                APIConnection.getPlayerComment(managerUser.token, goalkeeperProfile.player.id)
//                APIConnection.getClubPlayers(managerUser.token, goalkeeperProfile.player.clubId);
//                APIConnection.getClubPlayers(managerUser.token, goalkeeperProfile.player.clubId);
//                clubPage.loadClubPlayers(playerProfile.player.clubId)
//                clubPage.loadClubPlayers(playerProfile.player.clubId)
            }
            else {
                app.callinsidepage2(playerProfile)
                playerProfile.setPlayer(player);
                if(playerProfile.player.clubId > 0){
                    APIConnection.getClubDetails(managerUser.token, playerProfile.player.clubId);
                }
                APIConnection.getPlayerComment(managerUser.token, playerProfile.player.id)
//                APIConnection.getClubPlayers(managerUser.token, goalkeeperProfile.player.clubId);
//                APIConnection.getClubPlayers(managerUser.token, goalkeeperProfile.player.clubId);
//                clubPage.loadClubPlayers(playerProfile.player.clubId)
//                clubPage.loadClubPlayers(playerProfile.player.clubId)
            }
        }
    }

    function loadAllPlayers() {
        searchingPool.poolModel.clear();
        app.busyIndicator.running = true;
        APIConnection.getAllPlayers(managerUser.token);
        APIConnection.getAllPlayers(managerUser.token);
    }

    function clearFilters() {
        filterModel.filterRole = "";
        filterModel.filterString = "";
    }

}


/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
