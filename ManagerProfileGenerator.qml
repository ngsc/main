/*
** Added by Ahmed Soliman
** For further information use the contact form at AhmedSoliman_1234@hotmail.com.
*/
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0

import com.Game.APIConnection 1.0

Rectangle
{
    id: root
    color: "transparent"
    property string titleBar: qsTr("Manager Profile Generator")
    property int selectedClubId: 0
    property string selectedClubName: ""

    Button{
        id: done
        implicitHeight:40
        implicitWidth: 100
        opacity: 1
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.leftMargin: 80;
        anchors.topMargin: 5;
        anchors.rightMargin: 30;
        anchors.bottomMargin: 5;
        z: parent.z+1
        property bool boldfont: false
        property bool italicfont: false
        property string bordercolor: "#bfbbd3"//"#3b76b1"
        Text {
            color: "black"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.family:"Times"
            font.pointSize: 12
            text: qsTr("Done")
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                //validate data and then send it over to server
                if(managerUser.firstName.trim().length === 0) {
                    alerts.show(qsTr("Please fill in first name"), "red");
                    return;
                }

                if(managerUser.lastName.trim().length === 0) {
                    alerts.show(qsTr("Please fill in last name"), "red");
                    return;
                }

                if(managerUser.nickName.trim().length === 0) {
                    alerts.show(qsTr("Please fill in nick name"), "red");
                    return;
                }

                if(managerUser.city.trim().length === 0) {
                    alerts.show(qsTr("Please fill in city"), "red");
                    return;
                }

                if(managerUser.favFormation.trim().length === 0) {
                    alerts.show(qsTr("Please fill in your favorite formation"), "red");
                    return;
                }

                if(managerUser.userPortrait.trim().length === 0) {
                    alerts.show(qsTr("Please select your favorite portrait"), "red");
                    return;
                }

                if((managerUser.userPortrait.trim().length != 0)&&
                        (managerUser.favFormation.trim().length != 0)&&
                        (managerUser.city.trim().length != 0)&&
                        (managerUser.nickName.trim().length != 0)&&
                        (managerUser.lastName.trim().length != 0)&&
                        (managerUser.firstName.trim().length != 0)){


                    managerUser.clubId = root.selectedClubId;
                    managerUser.clubName = root.selectedClubName

                    app.clubDetailsforManager = false
                    APIConnection.updateUser(managerUser);
                    APIConnection.getClubDetails(managerUser.token, managerUser.clubId);
                    clubPage.loadClubPlayers(managerUser.clubId)
//                    clubPage.loadClubPlayers(managerUser.clubId)
                    //add club players. Call it twice to populate it. needx fixing later on
//                    APIConnection.getClubPlayers(managerUser.token, managerUser.clubId);
    //                APIConnection.getClubPlayers(managerUser.token, managerUser.clubId);
                    APIConnection.getUsers(managerUser.token)
                    APIConnection.getNews(managerUser.token, managerUser.id)
//                    getInvitationsTimer.running = true
                    getNewsTimer.running = true
                    app.callinsidepage2(clubPage)
                    clubPage.titleBar = managerUser.clubName

                    if(app.takeControl){
//                        APIConnection.getPublicNews(managerUser.token )
                        app.takeControl = false
                    }

                }

            }
            onReleased: {
                done.bordercolor = "#bfbbd3"
            }
            onPressed:{
                done.bordercolor = "yellow"
            }
        }
    }

    Rectangle{
        id : details
        anchors.top: done.bottom
        anchors.left: parent.left
        width: gridInfo.width+5
        height: parent.height-done.height
        radius: 20
        color: "gray"
        anchors.leftMargin: 5;
        anchors.topMargin: 5;
        anchors.rightMargin: 5;
        anchors.bottomMargin: 5;
        z: parent.z+1
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#6d6b79" }
            GradientStop { position: 0.50; color: "#34537a" }
            GradientStop { position: 1.0; color: "#34537a" }
        }

        MouseArea{
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
        }

        GridLayout{
            id: gridInfo
            columns: 2
            anchors.top: parent.top

            Text{
                padding: 5
                text: qsTr("Details")
                font.pointSize: 15
                font.bold: true;
                color: "#ffaa00"

            }
            Text{
                padding: 5
                text: ""
                font.pointSize: 9
                font.bold: true;
                color: "Black"
            }
            Text{
                padding: 5
                font.pointSize: 9
                text :qsTr("First Name")
                font.bold: true;
                color: "#ffaa00"
            }
            TextField{
                font.pointSize: 9
                placeholderText: managerUser.firstName !== "" ? managerUser.firstName : qsTr("Enter First Name ")
                font.bold: true;
                onTextChanged: {
                    managerUser.firstName = text
                }
            }
            Text{
                padding: 5
                font.pointSize: 9
                text :qsTr("Last Name")
                font.bold: true;
                color: "#ffaa00"
            }
            TextField{
                font.pointSize: 9
                placeholderText: managerUser.lastName !== "" ? managerUser.lastName :  qsTr("Enter Last Name ")
                font.bold: true;
                onTextChanged: {
                    managerUser.lastName = text
                }
            }
            Text{
                padding: 5
                font.pointSize: 9
                text :qsTr("Nick Name")
                font.bold: true;
                color: "#ffaa00"
            }
            TextField{
                font.pointSize: 9
                placeholderText: managerUser.nickName !== "" ? managerUser.nickName : qsTr("Enter Nick Name ")
                font.bold: true;
                onTextChanged: {
                    managerUser.nickName = text
                }
            }
            Text{
                padding: 5
                font.pointSize: 9
                text :qsTr("City")
                font.bold: true;
                color: "#ffaa00"
            }
            TextField{
                font.pointSize: 9
                placeholderText: managerUser.city !== "" ? managerUser.city : qsTr("Enter City ")
                font.bold: true;
                onTextChanged: {
                    managerUser.city = text
                }
            }
            Text{
                padding: 5
                font.pointSize: 9
                text :qsTr("Fav Club")
                font.bold: true;
                color: "#ffaa00"
            }
            TextField{
                font.pointSize: 9
                placeholderText: managerUser.clubName !== "" ? managerUser.clubName : qsTr("Enter Fav Club")
                font.bold: true;
                text: root.selectedClubName
                readOnly: true
            }
            Text{
                padding: 5
                font.pointSize: 9
                text :qsTr("Fav Formation")
                font.bold: true;
                color: "#ffaa00"
            }
            TextField{
                font.pointSize: 9
                placeholderText: (managerUser.favFormation !== "" )? managerUser.favFormation : qsTr("Enter Fav Formation [3-4-3]")
                font.bold: true;
                onTextChanged: {
                    managerUser.favFormation = text
                }
                validator: RegExpValidator { regExp: /\d\-\d\-\d/ }
            }
        }

    }

    Rectangle{
        id: smallPortraitSelector
        border.color: "gray"
        anchors.top: done.bottom
        anchors.left: details.right
        width: parent.width - (gridInfo.width+100)
        height: parent.height/2-20
        radius: 20
        z: parent.z+1
        anchors.leftMargin: 10;
        anchors.topMargin: 5;
        anchors.rightMargin: 10;
        anchors.bottomMargin: 5;
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#6d6b79" }
            GradientStop { position: 0.50; color: "#34537a" }
            GradientStop { position: 1.0; color: "#34537a" }
        }
        MouseArea{
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
        }
        GridLayout{
            id : firstRow
            columnSpacing : 5
            anchors.top: parent.top
            width: parent.width
            height: parent.height
            anchors.fill: parent
            z: parent.z+1
            anchors.leftMargin: (parent.width - (5*parent.width)/(5+1))/2;
            anchors.rightMargin: (parent.width - (5*parent.width)/(5+1))/2;
            rows    : 2
            columns : 5
            property double colMulti : firstRow.width / (firstRow.columns + 1)
            property double rowMulti : (firstRow.height / firstRow.rows)-5
            function prefWidth(item){
                return colMulti * item.Layout.columnSpan
            }
            function prefHeight(item){
                return rowMulti * item.Layout.rowSpan
            }


            Rectangle
            {
                id: adultrect
                width: smallPortraitSelector.width/10
                height: width*1.5
                border.color: "transparent"
                color: "transparent"
                anchors.leftMargin: 2;
                anchors.topMargin: 2;
                anchors.rightMargin: 2;
                anchors.bottomMargin: 2;
                Layout.rowSpan   : 1
                Layout.columnSpan: 1
                z: parent.z+1
                Layout.preferredWidth  : firstRow.prefWidth(this)
                Layout.preferredHeight : firstRow.prefHeight(this)
                property bool hoveredornot : false
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton
                    onPressed: {
//                        app_title_bar.selectedportrail = "qrc:/images/portrait/adult.jpg"
                        managerUser.userPortrait = "adult"
                        selectedPortrail.source = "qrc:/images/portrait/adult.jpg"
                    }
                    onHoveredChanged: {
                        if( adultrect.hoveredornot === false){
                            adultrect.border.color = "yellow"
                            adultrect.scale = 1.2
                            adultrect.hoveredornot = true

                        }else{
                            adultrect.border.color = "transparent"
                            adultrect.scale = 1
                            adultrect.hoveredornot = false
                        }
                    }
                }
                Image {
                    id: adult
                    width: 10
                    height: width*1.5
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    source: "qrc:/images/portrait/adult.jpg"
                }

            }

            Rectangle
            {
                id: africarect
                width: smallPortraitSelector.width/10
                height: width*1.5
                border.color: "transparent"
                color: "transparent"
                radius: 5
                anchors.leftMargin: 2;
                anchors.topMargin: 2;
                anchors.rightMargin: 2;
                anchors.bottomMargin: 2;
                Layout.rowSpan   : 1
                z: parent.z+1
                Layout.columnSpan: 1
                Layout.preferredWidth  : firstRow.prefWidth(this)
                Layout.preferredHeight : firstRow.prefHeight(this)
                property bool hoveredornot : false
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton
                    onPressed: {
//                        app_title_bar.selectedportrail = "qrc:/images/portrait/africa.jpg"
                        managerUser.userPortrait = "africa"
                        selectedPortrail.source = "qrc:/images/portrait/africa.jpg"
                    }
                    onHoveredChanged: {
                        if( africarect.hoveredornot === false){
                            africarect.border.color = "yellow"
                            africarect.scale = 1.2
                            africarect.hoveredornot = true

                        }else{
                            africarect.border.color = "transparent"
                            africarect.scale = 1
                            africarect.hoveredornot = false
                        }
                    }
                }

                Image {
                    id: africa
                    width: smallPortraitSelector.width/10
                    height: width*1.5
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    source: "qrc:/images/portrait/africa.jpg"
                }
            }

            Rectangle
            {
                id: baldrect
                width: smallPortraitSelector.width/10
                height: width*1.5
                border.color: "transparent"
                color: "transparent"
                radius: 5
                anchors.leftMargin: 2;
                anchors.topMargin: 2;
                anchors.rightMargin: 2;
                anchors.bottomMargin: 2;
                Layout.rowSpan   : 1
                Layout.columnSpan: 1
                z: parent.z+1
                Layout.preferredWidth  : firstRow.prefWidth(this)
                Layout.preferredHeight : firstRow.prefHeight(this)
                property bool hoveredornot : false
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton
                    onPressed: {
//                        app_title_bar.selectedportrail = "qrc:/images/portrait/bald.jpg"
                        managerUser.userPortrait = "bald"
                        selectedPortrail.source = "qrc:/images/portrait/bald.jpg"

                    }
                    onHoveredChanged: {
                        if( baldrect.hoveredornot === false){
                            baldrect.border.color = "yellow"
                            baldrect.scale = 1.2
                            baldrect.hoveredornot = true

                        }else{
                            baldrect.border.color = "transparent"
                            baldrect.scale = 1
                            baldrect.hoveredornot = false
                        }
                    }
                }

                Image {
                    id: bald
                    width: smallPortraitSelector.width/10
                    height: width*1.5
                    scale: 1
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    source: "qrc:/images/portrait/bald.jpg"
                }
            }

            Rectangle
            {
                id: blackrect
                width: smallPortraitSelector.width/10
                height: width*1.5
                border.color: "transparent"
                color: "transparent"
                radius: 5
                anchors.leftMargin: 2;
                anchors.topMargin: 2;
                anchors.rightMargin: 2;
                anchors.bottomMargin: 2;
                Layout.rowSpan   : 1
                Layout.columnSpan: 1
                z: parent.z+1
                Layout.preferredWidth  : firstRow.prefWidth(this)
                Layout.preferredHeight : firstRow.prefHeight(this)
                property bool hoveredornot : false
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton
                    onPressed: {
//                        app_title_bar.selectedportrail = "qrc:/images/portrait/black.jpg"
                        managerUser.userPortrait = "black"
                        selectedPortrail.source = "qrc:/images/portrait/black.jpg"
                    }
                    onHoveredChanged: {
                        if( blackrect.hoveredornot === false){
                            blackrect.border.color = "yellow"
                            blackrect.scale = 1.2
                            blackrect.hoveredornot = true

                        }else{
                            blackrect.border.color = "transparent"
                            blackrect.scale = 1
                            blackrect.hoveredornot = false
                        }
                    }
                }

                Image {
                    id: black
                    width: smallPortraitSelector.width/10
                    height: width*1.5
                    scale: 1
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    source: "qrc:/images/portrait/black.jpg"
                }
            }

            Rectangle
            {
                id: kidrect
                width: smallPortraitSelector.width/10
                height: width*1.5
                border.color: "transparent"
                color: "transparent"
                radius: 5
                anchors.leftMargin: 2;
                anchors.topMargin: 2;
                anchors.rightMargin: 2;
                anchors.bottomMargin: 2;
                Layout.rowSpan   : 1
                Layout.columnSpan: 1
                z: parent.z+1
                Layout.preferredWidth  : firstRow.prefWidth(this)
                Layout.preferredHeight : firstRow.prefHeight(this)
                property bool hoveredornot : false
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton
                    onPressed: {
//                        app_title_bar.selectedportrail = "qrc:/images/portrait/kid.jpg"
                        managerUser.userPortrait = "kid"
                        selectedPortrail.source = "qrc:/images/portrait/kid.jpg"
                    }
                    onHoveredChanged: {
                        if( kidrect.hoveredornot === false){
                            kidrect.border.color = "yellow"
                            kidrect.scale = 1.2
                            kidrect.hoveredornot = true

                        }else{
                            kidrect.border.color = "transparent"
                            kidrect.scale = 1
                            kidrect.hoveredornot = false
                        }
                    }
                }

                Image {
                    id: kid
                    width: smallPortraitSelector.width/10
                    height: width*1.5
                    scale: 1
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    source: "qrc:/images/portrait/kid.jpg"
                }
            }

            Rectangle
            {
                id: moustacherect
                width: smallPortraitSelector.width/10
                height: width*1.5
                border.color: "transparent"
                color: "transparent"
                radius: 5
                anchors.leftMargin: 2;
                anchors.topMargin: 2;
                anchors.rightMargin: 2;
                anchors.bottomMargin: 2;
                Layout.rowSpan   : 1
                Layout.columnSpan: 1
                z: parent.z+1
                Layout.preferredWidth  : firstRow.prefWidth(this)
                Layout.preferredHeight : firstRow.prefHeight(this)
                property bool hoveredornot : false
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton
                    onPressed: {
//                        app_title_bar.selectedportrail = "qrc:/images/portrait/moustache.JPG"
                        managerUser.userPortrait = "moustache"
                        selectedPortrail.source = "qrc:/images/portrait/moustache.jpg"
                    }
                    onHoveredChanged: {
                        if( moustacherect.hoveredornot === false){
                            moustacherect.border.color = "yellow"
                            moustacherect.scale = 1.2
                            moustacherect.hoveredornot = true

                        }else{
                            moustacherect.border.color = "transparent"
                            moustacherect.scale = 1
                            moustacherect.hoveredornot = false
                        }
                    }
                }

                Image {
                    id: moustache
                    width: smallPortraitSelector.width/10
                    height: width*1.5
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    source: "qrc:/images/portrait/moustache.jpg"
                }
            }

            Rectangle
            {
                id: oldrect
                width: smallPortraitSelector.width/10
                height: width*1.5
                border.color: "transparent"
                color: "transparent"
                radius: 5
                anchors.leftMargin: 2;
                anchors.topMargin: 2;
                anchors.rightMargin: 2;
                anchors.bottomMargin: 2;
                Layout.rowSpan   : 1
                Layout.columnSpan: 1
                z: parent.z+1
                Layout.preferredWidth  : firstRow.prefWidth(this)
                Layout.preferredHeight : firstRow.prefHeight(this)
                property bool hoveredornot : false
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton
                    onPressed: {
//                        app_title_bar.selectedportrail = "qrc:/images/portrait/old.jpg"
                        managerUser.userPortrait = "old"
                        selectedPortrail.source = "qrc:/images/portrait/old.jpg"
                    }
                    onHoveredChanged: {
                        if( oldrect.hoveredornot === false){
                            oldrect.border.color = "yellow"
                            oldrect.scale = 1.2
                            oldrect.hoveredornot = true

                        }else{
                            oldrect.border.color = "transparent"
                            oldrect.scale = 1
                            oldrect.hoveredornot = false
                        }
                    }
                }

                Image {
                    id: old
                    width: smallPortraitSelector.width/10
                    height: width*1.5
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    source: "qrc:/images/portrait/old.jpg"
                }
            }

            Rectangle
            {
                id: ordinaryrect
                width: smallPortraitSelector.width/10
                height: width*1.5
                border.color: "transparent"
                color: "transparent"
                radius: 5
                anchors.leftMargin: 2;
                anchors.topMargin: 2;
                anchors.rightMargin: 2;
                anchors.bottomMargin: 2;
                Layout.rowSpan   : 1
                Layout.columnSpan: 1
                z: parent.z+1
                Layout.preferredWidth  : firstRow.prefWidth(this)
                Layout.preferredHeight : firstRow.prefHeight(this)
                property bool hoveredornot : false
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton
                    onPressed: {
//                        app_title_bar.selectedportrail = "qrc:/images/portrait/ordinary.jpg"
                        managerUser.userPortrait = "ordinary"
                        selectedPortrail.source = "qrc:/images/portrait/ordinary.jpg"
                    }
                    onHoveredChanged: {
                        if( ordinaryrect.hoveredornot === false){
                            ordinaryrect.border.color = "yellow"
                            ordinaryrect.scale = 1.2
                            ordinaryrect.hoveredornot = true

                        }else{
                            ordinaryrect.border.color = "transparent"
                            ordinaryrect.scale = 1
                            ordinaryrect.hoveredornot = false
                        }
                    }
                }

                Image {
                    id: ordinary
                    width: smallPortraitSelector.width/10
                    height: width*1.5
                    scale: 1
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    source: "qrc:/images/portrait/ordinary.jpg"
                }
            }

            Rectangle
            {
                id: yellowhairrect
                width: smallPortraitSelector.width/10
                height: width*1.5
                border.color: "transparent"
                color: "transparent"
                radius: 5
                anchors.leftMargin: 2;
                anchors.topMargin: 2;
                anchors.rightMargin: 2;
                anchors.bottomMargin: 2;
                Layout.rowSpan   : 1
                Layout.columnSpan: 1
                z: parent.z+1
                Layout.preferredWidth  : firstRow.prefWidth(this)
                Layout.preferredHeight : firstRow.prefHeight(this)
                property bool hoveredornot : false
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton
                    onPressed: {
//                        app_title_bar.selectedportrail = "qrc:/images/portrait/yellow hair.jpg"
                        managerUser.userPortrait = "yellow hair"
                        selectedPortrail.source = "qrc:/images/portrait/yellow hair.jpg"
                    }
                    onHoveredChanged: {
                        if( yellowhairrect.hoveredornot === false){
                            yellowhairrect.border.color = "yellow"
                            yellowhairrect.scale = 1.2
                            yellowhairrect.hoveredornot = true

                        }else{
                            yellowhairrect.border.color = "transparent"
                            yellowhairrect.scale = 1
                            yellowhairrect.hoveredornot = false
                        }
                    }
                }

                Image {
                    id: yellowhair
                    width: smallPortraitSelector.width/10
                    height: width*1.5
                    scale: 1
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    source: "qrc:/images/portrait/yellow hair.jpg"
                }
            }

            Rectangle
            {
                id: youngrect
                border.color: "transparent"
                color: "transparent"
                radius: 5
                anchors.leftMargin: 2;
                anchors.topMargin: 2;
                anchors.rightMargin: 2;
                anchors.bottomMargin: 2;
                Layout.rowSpan   : 1
                Layout.columnSpan: 1
                z: parent.z+1
                Layout.preferredWidth  : firstRow.prefWidth(this)
                Layout.preferredHeight : firstRow.prefHeight(this)
                property bool hoveredornot : false
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton
                    onPressed: {
//                        app_title_bar.selectedportrail = "qrc:/images/portrait/young.JPG"
                        managerUser.userPortrait = "young"
                        selectedPortrail.source = "qrc:/images/portrait/young.jpg"
                    }
                    onHoveredChanged: {
                        if( youngrect.hoveredornot === false){
                            youngrect.border.color = "yellow"
                            youngrect.scale = 1.2
                            youngrect.hoveredornot = true

                        }else{
                            youngrect.border.color = "transparent"
                            youngrect.scale = 1
                            youngrect.hoveredornot = false
                        }
                    }
                }

                Image {
                    id: young
                    width: smallPortraitSelector.width/10
                    height: width*1.5
                    scale: 1
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    source: "qrc:/images/portrait/young.jpg"
                }
            }
        }
    }

    Rectangle{
        id: largePortraitSelector
        border.color: "gray"
        anchors.top: smallPortraitSelector.bottom
        anchors.left: details.right
        width: parent.width - (gridInfo.width+100)
        height: parent.height - (smallPortraitSelector.height+20+done.height)
        radius: 20
        anchors.leftMargin: 10;
        anchors.topMargin: 10;
        anchors.rightMargin: 10;
        anchors.bottomMargin: 10;
        z : parent.z+1
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#6d6b79" }
            GradientStop { position: 0.50; color: "#34537a" }
            GradientStop { position: 1.0; color: "#34537a" }
        }
        Image {
            id: selectedPortrail
            scale: 1
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            source: app_title_bar.selectedportrail
        }
        MouseArea{
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
        }

    }
}
