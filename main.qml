import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0
import com.Game.APIConnection 1.0
import com.Game.User 1.0
import com.Game.Player 1.0

ApplicationWindow
{
    id: app
    width: 1366
    height: 768
    property alias main_window: main_window
    visible: true
    //flags: Qt.FramelessWindowHint

    property bool announcement_board_is_minim: false

    property alias busyIndicator: busyIndicator

    function callinsidepage2(pagename){
        if(stackView.__currentItem !== pagename) {
            app_title_bar.pushProperties(app_title_bar.backwardTitleProperties)
            app_title_bar.reset()
            app_title_bar.title = pagename.titleBar
            stackView.push({item: pagename, properties: {objectName: pagename.toString()}})
        }
    }

    function delayTimer(delay, cb){
        timer.interval = delay
        timer.repeat = false
        timer.triggered.connect(cb)
        timer.start()
    }

    Timer {
        id: timer
    }

    Timer {
        id: getInvitationsTimer
        interval: 10000
        running: false
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            APIConnection.getInvitations(managerUser.token, managerUser.id)
        }
    }

    Timer {
        id: getNewsTimer
        interval: 10000
        running: false
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            APIConnection.getNews(managerUser.token, managerUser.id)
        }
    }

    Rectangle {
        id: main_window
        anchors.fill: parent
        color: "transparent"
        radius: 10
        z:parent.z+1
        //visible: false
        Image {
            id: backgound_image
            source: "qrc:/icons/background.jpg"
            anchors.fill: parent
            fillMode: Image.Stretch
            MouseArea{
                cursorShape: Qt.PointingHandCursor
            }
        }

        Rectangle {
            id: background_cover
            anchors.fill: parent
            color: "#34537a"
            opacity: 0.7
        }

        TitleBar {
            id: app_title_bar
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 30
        }

        MenuButton {
            id: playerActions
            anchors.left: panel_5_compr_buttons.left
            anchors.top: flowing_comment_field.top
            height: flowing_comment_field.height
            visible: stackView.__currentItem === playerProfile || stackView.__currentItem === goalkeeperProfile
            width: 100
        }


        Rectangle {
            id: flowing_comment_field
            color: "transparent"//"#6d6b79"
            radius: width/2
            opacity: 0.5
            //anchors.left: main_window.left
            //anchors.leftMargin: 200
            anchors.horizontalCenter: bullet_comment.horizontalCenter
            anchors.top: app_title_bar.bottom
            anchors.topMargin: 30
            width: 600
            height: 40
            visible: stackView.__currentItem !== signinPage && stackView.__currentItem !== signupPage
            MouseArea{cursorShape: Qt.PointingHandCursor}
            Rectangle {
                color: "#ffffff"
                anchors.fill: parent
                radius: parent.radius
                opacity: 0.5
            }
            clip: true
            TextField {
                id: flowing_comment_field_text
                width: parent.width
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                font.family: "Comic Sans MS"
                font.pointSize: 12
                activeFocusOnPress: false
                style: TextFieldStyle{
                    textColor: "#ffffff"
                    background: Rectangle{
                        radius: flowing_comment_field.radius
                        color: "transparent"
                    }
                }

                NumberAnimation on x { running: true; from: -1*flowing_comment_field.width; to: flowing_comment_field.width; duration: 10000; loops: Animation.Infinite }
            }
        }

        AnnouncementBoard {
            id: annonucement_board
            anchors.top: app_title_bar.top
            anchors.topMargin: 1
            anchors.right: main_window.right
            anchors.rightMargin: 5

            height: announcement_board_is_minim==true ? 0 : parent.height-app_title_bar.height-10+40
            visible: stackView.__currentItem !== signinPage && stackView.__currentItem !== signupPage
        }

        Rectangle {
            id: panel_5_compr_buttons
            anchors.bottom: parent.bottom
            anchors.margins: 10
            anchors.left: app_title_bar.left
            anchors.right: app_title_bar.right
            height: 70
            color: "transparent"
            visible: stackView.__currentItem !== signinPage && stackView.__currentItem !== signupPage
            MouseArea{cursorShape: Qt.PointingHandCursor}

            Panel5Button
            {
                id: button_1
                anchors.bottom: parent.top
                anchors.left: parent.left
                button_text: "2D View"
                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed:  {
                        callinsidepage2(monitor)
                    }
                    onEntered:
                    {
                        button_1.button_bottom_line_visibility=true
                    }
                    onExited:
                    {
                        button_1.button_bottom_line_visibility=false
                    }
                }
            }
            Panel5Button
            {
                id: button_2
                anchors.bottom: parent.top
                anchors.left: button_1.right
                button_text: "Commentary Report"
                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed:  {
                        commentaryPage.text = monitorControl.getCommentaryLog();
                        callinsidepage2(commentaryPage)
                    }
                    onEntered:
                    {
                        button_2.button_bottom_line_visibility=true
                    }
                    onExited:
                    {
                        button_2.button_bottom_line_visibility=false
                    }
                }
            }
            Panel5Button
            {
                id: button_3
                anchors.bottom: parent.top
                anchors.left: button_2.right
                button_text: "Left Side Statistics"
                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed:  {
                        button_3.button_text = monitorControl.getLeftName() + " Statistics";
                        team_left_statistic_page.titleBar = monitorControl.getLeftName() + " Statistics";
                        team_left_statistic_page.text= monitorControl.getTeamLeftStats();
                        callinsidepage2(team_left_statistic_page)
                    }
                    onEntered:
                    {
                        button_3.button_bottom_line_visibility=true
                    }
                    onExited:
                    {
                        button_3.button_bottom_line_visibility=false
                    }
                }
            }
            Panel5Button
            {
                id: button_4
                anchors.bottom: parent.top
                anchors.left: button_3.right
                button_text: "Right Side Statistics"
                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed:  {
                        button_4.button_text = monitorControl.getRightName() + " Statistics";
                        team_right_statistic_page.titleBar = monitorControl.getRightName() + " Statistics";
                        team_right_statistic_page.text= monitorControl.getTeamRightStats();
                        callinsidepage2(team_right_statistic_page)
                    }
                    onEntered:
                    {
                        button_4.button_bottom_line_visibility=true
                    }
                    onExited:
                    {
                        button_4.button_bottom_line_visibility=false
                    }
                }
            }
            Panel5Button
            {
                id: button_5
                anchors.bottom: parent.top
                anchors.left: button_4.right
                button_text: "2D View"
                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed:  {
                        callinsidepage2(monitor)
                    }
                    onEntered:
                    {
                        button_5.button_bottom_line_visibility=true
                    }
                    onExited:
                    {
                        button_5.button_bottom_line_visibility=false
                    }
                }
            }
            Panel5Button {
                id: button_6
                anchors.top: button_1.bottom
                anchors.left: parent.left
                button_text: "Manager's HQ"
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: {//console.log(stackView.__currentItem.objectName.toString())
                        if(stackView.__currentItem.objectName.toString()!="ManagerProfile.qml"){
                            if((firstName != "") &&(lastName != "" )&& (selectedportrail != "")){
                                title = firstName + " " + lastName
                                setportrailVisible = true
                                stackView.push({item: managerProfile, properties:{objectName:"ManagerProfile.qml"}})
                            }
                        }
                    }
                    onEntered:
                    {
                        button_6.button_bottom_line_visibility=true
                    }
                    onExited:
                    {
                        button_6.button_bottom_line_visibility=false
                    }
                }

            }
            Panel5Button
            {
                id: button_7
                anchors.top: button_2.bottom
                anchors.left: button_6.right
                button_text: qsTr("Squad")
                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed:  { }
                    onEntered: {
                        button_7.button_bottom_line_visibility=true
                    }
                    onExited: {
                        button_7.button_bottom_line_visibility=false
                    }
                    onClicked: {
                        if(managerUser.clubId === 0) {
                            console.log("First select a club before going to squad page...");
                            return;
                        }

                        callinsidepage2(clubPage)
                        clubPage.setClub();
                    }
                }
            }
            Panel5Button
            {
                id: button_8
                anchors.top: button_3.bottom
                anchors.left: button_7.right
                button_text: "Tactics Center"
                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed:  { }
                    onEntered:
                    {
                        button_8.button_bottom_line_visibility=true
                    }
                    onExited:
                    {
                        button_8.button_bottom_line_visibility=false
                    }
                    onClicked:
                    {
                        if(managerUser.clubId === 0)
                        {
                            //
                            console.log("First select a club before going to tactis page...");
                            return;
                        }

                        callinsidepage2(tacticPage)
                        tacticPage.setPlayers(clubPage.pModel.players())
                    }
                }
            }
            Panel5Button
            {
                id: button_9
                anchors.top: button_4.bottom
                anchors.left: button_8.right
                button_text: qsTr("Finance")
                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed:  { }
                    onEntered:
                    {
                        button_9.button_bottom_line_visibility=true
                    }
                    onExited:
                    {
                        button_9.button_bottom_line_visibility=false
                    }
                }
            }
            Panel5Button
            {
                id: button_10
                anchors.top: button_5.bottom
                anchors.left: button_9.right
                button_text: qsTr("News")

                Rectangle {
                    id: flash
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.left: parent.left
                    height: 3

                    color: "transparent"
                    SequentialAnimation {
                        id: newsflashanimation
                        loops: Animation.Infinite
                        alwaysRunToEnd: true
                        //running: stackView.__currentItem !== newsPage && newsPage.newsModel.count !== newsPage.newsCount
                        ColorAnimation { target: flash; property: "color"; from: "transparent"; to: "red"; duration: 900; easing.type: Easing.OutQuad}
                        ColorAnimation { target: flash; property: "color"; from: "red"; to: "red";  duration: 600 }
                        ColorAnimation { target: flash; property: "color"; from: "red"; to: "transparent";  duration: 900; easing.type: Easing.InQuad }
                        ColorAnimation { target: flash; property: "color"; from: "transparent"; to: "transparent";  duration: 1000 }
                    }
                }
            }
            Panel5Button
            {
                id: button_11
                anchors.top: button_6.bottom
                anchors.left: parent.left
                button_text: "Next Opponent"
                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed:  { }
                    onEntered:
                    {
                        button_11.button_bottom_line_visibility=true
                    }
                    onExited:
                    {
                        button_11.button_bottom_line_visibility=false
                    }
                }
            }
            Panel5Button
            {
                id: button_12
                anchors.top: button_7.bottom
                anchors.left: button_11.right
                button_text: qsTr("Fixture")
                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed:  { }
                    onEntered:
                    {
                        button_12.button_bottom_line_visibility=true
                    }
                    onExited:
                    {
                        button_12.button_bottom_line_visibility=false
                    }

                    onClicked:
                    {
                        callinsidepage2(fixturePage)
                        fixturePage.loadFixtures();
                        fixturePage.loadFixtures();
                    }
                }
            }
            Panel5Button
            {
                id: button_13
                anchors.top: button_8.bottom
                anchors.left: button_12.right
                button_text: "Searching Pool"
                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed:  { }
                    onEntered:
                    {
                        button_13.button_bottom_line_visibility=true
                    }
                    onExited:
                    {
                        button_13.button_bottom_line_visibility=false
                    }

                    onClicked: {
                        callinsidepage2(searchingPool)
                        searchingPool.loadAllPlayers()
                    }
                }
            }
            Panel5Button
            {
                id: button_14
                anchors.top: button_9.bottom
                anchors.left: button_13.right
                button_text: "Current League"
                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed:  { }
                    onEntered:
                    {
                        button_14.button_bottom_line_visibility=true
                    }
                    onExited:
                    {
                        button_14.button_bottom_line_visibility=false
                    }
                    onClicked: {
                        callinsidepage2(leaguePage)
                        leaguePage.loadLeagueClubs(managerUser.clubId)
                        leaguePage.loadLeagueClubs(managerUser.clubId)
                    }
                }
            }
            Panel5Button
            {
                id: button_15
                anchors.top: button_10.bottom
                anchors.left: button_14.right
                button_text: qsTr("Additional")
                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed:  { }
                    onEntered:
                    {
                        button_15.button_bottom_line_visibility=true
                    }
                    onExited:
                    {
                        button_15.button_bottom_line_visibility=false
                    }
                }
            }



            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
                onPressed:  {  }
                onEntered:
                {
                    button_12.button_bottom_line_visibility=true
                }
                onExited:
                {
                    button_12.button_bottom_line_visibility=false
                }
                onClicked: {
                    callinsidepage2(newsPage)
                }
            }



        }

        Rectangle
        {
            id: bullet_comment
            anchors.horizontalCenter: app_title_bar.horizontalCenter
            anchors.bottom: panel_5_compr_buttons.top
            anchors.bottomMargin: 40
            width: 600
            height: 40
            color: "transparent"
            radius: width/2
            visible: stackView.__currentItem !== signinPage && stackView.__currentItem !== signupPage
            MouseArea{cursorShape: Qt.PointingHandCursor}
            Rectangle
            {
                border.color: "#fdc807"
                border.width: 3
                anchors.fill: parent
                color: "#34537a"
                opacity: 0.7
                radius: parent.radius
            }
            TextField
            {
                id: bullet_comment_field_text
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: parent.width-35
                font.family: "Comic Sans MS"
                font.pointSize: 12
                style: TextFieldStyle{
                    textColor: "#ffffff"
                    background: Rectangle{
                        //border.color: "#fdc807"
                        //border.width: 3
                        //radius: width/2
                        color: "transparent"
                    }
                }

                Keys.onReturnPressed: {
                    flowing_comment_field_text.text=bullet_comment_field_text.text;
                }
            }
            Image
            {
                id: send_icon
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height-15
                width: height
                fillMode: Image.Stretch
                source : "qrc:/icons/arrow-blue.png"
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onClicked: {
                        flowing_comment_field_text.text=bullet_comment_field_text.text;
                    }
                }
            }
        }

        StackView
        {
            id: stackView
            anchors.left: panel_5_compr_buttons.left
            anchors.right: panel_5_compr_buttons.right
            anchors.top: flowing_comment_field.bottom
            anchors.topMargin: 10
            anchors.bottom: bullet_comment.top
            anchors.bottomMargin: 20
            clip: true
            // Implements back key navigation
            focus: true
            Keys.onReleased: if (event.key === Qt.Key_Back && stackView.depth > 1) {
                                 app_title_bar.popPage()
                                 event.accepted = true;
                             }

            delegate: StackViewDelegate {///added by Ahmed

                function getTransition(properties)
                {
                    return (properties.enterItem.Stack.index % 2) ? horizontalTransition : verticalTransition
                }

                function transitionFinished(properties)
                {
                    properties.exitItem.x = 0
                    properties.exitItem.y = 0
                }

                property Component horizontalTransition: StackViewTransition {
                    PropertyAnimation {
                        target: enterItem
                        property: "x"
                        from: target.width
                        to: 0
                        duration: 300
                    }
                    PropertyAnimation {
                        target: exitItem
                        property: "x"
                        from: 0
                        to: target.width
                        duration: 300
                    }
                }

                property Component verticalTransition: StackViewTransition {
                    PropertyAnimation {
                        target: enterItem
                        property: "y"
                        from: target.height
                        to: 0
                        duration: 300
                    }
                    PropertyAnimation {
                        target: exitItem
                        property: "y"
                        from: 0
                        to: target.height
                        duration: 300
                    }
                }
            }

            initialItem: Item {
                id: item1
                width: parent.width
                height: parent.height

                Rectangle
                {
                    id: page1_main_page
                    color: "transparent"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.top: parent.top
                    MonitorControl{
                        id: monitorControl
                    }
                    Rectangle
                    {
                        width: parent.width
                        height: parent.height
                        color: "transparent"

                        Signin {
                            id: signinPage
                            visible: false
                        }

                        Signup {
                            id: signupPage
                            visible: false
                        }

                        MainPage {
                            id: mainPage
                            visible: false
                        }

                        Inside_1{
                            id: inside_1
                            visible: false
                        }
                        Inside_2{
                            id: inside_2
                            visible: false
                        }
                        Monitor{
                            id: monitor
                            visible: false
                        }
                        ClubSelection {
                            id: clubSelection
                            visible: false
                        }
                        ManagerProfileGenerator {
                            id: managerProfileGenerator
                            visible: false
                        }
                        Club {
                            id: clubPage
                            visible: false
                        }
                        ManagerProfile{
                            id: managerProfile
                            visible: false
                        }
                        PlayerProfile{
                            id: playerProfile
                            visible: false
                        }
                        GoalkeeperProfile{
                            id: goalkeeperProfile
                            visible: false
                        }
                        Tactic{
                            id: tacticPage
                            visible: false
                        }
                        PlayerPosition {
                            id: positionPage
                            visible: false
                        }
                        Config{
                            id: configPage
                            visible: false
                        }
                        SearchingPool {
                            id: searchingPool
                            visible: false
                        }
                        KnowledgeSurvey {
                            id: knowledgeSurvey
                            visible: false
                        }
                        AntiOpponentTactic {
                            id: antiOpponentTactic
                            visible: false
                        }
                        PlayerNumber {
                            id: numberPage
                            visible: false
                        }
                        SubmitOffer {
                            id: submitOffer
                            visible: false
                        }
                        ViewOffer {
                            id: viewOffer
                            visible: false
                        }
                        SubmitContract {
                            id: submitContract
                            visible: false
                        }
                        Fixture {
                            id: fixturePage
                            visible: false
                        }
                        LeaguePage {
                            id: leaguePage
                            visible: false
                        }
                        NewsPage {
                            id: newsPage
                            visible: false
                        }
                        StatisticsPageLeft {
                            id: team_left_statistic_page
                            visible: false
                        }
                        StatisticsPageRight {
                            id: team_right_statistic_page
                            visible: false
                        }
                        CommentaryPage {
                            id: commentaryPage
                            visible: false
                        }
                    }
                }
            }

            Component.onCompleted: {
                stackView.clear()
                stackView.push(signinPage)
            }
        }

        MouseArea{
            cursorShape: Qt.PointingHandCursor
        }

        InformationBox {
            id: informationbox
            visible: false
            anchors.centerIn: parent

            title: "Information Box title"
            message: "Message info"

            onOk: {
                informationbox.visible = false
            }
        }

        ConfirmationBox {
            id: confirmingbox
            title: qsTr("Exit Game")
            question: qsTr("Are you sure exit the Game?!")

            anchors.centerIn: parent

            cancel_button_text: qsTr("Cancel")
            confirm_button_text: qsTr("Exit")

            onCancel_clicked: {
                confirmingbox.visible = false
            }

            onConfirm_clicked: {
                confirmingbox.visible = false
                myGlobalObject.saveSettings("GameSetting.ini")
                app.close()
            }
        }

        BusyIndicator {
            id: busyIndicator
            width: 100
            height: width
            anchors.centerIn: stackView
            running: false
        }

        Alerts {
            id: alerts
            anchors.bottom: stackView.top
            anchors.horizontalCenter: stackView.horizontalCenter
        }

        ConfirmationBox {
            id: withdrawofferbox
            title: qsTr("Withdraw Offer")
            question: qsTr("Withdraw Offer to player?!")

            anchors.centerIn: parent
            cancel_button_text: qsTr("Cancel")
            confirm_button_text: qsTr("Confirm")
            property int offerId: 0
            onCancel_clicked: {
                withdrawofferbox.visible = false
            }

            onConfirm_clicked: {
                withdrawofferbox.visible = false
                APIConnection.withdrawOffer(managerUser.token, offerId)
            }
        }

    }

    User {
        id: managerUser
    }

    Connections {
        target: APIConnection

        onErrorHappened: {
            app.busyIndicator.running = false
            alerts.show(error);
            if(stackView.__currentItem === signupPage)
                signupPage.enable_buttons(true);
            else if(stackView.__currentItem === signinPage)
                signinPage.enable_buttons(true);
        }

        onMessageReceived: {
            app.busyIndicator.running = false
            alerts.show(message, "green");
        }

        onSigninFinished: {
            app.busyIndicator.running = false
            managerUser.setUser(user);
            managerUser.printDetails();

            alerts.show(message, "green");
            stackView.clear();    //remove the signin page from the stack. so we wont return to it again

            if(0) {
                APIConnection.getClubDetails(managerUser.token, managerUser.clubId);

                //add club players. Call it twice to populate it. needx fixing later on
                APIConnection.getClubPlayers(managerUser.token, managerUser.clubId);
                APIConnection.getClubPlayers(managerUser.token, managerUser.clubId);
                APIConnection.getUsers(managerUser.token)
                APIConnection.getNews(managerUser.token, managerUser.id)
                getInvitationsTimer.running = true
                getNewsTimer.running = true

                callinsidepage2(clubPage)
            }
            else {
                callinsidepage2(mainPage);
            }
        }

        onSignupFinished: {
            app.busyIndicator.running = false
            alerts.show(message, "green");
            app_title_bar.popPage()
        }

        onGetClubDetailsFinished: {
            app.busyIndicator.running = false
            console.log("get club details finished...");
            managerUser.club = club;
            clubPage.setClub()

            console.log("club name: " + managerUser.club.name);
            console.log("foreground: " + managerUser.club.foreground1Value);
            console.log("background: " + managerUser.club.background1Value);
        }
    }
}
