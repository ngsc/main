import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0
import QtQml 2.0
import com.Game.APIConnection 1.0
import com.Game.User 1.0
import com.Game.Announcement 1.0
import com.Game.Player 1.0

ApplicationWindow {
    id: app
    width: 1466
    height: 780
    property alias main_window: main_window
    property alias mainwindow: mainwindow
    property alias user: managerUser



    MainWindow{
        id: mainwindow
        //        Component.onCompleted: {
        //            mainwindow.getLangFiles();
        //            mainwindow.loadSettings("GameSetting.ini");
        //        }
    }

    visible: true

    //flags: Qt.FramelessWindowHint
    property string backgroundImage: "qrc:/images/background/1.jpg"

    property bool announcement_board_is_minim: false

    property bool clubDetailsforManager: false

    property bool takeControl: true

    property bool canResign: true

    property int value: 0

    property variant invetationId: [0,0,0]

    property alias busyIndicator: busyIndicator

    property bool is_additionalClicked: true

    property bool is_exitEntered: true

    property bool is_configEntered: true

    property bool is_retireEntered: true

    property bool is_resignEntered: true

    property list<Text> fonts: [
        Text {
            text: "Times"
        },
        //Text { text : "Serif"},Text { text : "Sans Serif"},
        Text {
            text: "Cursive"
        },
        Text {
            text: "Fantasy"
        },
        //Text { text : "Kristen ITC"},
        Text {
            text: "Comic Sans MS"
        },
        Text {
            text: "Monospace"
        },
        Text {
            text: "Agency FB"
        },
        Text {
            text: "Impact"
        },
        Text {
            text: "Script"
        },
        //Text { text : "Arial"},
        Text {
            text: "Courier"
        }
    ]

    function menuBarStatus() {
        console.log(managerUser.clubId, "managerUser.clubId")
        console.log(managerUser.quizPass, "managerUser.quizPass")

        if (managerUser.quizPass && (managerUser.clubId > 0)
                && (stackView.__currentItem != mainPage)) {
            console.log(true)
            return true
        } else {
            console.log(false)
            return false
        }
    }

    function callinsidepage2(pagename) {
        if (stackView.__currentItem !== pagename) {
            app_title_bar.pushProperties(app_title_bar.backwardTitleProperties)
            app_title_bar.reset()


            app_title_bar.title = pagename.titleBar
            stackView.push({
                               item: pagename,
                               properties: {
                                   objectName: pagename.toString()
                               }
                           })
            value = (Math.random() * 100) % 12
            backgroundImage= ("qrc:/images/background/%1.jpg").arg(value)
            //            console.log(pagename.titleBar)
        }
    }

    function delayTimer(delay, cb) {
        timer.interval = delay
        timer.repeat = false
        timer.triggered.connect(cb)
        timer.start()
    }

    function setTitleClubName(clubName) {
        app_title_bar.title = clubName
    }

    Timer {
        id: timer
    }

    Bullets{
        id: bullets
    }

    //    Timer {
    //        id: getInvitationsTimer
    //        interval: 1000
    //        running: true
    //        repeat: true
    //        triggeredOnStart: true
    //        onTriggered: {
    ////            APIConnection.getInvitations(managerUser.token, managerUser.id)
    //        }
    //    }

    Timer {
        id: getNewsTimer
        interval: 10000
        running: false
        repeat: true
        triggeredOnStart: true
        property int time: 0
        onTriggered: {

            if(!canResign && time === 3){
                time = 0;
                invetationId = fixturePage.invitationModel.cancelAllInvetation()
                for(var i = 0 ; i < invetationId.length ; i++ ){
                    console.log(invetationId[i])
                    APIConnection.declineInvitation(managerUser.token,invetationId[i])
                }
            }
            time++;
            APIConnection.getNews(managerUser.token, managerUser.id)
            APIConnection.getPublicNews(managerUser.token)
            APIConnection.getInvitations(managerUser.token, managerUser.id)

        }
    }

    Timer {
        id: getAnnouncementTimer
        interval: 30000 //10000
        running: false
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            APIConnection.getAnnouncement(managerUser.token)
            APIConnection.getBulletText(managerUser.token)
        }
    }

    Timer {
        id: getcurrentTimer
        interval: 10000
        running: false
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            APIConnection.getGameClock(managerUser.token)
            //            timeText.text = Qt.formatTime(new Date(),"h:m:s ap") + "\n"+Qt.formatDate(new Date(),"ddd d MMMM yyyy")
        }
    }

    Rectangle {
        id: main_window
        anchors.fill: parent
        color: "transparent"
        radius: 10
        z: parent.z + 1
        //visible: false
        Image {
            id: backgound_image
            source: backgroundImage
            anchors.fill: parent
            fillMode: Image.Stretch
        }

        Rectangle {
            id: background_cover
            anchors.fill: parent
            color: "#34537a"
            opacity: 0.7
        }

        Rectangle{
            id: timeRect
            width: 120
            height: 80
            //            color: "black"
            gradient: Gradient {
                GradientStop { position: 0.0; color: Qt.lighter("#34537a")}
                GradientStop { position: 1.0; color: "#34537a"}
            }
            //            border.color: "#ffd700"
            //            border.width: 4
            radius: 30
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            Text {
                id: timeText
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 5
                anchors.leftMargin: 5
                anchors.topMargin: 5
                anchors.rightMargin: 5
                //                font.bold: true
                //                font.italic: true
                font.pointSize: 9
                //                font.pixelSize: Theme.fontSizeHuge * 2.0
                color: "#ffaa00"//"#ffd700"//Qt.tint("lightsteelblue", "#10FF0000")//"blue"
                property string dateTimeString:"--:--:--"+"\n"+"--- -- ----"+"\n"+"----" //Qt.formatTime(new Date(),"hh:mm:ss ap")+"\n" +Qt.formatDate(new Date(),"ddd d MMMM")+"\n"+Qt.formatDate(new Date(),"yyyy")
                text: qsTr(dateTimeString)//Date.fromLocaleString(Qt.locale(), Qt.formatTime(new Date(),"hh:mm:ss"), "hh:mm:ss") + "\n"+Qt.formatDate(new Date(),"ddd d MMMM yyyy")//Qt.formatTime(new Date(),"ddd yyyy-MM-dd hh:mm:ss")
            }
        }

        TitleBar {
            id: app_title_bar
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: timeRect.right
            anchors.leftMargin: 10
        }

        MenuButton {
            id: playerActions
            anchors.left: panel_5_compr_buttons.left
            anchors.top: flowing_comment_field.top
            height: flowing_comment_field.height
            visible: stackView.__currentItem === playerProfile
                     || stackView.__currentItem === goalkeeperProfile
            width: 100
        }

        Rectangle {
            id: flowing_comment_field
            color: "transparent" //"#6d6b79"
            radius: width / 2
            opacity: 0.5
            //anchors.left: main_window.left
            //anchors.leftMargin: 200
            anchors.horizontalCenter: bullet_comment.horizontalCenter
            anchors.top: app_title_bar.bottom
            anchors.topMargin: 30
            width: 600
            height: 40
            visible: stackView.__currentItem !== signinPage
                     && stackView.__currentItem !== signupPage
            MouseArea {
                cursorShape: Qt.PointingHandCursor
            }
            Rectangle {
                color: "#ffffff"
                anchors.fill: parent
                radius: parent.radius
                opacity: 0.5
            }
            clip: true
            //            TextField {
            Text{
                id: flowing_comment_field_text
                width: parent.width
                //                anchors.top: parent.top
                //                anchors.bottom: parent.bottom
                font.family: "Comic Sans MS" //"Kristen ITC" "Times"
                font.pointSize: 14
                color: "black"
                //                activeFocusOnPress: false
                text : ""
                verticalAlignment: Text.AlignVCenter;
                anchors.verticalCenter: parent.verticalCenter
                //                style: TextFieldStyle {
                //                    //                    textColor: "#ffffff"
                //                    background: Rectangle {
                //                        radius: flowing_comment_field.radius
                //                        color: "transparent"
                //                    }
                //                }

                Timer {
                    id: nameSliderTimer
                    interval: intervalTime
                    property int intervalTime : 10000
                    property bool status: false
                    //                    running: true
                    repeat: true
                    onTriggered: {
                        if (status === true) {
                            status = false
                            xx.start()
                            yy.stop()
                            //                            console.log("XX started")
                            newsflashanimation.running = true //just for test
                        } else {
                            status = true
                            xx.stop()
                            yy.start()
                            //                            console.log("YY started")
                            newsflashanimation.running = false //just for test
                        }
                    }
                }

                NumberAnimation on x {
                    id: xx
                    running: true
                    from: -t_metrics.tightBoundingRect.width
                    to: t_metrics.tightBoundingRect.width
                    duration: nameSliderTimer.intervalTime
                    loops: Animation.Infinite
                }
                NumberAnimation on x {
                    id: yy
                    running: false
                    from: t_metrics.tightBoundingRect.width
                    to: -t_metrics.tightBoundingRect.width
                    duration: nameSliderTimer.intervalTime
                    loops: Animation.Infinite
                }
            }
            TextMetrics {
                id:     t_metrics
                font:   flowing_comment_field_text.font
                text:   qsTr(flowing_comment_field_text.text)
            }
        }

        AnnouncementBoard {
            id: annonucement_board
            anchors.top: app_title_bar.top
            anchors.topMargin: 1
            anchors.right: main_window.right
            anchors.rightMargin: 5

            height: announcement_board_is_minim
                    == true ? 0 : parent.height - app_title_bar.height - 10 + 40
            visible: stackView.__currentItem !== signinPage
                     && stackView.__currentItem !== signupPage
        }

        Rectangle {
            id: panel_5_compr_buttons
            anchors.bottom: parent.bottom
            anchors.margins: 10
            anchors.left: app_title_bar.left
            anchors.right: app_title_bar.right
            height: 70
            z:10
            color: "transparent"
            visible: stackView.__currentItem !== signinPage
                     && stackView.__currentItem !== signupPage
            MouseArea {
                cursorShape: Qt.PointingHandCursor
            }
            Panel5Button {
                id: button_1
                anchors.top: parent.top
                anchors.left: parent.left
                button_text: qsTr("Manager's HQ")
                width: 180
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: {
                        //console.log(stackView.__currentItem.objectName.toString())
                        console.log(managerUser.firstName)
                        console.log(managerUser.lastName)
                        console.log(app_title_bar.selectedportrail)
                        if (menuBarStatus()) {
                            //stackView.__currentItem.objectName.toString()!="ManagerProfile.qml" &&
                            if ((managerUser.firstName !== "")
                                    && (managerUser.lastName != "")
                                    && (managerUser.userPortrait != "")) {
                                callinsidepage2(managerProfile)
                                app.clubDetailsforManager = true
                                APIConnection.getClubDetails(managerUser.token,
                                                             managerUser.clubId)
                                APIConnection.getUserComment(managerUser.token, managerUser.id)
                                managerProfile.setUser()
                            }
                        }
                    }
                    onEntered: {
                        button_1.button_bottom_line_visibility = true
                    }
                    onExited: {
                        button_1.button_bottom_line_visibility = false
                    }
                }
            }
            Panel5Button
            {
                id: button_15
                anchors.bottom: button_1.top
                anchors.left: parent.left
                button_text: "2D View"
                width: 180
                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed:  {
                        callinsidepage2(monitor)
                    }
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
            Panel5Button
            {
                id: button_16
                anchors.bottom: parent.top
                anchors.left: button_15.right
                button_text: "Left Side Statistics"
                width: 180
                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed:  {
                        button_16.button_text = monitorControl.getLeftName() + " Statistics";
                        team_left_statistic_page.titleBar = monitorControl.getLeftName() + " Statistics";
                        team_left_statistic_page.text= monitorControl.getTeamLeftStats();
                        callinsidepage2(team_left_statistic_page)
                    }
                    onEntered:
                    {
                        button_16.button_bottom_line_visibility=true
                    }
                    onExited:
                    {
                        button_16.button_bottom_line_visibility=false
                    }
                }
            }
            Panel5Button
            {
                id: button_17
                anchors.bottom: parent.top
                anchors.left: button_16.right
                button_text: "Right Side Statistics"
                width: 180
                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed:  {
                        button_17.button_text = monitorControl.getRightName() + " Statistics";
                        team_right_statistic_page.titleBar = monitorControl.getRightName() + " Statistics";
                        team_right_statistic_page.text= monitorControl.getTeamRightStats();
                        callinsidepage2(team_right_statistic_page)
                    }
                    onEntered:
                    {
                        button_17.button_bottom_line_visibility=true
                    }
                    onExited:
                    {
                        button_17.button_bottom_line_visibility=false
                    }
                }
            }
            Panel5Button {
                id: button_11
                anchors.bottom: button_12.top
                anchors.left: button_18.right
                button_text:qsTr("Retire")// Qt.binding(function() { return qsTrId("Retire") + localization.updateLanguage;})//qsTr("Retire") +//localization.updateLanguage//+ app.trTrigger
                visible: false
                width: 180
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: {

                    }
                    onClicked: {
                        if (menuBarStatus()) {
                            retireConfirmationBox.visible = true
                            //                            APIConnection.sendRetire(managerUser.token)
                            //                            callinsidepage2(mainPage)
                        }
                    }
                    onEntered: {
                        button_11.button_bottom_line_visibility = true
                    }
                    onExited: {
                        button_11.button_bottom_line_visibility = false
//                        if(menuBarStatus()){
//                            button_11.visible = false;
//                        }
                    }
                }
            }
            Panel5Button {
                id: button_12
                anchors.bottom: parent.top
                anchors.left: button_18.right
                button_text: qsTr("Resign")
                width: 180
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: {

                    }
                    onClicked: {
                        if (menuBarStatus()) {
                            if(canResign){
                                resignConfirmationBox.visible = true
                            }else{
                                alerts.show("You have Friend Invetation", "red")
                            }
                            //                            takeControl = true
                            //                            callinsidepage2(clubSelection)
                            //                            clubSelection.loadLeagueClubs(406);     //load league B (club id: 406 belongs to league B)
                            //                            clubSelection.loadLeagueClubs(406);
                            //                            app_title_bar.setforwordvisibility = false
                            //                            APIConnection.sendResign(managerUser.token)

                        }
                    }
                    onEntered: {
                        //                        console.log(stackView.__currentItem.objectName.toString())
                        button_12.button_bottom_line_visibility = true
                        button_11.visible = true

                    }
                    onExited: {
                        button_12.button_bottom_line_visibility = false

                        //if(!menuBarStatus()){
                            button_11.visible = false
                        //}
                    }
                }
            }


            Panel5Button {
                id: button_2
                anchors.top: parent.top
                anchors.left: button_1.right
                button_text: qsTr("Squad")
                width: 180
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: {

                    }
                    onEntered: {
                        button_2.button_bottom_line_visibility = true
                    }
                    onExited: {
                        button_2.button_bottom_line_visibility = false
                    }
                    onClicked: {
                        if (managerUser.clubId === 0 && !menuBarStatus()) {
                            console.log("First select a club before going to squad page...")
                            return
                        }

                        app.clubDetailsforManager = false
                        APIConnection.getClubDetails(managerUser.token,
                                                     managerUser.clubId)
                        clubPage.loadClubPlayers(managerUser.clubId)
                        //                        clubPage.loadClubPlayers(managerUser.clubId)
                        //add club players. Call it twice to populate it. needx fixing later on
                        //                        APIConnection.getClubPlayers(managerUser.token, managerUser.clubId);
                        //                        APIConnection.getClubPlayers(managerUser.token, managerUser.clubId);
                        //                        APIConnection.getClubPlayers(managerUser.token, managerUser.clubId);
                        //                        APIConnection.getUsers(managerUser.token)
                        //                        APIConnection.getNews(managerUser.token, managerUser.id)
                        setTitleClubName(managerUser.clubName)
                        //                        getInvitationsTimer.running = true
                        //                        getNewsTimer.running = true
                        callinsidepage2(clubPage)
                        clubPage.setClub()
                    }
                }
            }
            Panel5Button {
                id: button_3
                anchors.top: parent.top
                anchors.left: button_2.right
                button_text: qsTr("Tactics Center")
                width: 180
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: {

                    }
                    onEntered: {
                        button_3.button_bottom_line_visibility = true
                    }
                    onExited: {
                        button_3.button_bottom_line_visibility = false
                    }
                    onClicked: {
                        if (menuBarStatus()) {
                            callinsidepage2(tacticPage)
                            tacticPage.setPlayers(clubPage.pModel.players())

                            //                            console.log("First select a club before going to tactis page...");
                            //                            return;
                        }
                    }
                }
            }
            Panel5Button {
                id: button_4
                anchors.top: parent.top
                anchors.left: button_3.right
                button_text: qsTr("Finance")
                width: 180
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: {

                    }
                    onClicked: {
                        if (menuBarStatus()) {

                        }
                    }
                    onEntered: {
                        button_4.button_bottom_line_visibility = true
                    }
                    onExited: {
                        button_4.button_bottom_line_visibility = false
                    }
                }
            }
            Panel5Button {
                id: button_5
                anchors.top: button_10.bottom
                anchors.left: button_4.right
                button_text: qsTr("News")
                width: 180
                Rectangle {
                    id: flash
                    //                    anchors.top: parent.top
                    //                    anchors.right: parent.right
                    //                    anchors.left: parent.left
                    //                    height: 3
                    anchors.fill: parent

                    color: "transparent"
                    border.color: "transparent"
                    //                    border.width: 3
                    SequentialAnimation {
                        id: newsflashanimation
                        loops: Animation.Infinite
                        alwaysRunToEnd: true
                        //                        running: true
                        //running: stackView.__currentItem !== newsPage && newsPage.newsModel.count !== newsPage.newsCount
                        ColorAnimation {
                            target: flash
                            property: "border.color"
                            from: "transparent"
                            to: "red"
                            duration: 900
                            easing.type: Easing.OutQuad
                        }
                        ColorAnimation {
                            target: flash
                            property: "border.color"
                            from: "red"
                            to: "red"
                            duration: 600
                        }
                        ColorAnimation {
                            target: flash
                            property: "border.color"
                            from: "red"
                            to: "transparent"
                            duration: 900
                            easing.type: Easing.InQuad
                        }
                        ColorAnimation {
                            target: flash
                            property: "border.color"
                            from: "transparent"
                            to: "transparent"
                            duration: 1000
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: {

                    }
                    onEntered: {
                        button_5.button_bottom_line_visibility = true
                    }
                    onExited: {
                        button_5.button_bottom_line_visibility = false
                    }
                    onClicked: {
                        if (menuBarStatus()) {
                            callinsidepage2(newsPage)
                        }
                    }
                }
            }
            Panel5Button {
                id: button_6
                anchors.top: button_1.bottom
                anchors.left: parent.left
                button_text: qsTr("Next Opponent")
                width: 180
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: {

                    }
                    onClicked: {
                        if (menuBarStatus()) {

                        }
                    }
                    onEntered: {
                        button_6.button_bottom_line_visibility = true
                    }
                    onExited: {
                        button_6.button_bottom_line_visibility = false
                    }
                }
            }
            Panel5Button {
                id: button_7
                anchors.top: button_2.bottom
                anchors.left: button_1.right
                button_text: qsTr("Fixture")
                width: 180
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: {

                    }
                    onEntered: {
                        button_7.button_bottom_line_visibility = true
                    }
                    onExited: {
                        button_7.button_bottom_line_visibility = false
                    }

                    onClicked: {
                        if (menuBarStatus()) {
                            callinsidepage2(fixturePage)
                            fixturePage.loadFixtures()
                            fixturePage.loadFixtures()
                        }
                    }
                }
            }
            Panel5Button {
                id: button_8
                anchors.top: button_3.bottom
                anchors.left: button_2.right
                button_text: qsTr("Searching Pool")
                width: 180
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: {

                    }
                    onEntered: {
                        button_8.button_bottom_line_visibility = true
                    }
                    onExited: {
                        button_8.button_bottom_line_visibility = false
                    }

                    onClicked: {
                        if (menuBarStatus()) {
                            callinsidepage2(searchingPool)
                            searchingPool.loadAllPlayers()
                        }
                    }
                }
            }
            Panel5Button {
                id: button_9
                anchors.top: button_4.bottom
                anchors.left: button_3.right
                button_text:qsTr( "Current League")
                width: 180
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: {

                    }
                    onEntered: {
                        button_9.button_bottom_line_visibility = true
                    }
                    onExited: {
                        button_9.button_bottom_line_visibility = false
                    }
                    onClicked: {
                        if (menuBarStatus()) {
                            callinsidepage2(leaguePage)
                            leaguePage.loadLeagueClubs(managerUser.clubId)
                            leaguePage.loadLeagueClubs(managerUser.clubId)
                        }
                    }
                }
            }
            Panel5Button
            {
                id: button_10
                anchors.top: parent.top
                anchors.left: button_4.right
                button_text: "Commentary Report"
                width: 180
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
                        button_10.button_bottom_line_visibility=true
                    }
                    onExited:
                    {
                        button_10.button_bottom_line_visibility=false
                    }
                }
            }
            Panel5Button {
                id: button_18
                anchors.bottom: parent.top
                anchors.left: button_17.right
                width: 180
                button_text: qsTr("Additional")

                //                property bool clickstatus: false
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: {

                    }
                    onClicked: {

                    }
                    onEntered: {
                        is_additionalClicked = true
                        if (is_additionalClicked) {
                            is_additionalClicked = false
                            button_13.visible = true
                            button_14.visible = true
                        }
                        else{
                            is_additionalClicked = true
                            button_13.visible = false
                            button_14.visible = false
                        }

                        button_18.button_bottom_line_visibility = true
                    }
                    onExited: {
                        if(!menuBarStatus()){
                            button_13.visible = false
                            button_14.visible = false
                        }
                        button_18.button_bottom_line_visibility = false
                    }
                }
            }
            Panel5Button {
                id: button_13
                anchors.bottom: button_18.top
                anchors.right: button_18.right
                button_text: qsTr("Exit")
                width: 180
                visible: false
                z:11

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: {

                    }
                    onClicked: {
                        if (menuBarStatus()) {
                            confirmingbox.visible = true
                        }
                    }
                    onEntered: {
                        if (menuBarStatus()) {
                            is_exitEntered = true
                            button_13.visible = true
                            button_14.visible = true
                        }
                        button_13.button_bottom_line_visibility = true
                    }
                    onExited: {
                        if (menuBarStatus()) {
                            is_exitEntered = false;
                            if(!is_configEntered){
                                button_13.visible = false
                                button_14.visible = false
                            }
                        }
                        button_13.button_bottom_line_visibility = false
                    }
                }
            }
            Panel5Button {
                id: button_14
                anchors.bottom: button_13.top
                anchors.right: button_18.right
                button_text: qsTr("Config")
                width: 180
                visible: false
                z:11

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: {

                    }
                    onClicked: {
                        if (menuBarStatus()) {
                            callinsidepage2(configPage)
                        }
                    }
                    onEntered: {
                        if (menuBarStatus()) {
                            is_configEntered = true
                            button_13.visible = true
                            button_14.visible = true
                        }
                        button_14.button_bottom_line_visibility = true
                    }
                    onExited: {
                        if (menuBarStatus()) {
                            is_configEntered = false;
                            if(!is_exitEntered){
                                button_13.visible = false
                                button_14.visible = false
                            }
                        }
                        button_14.button_bottom_line_visibility = false
                    }
                }
            }
        }

        Rectangle {
            id: bullet_comment
            anchors.horizontalCenter: app_title_bar.horizontalCenter
            anchors.bottom: panel_5_compr_buttons.top
            anchors.bottomMargin: 40
            width: 600
            height: 40
            z:3
            color: "transparent"
            radius: width / 2
            visible: stackView.__currentItem !== signinPage
                     && stackView.__currentItem !== signupPage
            MouseArea {
                cursorShape: Qt.PointingHandCursor
            }
            Rectangle {
                border.color: "#fdc807"
                border.width: 3
                anchors.fill: parent
                color: "#34537a"
                opacity: 0.7
                z : parent.z
                radius: parent.radius
            }
            TextField {
                id: bullet_comment_field_text
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                activeFocusOnPress: true
                width: parent.width - 35
                font.family: "Comic Sans MS"
                font.pointSize: 12
                focus: true
                z : parent.z
                style: TextFieldStyle {
                    textColor: "#ffffff"
                    background: Rectangle {
                        //border.color: "#fdc807"
                        //border.width: 3
                        //radius: width/2
                        color: "transparent"
                    }
                }

                Keys.onReturnPressed: {
                    flowing_comment_field_text.text = bullet_comment_field_text.text
                }
            }
            Keys.onPressed: {
                if (event.key === Qt.Key_Enter) {
                    APIConnection.createBullet(managerUser.token,
                                               managerUser.id,
                                               bullet_comment_field_text.text)

                    //                    flowing_comment_field_text.text=bullet_comment_field_text.text;
                    //                    flowing_comment_field_text.font.pointSize = (Math.random()*90)%20
                    //                    if(nameSliderTimer.running===false)
                    //                        nameSliderTimer.start();
                }
            }
            Image {
                id: send_icon
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height - 15
                width: height
                fillMode: Image.Stretch
                source: "qrc:/icons/arrow-blue.png"

                property int fontIndex: (Math.random() * 95) % 5
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onClicked: {
                        APIConnection.createBullet(managerUser.token, managerUser.id,bullet_comment_field_text.text)
                        APIConnection.getBulletText(managerUser.token);

                        //                        flowing_comment_field_text.text=bullet_comment_field_text.text;
                        //                        //                        flowing_comment_field_text.font.pointSize = (Math.random()*90)%20
                        //                        flowing_comment_field_text.textColor = Qt.rgba((Math.random()*95)%2,(Math.random()*95)%2,(Math.random()*95)%2)
                        //                        flowing_comment_field_text.font.family = fonts[send_icon.fontIndex].text
                        ////                        console.log(send_icon.fontIndex)
                        //                        send_icon.fontIndex++;
                        //                        if(send_icon.fontIndex > 8){
                        //                            send_icon.fontIndex = 0;
                        //                        }
                        ////                        console.log(flowing_comment_field_text.font.pointSize)
                        //                        if(nameSliderTimer.running===false)
                        //                            nameSliderTimer.start();
                    }
                }
            }
        }

        StackView {
            id: stackView
            //            anchors.left: panel_5_compr_buttons.left
            //            anchors.right: panel_5_compr_buttons.right
            x: panel_5_compr_buttons.x - 60
            width: panel_5_compr_buttons.width + 80
            anchors.top: flowing_comment_field.bottom
            anchors.topMargin: 10
            anchors.bottom: bullet_comment.top
            anchors.bottomMargin: 20
            clip: true
            // Implements back key navigation
            focus: true
            Keys.onReleased: if (event.key === Qt.Key_Back
                                     && stackView.depth > 1) {
                                 app_title_bar.popPage()
                                 event.accepted = true
                             }

            delegate: StackViewDelegate {

                ///added by Ahmed
                function getTransition(properties) {
                    return (properties.enterItem.Stack.index
                            % 2) ? horizontalTransition : verticalTransition
                }

                function transitionFinished(properties) {
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

                Rectangle {
                    id: page1_main_page
                    color: "transparent"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.top: parent.top
                    MonitorControl{
                        id: monitorControl
                    }
                    Rectangle {
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

                        Inside_1 {
                            id: inside_1
                            visible: false
                        }
                        Inside_2 {
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
                        ManagerProfile {
                            id: managerProfile
                            visible: false
                        }
                        PlayerProfile {
                            id: playerProfile
                            visible: false
                        }
                        GoalkeeperProfile {
                            id: goalkeeperProfile
                            visible: false
                        }
                        Tactic {
                            id: tacticPage
                            visible: false
                        }
                        PlayerPosition {
                            id: positionPage
                            visible: false
                        }
                        Config {
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
                        DirectSign{
                            id : directSign
                            visible: false
                        }
                        OfferToClub{
                            id : offerToClubPage
                            visible: false
                        }
                    }
                }
            }

            Component.onCompleted: {
                stackView.clear()
                stackView.push(mainPage) //signinPage
            }
        }

        MouseArea {
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
                //mainwindow.//saveSettings("GameSetting.ini")
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

        ConfirmationBox {
            id: resignConfirmationBox
            anchors.centerIn: parent
            confirm_button_text: qsTr("Confirm")
            cancel_button_text: qsTr("Cancel")
            title: qsTr("Resign")
            question: qsTr("Are you sure you want to Resign ?")

            onConfirm_clicked: {
                visible = false
                app.busyIndicator.running = true

                takeControl = true
                managerUser.clubId = 0
                managerUser.clubName = ""
                APIConnection.sendResign(managerUser.token, managerUser.id)
                callinsidepage2(clubSelection)
                clubSelection.loadLeagueClubs(
                            406) //load league B (club id: 406 belongs to league B)
                clubSelection.loadLeagueClubs(406)
                app_title_bar.setforwordvisibility = false
                app_title_bar.reset()
            }

            onCancel_clicked: {
                visible = false
            }
        }

        ConfirmationBox {
            id: retireConfirmationBox
            anchors.centerIn: parent
            confirm_button_text: qsTr("Confirm")
            cancel_button_text: qsTr("Cancel")
            title: qsTr("Retire")
            question: qsTr("Are you sure you want to Retire ?")

            onConfirm_clicked: {
                visible = false
                app.busyIndicator.running = true
                APIConnection.sendRetire(managerUser.token, managerUser.id)
                callinsidepage2(mainPage)
            }

            onCancel_clicked: {
                visible = false
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
            alerts.show(error)
            if (stackView.__currentItem === signupPage)
                signupPage.enable_buttons(true)
            else if (stackView.__currentItem === signinPage)
                signinPage.enable_buttons(true)
        }

        onMessageReceived: {
            app.busyIndicator.running = false
            alerts.show(message, "green")
        }

        onSigninFinished: {

            app.busyIndicator.running = false
            managerUser.setUser(user)
            managerUser.printDetails()
            managerProfile.setUser()
            fixturePage.invitationModel.setHomeClubId(managerUser.clubId)
            //            getInvitationsTimer.running = true
            getAnnouncementTimer.running = true
            getNewsTimer.running = true
            getcurrentTimer.running = true
            fixturePage.getUsersTimer.running = true

            //                        app.clubDetailsforManager = true
            //                        APIConnection.getClubDetails(managerUser.token, managerUser.clubId);
            //            APIConnection.updateUserOnlineStatus(managerUser.token,managerUser.firstName+" "+managerUser.lastName);
            alerts.show(message, "green")
            stackView.clear() //remove the signin page from the stack. so we wont return to it again

            mainPage.setButtonEnable(false)

            callinsidepage2(inside_2)
        }

        onSignupFinished: {
            app.busyIndicator.running = false
            alerts.show(message, "green")
            app_title_bar.popPage()
            callinsidepage2(signinPage)
        }

        onGetClubDetailsFinished: {
            app.busyIndicator.running = false
            console.log("get club details finished...")
            managerUser.club = club

            if (clubDetailsforManager) {
                clubPage.setclubDetailsforManager()
            } else {
                clubPage.setClub()
            }

            //            if(clubDetailsforManager===0){
            //                clubPage.setClub()
            //            }else if(clubDetailsforManager===1){
            //                clubPage.setclubDetailsforManager()
            //            }else if(clubDetailsforManager===2){

            //            }
            app_title_bar.selectedclubportrait = "file:///" + applicationPath
                    + "../images/clubs/normal/" + managerUser.club.id + ".png"

            console.log("club name: " + managerUser.club.name)
            console.log("foreground: " + managerUser.club.foreground1Value)
            console.log("background: " + managerUser.club.background1Value)
        }

        onGetUserStatus: {


            //(UserName,Status)
        }

        onGetUserSignInStatus: {

        }

        onGetBulletText: {
            flowing_comment_field_text.text = bullet_comment_field_text.text
            //                        flowing_comment_field_text.font.pointSize = (Math.random()*90)%20
            flowing_comment_field_text.textColor = Qt.rgba((Math.random() * 95) % 2, (Math.random() * 95) % 2, (Math.random(
                                                                                                                    ) * 95) % 2)
            flowing_comment_field_text.font.family = fonts[send_icon.fontIndex].text
            //                        console.log(send_icon.fontIndex)
            send_icon.fontIndex++
            if (send_icon.fontIndex > 8) {
                send_icon.fontIndex = 0
            }
            //                        console.log(flowing_comment_field_text.font.pointSize)
            if (nameSliderTimer.running === false)
                nameSliderTimer.start()
        }

        onGetPlayerCommentFinished :{

            if(stackView.__currentItem === goalkeeperProfile){
                goalkeeperProfile.playerCommentBoard.annoncementRect.setcommentRectHeight()//.setcommentRectHeight()
                goalkeeperProfile.playerCommentmodel.setplayerComment(playecomment)
                //                goalkeeperProfile.playerCommentBoard.isUser = false
            }else if(stackView.__currentItem === playerProfile){
                playerProfile.playerCommentBoard.annoncementRect.setcommentRectHeight()
                playerProfile.playerCommentmodel.setplayerComment(playecomment)
                //                playerProfile.playerCommentBoard.isUser = false
            }else{

            }

        }

        onGetGameClockFinished :{
            timeText.text = Qt.formatTime(dateTime,"hh:mm:ss ap")+"\n" +Qt.formatDate(dateTime,"ddd d MMMM")+"\n"+Qt.formatDate(dateTime,"yyyy")

            playerProfile.gameClockDate = dateTime
            //            if(playerProfile.player){
            //                playerProfile.player.setGameClock(dateTime)
            //            }
            goalkeeperProfile.gameClockDate = dateTime
            //            if(goalkeeperProfile.player){
            //                goalkeeperProfile.player.setGameClock(dateTime)
            //            }
            //playerProfile.player.setGameClock(dateTime)
            //            goalkeeperProfile.player.setGameClock(dateTime)
        }

        onGetBulletTexFinished:{
            bullets.setBulletText(bulletText)
            nameSliderTimer.stop()
            nameSliderTimer.intervalTime = bullets.getbulletTextSize > 70 ? 10000 : bullets.getbulletTextSize * 110
            nameSliderTimer.start()

            flowing_comment_field_text.text=bullets.getbulletText
            t_metrics.text = bullets.getbulletText
            flowing_comment_field_text.color = Qt.rgba((Math.random()*95)%2,(Math.random()*95)%2,(Math.random()*95)%2)
            flowing_comment_field_text.font.family = fonts[send_icon.fontIndex].text
            send_icon.fontIndex++;
            if(send_icon.fontIndex > 8){
                send_icon.fontIndex = 0;
            }
            if(nameSliderTimer.running===false)
                nameSliderTimer.start();
        }
    }

    onClosing : {
        //        console.log("closing test")
    }
}
