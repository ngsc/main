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

import QtQuick 2.4
import QtQuick.Controls 2.0
import com.Game.Player 1.0

import com.Game.APIConnection 1.0
import com.Game.Club 1.0
import com.Game.SortFilterProxyModel 1.0
import Constants 1.0

Rectangle {
    id: offertoclubPage
    color: "transparent"
    border.color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    property string titleBar: managerUser.clubName
    property string transferValueText : ""
    property int index: 0
    property bool activeIndex: true
    //    property ListModel itemsList
    ClubModel {
        id: clubModel
    }

    ListModel {
        id: itemsList
        ListElement {
            fee: "$0"
        }
    }

    function fillFeeList(){
        index = 0 ;
        if(playerProfile.player.value > 0){
            for(var i = playerProfile.player.value/10 ; i < playerProfile.player.value*10 ; i+=playerProfile.player.value/100){
                if(activeIndex){
                    index++;
                }
                if(i === playerProfile.player.value ){
                    activeIndex = false
                }
                itemsList.append({"fee" :currencyFormatter.currencyString(i)})
            }
        }else{
            for(var i = 1000000 ; i < 10000000 ; i+=100000){
                itemsList.append({"fee" :currencyFormatter.currencyString(i)})
            }
        }

        //        for(var i = 100000 ; i < 1000000 ; i+=10000){
        //            if(activeIndex){
        //                index++;
        //            }
        //            if((i < playerProfile.player.value && playerProfile.player.value < i+10000)||
        //                    (0 < playerProfile.player.value && i === 100000)){
        //                itemsList.append({"fee" : currencyFormatter.currencyString(playerProfile.player.value)})
        //                activeIndex = false;
        //            }
        //            itemsList.append({"fee" :currencyFormatter.currencyString(i)})
        //        }
    }

    CustomGroupBox {
        id: transferValueBox
        anchors.top: parent.top
        width: parent.width
        height: 70
        title_text: qsTr("Transfer Value")
        border_color: "#55aaff"
        border_width: 1
        box_content_item: Rectangle {
            anchors.fill: parent
            color: "transparent"
            radius: parent.radius
            clip: true

            Text {
                id: comment_label
                text: qsTr(transferValueText)
                font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                color: "#ffffff"
                anchors.left: parent.left
                anchors.top: parent.top
                font.pointSize: 11
                anchors.leftMargin: 20
                anchors.topMargin: 5
            }
        }
    }

    CustomGroupBox {
        id: basicOfferBox
        anchors.top: transferValueBox.bottom
        width: parent.width
        height: 100
        title_text: qsTr("Basic Offer")
        border_color: "#55aaff"
        border_width: 1
        box_content_item: Rectangle {
            anchors.fill: parent
            color: "transparent"
            radius: parent.radius
            clip: true

            Text {
                id: offerTypeLabel
                text: qsTr("Offer Type")
                font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                color: "#ffffff"
                anchors.left: parent.left
                anchors.top: parent.top
                font.pointSize: 11
                anchors.leftMargin: 20
                anchors.topMargin: 5
            }
            CustomComboBox {
                id: offerTypeComboBox
                items_list:  [qsTr("Transfer"), qsTr("Loan")]
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 20
                anchors.topMargin: 5
                width: offertoclubPage.width/2
                enabled: false
                height: 15
                //                currentIndex: app.mainwindow.getSkin()
            }

            Text {
                id: feeLabel
                text: qsTr("Fee")
                font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                color: "#ffffff"
                anchors.left: parent.left
                anchors.top: offerTypeLabel.bottom
                font.pointSize: 11
                anchors.leftMargin: 20
                anchors.topMargin: 10
            }
            Rectangle
            {
                id: decreasebutton
                height: 25
                width: 25
                radius: 3
                color: "#3b76b1"
                anchors.right: parent.right
                anchors.top: offerTypeComboBox.bottom
                anchors.rightMargin: 20
                anchors.topMargin: 27
                Text
                {
                    id : decreasetext
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    verticalAlignment: Text.AlignVCenter;
                    horizontalAlignment: Text.AlignHCenter
                    color: "white"
                    font.family: Constants.primaryFont ? Constants.primaryFont.name: null//"Kristen ITC"
                    font.pointSize: 15
                    font.bold: true
                    //                    font.italic: italicfont
                    text: qsTr('-')
                }
                MouseArea{
                    //                    id:mouseAreatext
                    anchors.fill:parent
                    hoverEnabled:true
                    onEntered: {
                        decreasebutton.color = "#2e598f"
                        decreasebutton.border.color = "white"
                    }
                    onExited: {
                        decreasebutton.color = "#3b76b1"
                        decreasebutton.border.color = "transparent"
                    }
                    onClicked: {
                        if(feeComboBox.currentIndex > 0){
                            feeComboBox.currentIndex--
                            APIConnection.setPlayerValue(managerUser.token,playerProfile.player.id,feeComboBox.currenText.toString())
                            //                            console.log(feeComboBox.currenText)
                        }

                    }
                }
            }
            Rectangle
            {
                id: increasebutton
                height: 25
                width: 25
                radius: 3
                color: "#3b76b1"
                anchors.right: decreasebutton.left
                anchors.top: offerTypeComboBox.bottom
                anchors.rightMargin: 5
                anchors.topMargin: 27
                Text
                {
                    id : increasetext
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    verticalAlignment: Text.AlignVCenter;
                    horizontalAlignment: Text.AlignHCenter
                    color: "white"
                    font.family: Constants.primaryFont ? Constants.primaryFont.name: null//"Kristen ITC"
                    font.pointSize: 15
                    font.bold: true
                    //                    font.italic: italicfont
                    text: qsTr('+')
                }
                MouseArea{
                    //                    id:mouseAreatext
                    anchors.fill:parent
                    hoverEnabled:true
                    onEntered: {
                        increasebutton.color = "#2e598f"
                        increasebutton.border.color = "white"
                    }
                    onExited: {
                        increasebutton.color = "#3b76b1"
                        increasebutton.border.color = "transparent"
                    }
                    onClicked: {
                        if(itemsList.count > feeComboBox.currentIndex )//TODO
                            feeComboBox.currentIndex++
                    }
                }
            }

            CustomComboBox {
                id: feeComboBox
                items_list: itemsList//["Ferhan Blue", "Red Devil"]
                //                anchors.verticalCenter: skin_label.verticalCenter
                //                currenText: qsTr(currencyFormatter.currencyString(playerProfile.player.value))
                currentIndex: index
                anchors.right: increasebutton.left
                anchors.top: offerTypeComboBox.bottom
                anchors.rightMargin: 5
                anchors.topMargin: 25
                width: offertoclubPage.width/2 - 60
                height: 15
                //                currentIndex: app.mainwindow.getSkin()
            }
        }
    }

    CustomGroupBox {
        id: clubsToTargetBox
        anchors.top: basicOfferBox.bottom
        width: parent.width
        height: 150
        title_text: qsTr("Clubs To Target")
        border_color: "#55aaff"
        border_width: 1
        box_content_item: Rectangle {
            anchors.fill: parent
            color: "transparent"
            radius: parent.radius
            clip: true

            TableView {
                id: clubsTable
                width: 370
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                //                anchors.right: parent.right
                anchors.leftMargin: 20
                visible: false
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
                    width: 1
                }

//                TableViewColumn {
//                    id: isTargetClub
//                    role:  "targetClub"
//                    title: "isTargetClub"
//                    width: 199
//                    delegate: CheckBox {
//                        anchors.fill: parent
//                        checked:styleData.value
//                        enabled: true
//                        //                          text: qsTr("is Target Club")
//                        onCheckStateChanged: {
//                            //                            styleData.value = checkState
//                            //                            clubsTable.model.get(styleData.row).targetClub = checkState
//                            //                            styleData.value = checkState
//                            //                            filterModel.get(styleData.row).settargetClub = checkState
//                            //                            console.log(filterModel.get(styleData.row).targetClub)
//                            console.log(checkState)
//                        }
//                    }
//                }

                TableViewColumn {
                    id: nameCol
                    role: "name"
                    title: qsTr("Team")
                    width: 350
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
                        //                        console.log("filter role changed to " + role)
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
                        width: 200
                        radius: 10
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
                            font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                            font.pointSize: 10
                            font.bold: true
                        }
                        Rectangle {
                            id: sortArrowUp
                            anchors.left: textHeader.right
                            anchors.leftMargin: 10
                            anchors.top: parent.top
                            //                            anchors.verticalCenter: textHeader.verticalCenter
                            implicitWidth: 15
                            implicitHeight: 15
                            z:11
                            color: "transparent"    //"#34537a"
                            Image
                            {
                                anchors.fill: parent
                                anchors.margins: 1
                                fillMode: Image.Stretch
                                source: "qrc:/icons/arrow-orange-up.png"
                                opacity: 1
                            }
                            MouseArea{
                                anchors.fill:parent
                                onClicked: {
                                    console.log("mnbfvbdvxszgxhg")
                                    filterModel.sortOrder = Qt.DescendingOrder
                                }
                            }

                            visible: true
                        }
                        Rectangle {
                            id: sortArrowDown
                            anchors.left: textHeader.right
                            anchors.leftMargin: 10
                            anchors.bottom: parent.bottom
                            //                            anchors.verticalCenter: textHeader.verticalCenter
                            implicitWidth: 15
                            z:parent.z+1
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
                            MouseArea{
                                anchors.fill:parent
                                onClicked: {
                                    filterModel.sortOrder = Qt.AscendingOrder
                                }
                            }
                            visible: true
                        }
                    }

                    itemDelegate: Rectangle {
                        color: "transparent"
                        height: 35
                        width: 300
                        Text {
                            id: textItem
                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            text: qsTr(styleData.value.toString())
                            elide: Text.ElideRight
                            color: clubsTable.model.get(styleData.row).foreground1Value ? clubsTable.model.get(styleData.row).foreground1Value : "black"
                            renderType: Text.NativeRendering
                            font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                            font.pointSize: 10
                        }
                        CheckBox {
//                            anchors.fill: parent
                            anchors.left: parent.left
                            checked: false//clubsTable.model.get(styleData.row).targetClub
                            enabled: true
                            //                          text: qsTr("is Target Club")
                            onCheckStateChanged: {
//                                clubModel.get(styleData.row).targetClub(checkState)
//                                clubsTable.model.get(styleData.row).settargetClub(checkState)
                                //                            styleData.value = checkState
                                //                            clubsTable.model.get(styleData.row).targetClub = checkState
                                //                            styleData.value = checkState
                                //                            filterModel.get(styleData.row).settargetClub = checkState
                                //                            console.log(filterModel.get(styleData.row).targetClub)
                                console.log(clubsTable.model.get(styleData.row).targetClub,styleData.value.toString())
                                console.log(checkState)
                            }
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

            Rectangle{
                id: addButton
                width: 50
                height: 30
                radius: 7
                color: enabel ? "#3b76b1" : "#2e599f"
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 10
                anchors.topMargin: 5
                property bool enabel: true
                Text
                {
                    id : addtext
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    verticalAlignment: Text.AlignVCenter;
                    horizontalAlignment: Text.AlignHCenter
                    color: "white"
                    font.family: Constants.primaryFont ? Constants.primaryFont.name: null//"Kristen ITC"
                    font.pointSize: 10
                    //                    font.bold: true
                    //                    font.italic: italicfont
                    text: qsTr("Add")
                }
                MouseArea{
                    //                    id:mouseAreatext
                    anchors.fill:parent
                    hoverEnabled:true
                    onEntered: {
                        if(addButton.enabel){
                            addButton.color = "#2e598f"
                            addButton.border.color = "white"
                        }
                    }
                    onExited: {
                        if(addButton.enabel){
                            addButton.color = "#3b76b1"
                            addButton.border.color = "transparent"
                        }
                    }
                    onClicked: {
                        if(addButton.enabel){
                            addMenu.open()
                        }
                    }
                }
            }

            Rectangle{
                id: removeButton
                width: 80
                height: 30
                radius: 7
                color: enabel ? "#3b76b1" : "#2e599f"
                anchors.right: addButton.left
                anchors.top: parent.top
                anchors.rightMargin: 10
                anchors.topMargin: 5
                property bool enabel: false
                Text
                {
                    id : removetext
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    verticalAlignment: Text.AlignVCenter;
                    horizontalAlignment: Text.AlignHCenter
                    color: "white"
                    font.family: Constants.primaryFont ? Constants.primaryFont.name: null//"Kristen ITC"
                    font.pointSize: 10
                    font.bold: true
                    //                    font.italic: italicfont
                    text: qsTr("Remove")
                }
                MouseArea{
                    //                    id:mouseAreatext
                    anchors.fill:parent
                    hoverEnabled:true
                    onEntered: {
                        if(removeButton.enabel){
                            removeButton.color = "#2e598f"
                            removeButton.border.color = "white"
                        }
                    }
                    onExited: {
                        if(removeButton.enabel){
                            removeButton.color = "#3b76b1"
                            removeButton.border.color = "transparent"
                        }
                    }
                    onClicked: {
                        if(removeButton.enabel){

                        }
                    }
                }
            }

            Rectangle{
                id: removeAllButton
                width: 120
                height: 30
                radius: 7
                color: enabel ? "#3b76b1" : "#2e599f"
                anchors.right: removeButton.left
                anchors.top: parent.top
                anchors.rightMargin: 10
                anchors.topMargin: 5
                property bool enabel: false
                Text
                {
                    id : removeAlltext
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    verticalAlignment: Text.AlignVCenter;
                    horizontalAlignment: Text.AlignHCenter
                    color: "white"
                    font.family: Constants.primaryFont ? Constants.primaryFont.name: null//"Kristen ITC"
                    font.pointSize: 10
                    font.bold: true
                    //                    font.italic: italicfont
                    text: qsTr("Remove All")
                }
                MouseArea{
                    //                    id:mouseAreatext
                    anchors.fill:parent
                    hoverEnabled:true
                    onEntered: {
                        if(removeAllButton.enabel){
                            removeAllButton.color = "#2e598f"
                            removeAllButton.border.color = "white"
                        }
                    }
                    onExited: {
                        if(removeAllButton.enabel){
                            removeAllButton.color = "#3b76b1"
                            removeAllButton.border.color = "transparent"
                        }
                    }
                    onClicked: {
                        if(removeAllButton.enabel){

                        }
                    }
                }
            }
        }
    }

    CustomGroupBox {
        id: commentsBox
        //        anchors.right: parent.right
        //        anchors.horizontalCenter: parent
        anchors.top: clubsToTargetBox.bottom
        width: parent.width
        height: 100
        title_text: qsTr("Comments")
        border_color: "#55aaff"
        border_width: 1
        box_content_item: Rectangle {
            anchors.fill: parent
            color: "transparent"
            radius: parent.radius
            clip: true

        }
    }

    Menu {
        id: addMenu
        width: 150
        x:addButton.x
        y:clubsToTargetBox.y + 50

        MenuItem {
            id: allHumanClubsAction
            text: qsTr("All Human clubs")
            enabled:  true
            background: allHumanClubsbackground
            onClicked: {
                APIConnection.getClubs(managerUser.token);
            }
            Rectangle
            {
                id: allHumanClubsbackground
                anchors.fill: parent
                border.color: "black"
                color: allHumanClubsAction.enabled ? "light gray" :"white"
            }
        }

        MenuItem {
            id: leagueAAction
            text: qsTr("League A clubs")
            enabled:  true
            background: leagueAActionbackground
            onClicked: {
                APIConnection.getClubsByLeague(managerUser.token, 0);
            }
            Rectangle
            {
                id: leagueAActionbackground
                anchors.fill: parent
                border.color: "black"
                color: leagueAAction.enabled ? "light gray" :"white"
            }
        }

        MenuItem {
            id: leagueBAction
            text: qsTr("league B clubs")
            enabled: true
            background: leagueBActionbackground
            onClicked: {
                APIConnection.getClubsByLeague(managerUser.token, 1);
            }
            Rectangle
            {
                id: leagueBActionbackground
                anchors.fill: parent
                border.color: "black"
                color: leagueBAction.enabled ? "light gray" :"white"
            }
        }
    }

    Connections{
        target: APIConnection

        onGetClubsFinished: {
            if(stackView.__currentItem === offerToClubPage){
                app.busyIndicator.running = false
                clubModel.setClubs(clubs);
                clubsTable.visible = true
            }

            //            if(clubModel.rowCount() > 0)
            //            {
            //                var lid = clubModel.get(0).leagueId
            //                root.currentLeague = parseInt(lid)
            //                app_title_bar.showselectedclubname = true
            //                if(root.currentLeague === 0)
            //                {
            //                    app_title_bar.title = qsTr("League A");
            //                    app_title_bar.selectedclubname = qsTr("League B");
            //                }
            //                else
            //                {
            //                    app_title_bar.title = qsTr("League B");
            //                    app_title_bar.selectedclubname = qsTr("League A");
            //                }
            //            }
        }
    }
}
