/*
** Added by Ahmed Soliman
** For further information use the contact form at AhmedSoliman_1234@hotmail.com.
*/
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2
import QtQml 2.12

import com.Game.APIConnection 1.0
import com.Game.Player 1.0
import com.Game.SortFilterProxyModel 1.0

Rectangle
{
    function hideButtonsStartMatchOnClicked()
    {
        if(game_start.startTime == 0){
            game_start.startTime = new Date().getTime()
            game_start.currTime = new Date().getTime()
            innerTimer.start()
            game_start.button_text = "Prepared?";	//User can set tactics on the tactics center meanwhile

        }
        else if(game_start.currTime - game_start.startTime > 100){
            innerTimer.stop()
            game_start.startTime = 0
            game_start.currTime = 0
            if(!monitorControl.isConnected()){
                game_start.button_text = "Waiting for other team...";
                monitorControl.getMatchParams();
            }
            hideButtonsStartMatch();

        }
    }

    function hideButtonsStartMatchOnTimer()
    {
    game_start.currTime = new Date().getTime()
    game_start_timer.text = (0|(5000 - game_start.currTime + game_start.startTime)/1000) + " seconds to go..."
    if(game_start.currTime - game_start.startTime >= 5000){
        innerTimer.stop();
        if(!monitorControl.isConnected()){
            game_start.button_text = "Waiting match start...";
            monitorControl.getMatchParams();
            }
        hideButtonsStartMatch();
        }
    }

    function hideButtonsStartMatch()
    {
        game_start_timer.visible = false;
        if(monitorControl.isConnected())
        {
            game_start.visible = false;
        }
        start.start();
        timer.start();
        monitor_timer.start();
        game_info_timer.start();
        foul_card_timer.start();
    }

    Connections{
        target: monitorControl
        onTcpFullMessageReceived: {
            game_start.visible = false;
        }
    }

    FieldControl{
            id: fieldControl
        }
    PlayerControl{
            id: playerControl
    }/*
    MonitorControl{
            id: monitorControl
    }*/
    id: inside_1
    height: 800
    width: 600
    radius: 20
    property string titleBar: qsTr("Monitor")
    color: fieldControl.q_field_color
    property double coeff: 1

    //pitch
    Image
        {
            id: pitch
            source: "qrc:/icons/Pitch.png"
            //height:
            //anchors.fill: parent
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.Stretch
            MouseArea{
                cursorShape: Qt.PointingHandCursor
            }
        }

    //Start button
    ButtonMainPage
        {
            id: game_start
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            button_text: "Start"
            property double startTime: 0
            property double currTime: 0
            MouseArea
            {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton
                onClicked: {
                        hideButtonsStartMatchOnClicked();
                }
                onPressed: {parent.state="clicked"}
                onReleased: {parent.state="unclicked"}
            }
            Timer{
                id: innerTimer
                interval:16
                repeat: true
                running: false	//use date().gettime
                onTriggered:{
                    hideButtonsStartMatchOnTimer();
                }
            }
        }
    //game_start_timer
    Rectangle {
        id: game_start_timer
        width: parent.width/6;
        height: 35
        radius: 10
        color: "black"
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        property alias text: game_start_timer_text.text
        Text{
            id:game_start_timer_text
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            font.pointSize: 8; font.bold: true
            text: "Press Start"
        }
    }
    Rectangle
    {
        id: firstTeamScoreFigure
        anchors.right: parent.horizontalCenter
        anchors.rightMargin: 10
        anchors.top: parent.top
        height: 35
        radius: 10
        width: 150
        visible: false
        Text
        {
            id:firstTeamScoreFigureText
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            //color: "white"
            font.pointSize: 8; font.bold: true
            //text: "First team"
        }
    }
    Rectangle
    {
        id: secondTeamScoreFigure
        anchors.left: parent.horizontalCenter
        anchors.leftMargin: 10
        anchors.top: parent.top
        height: 35
        radius: 10
        width: 150
        visible: false
        Text
        {
            id: secondTeamScoreFigureText
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 8; font.bold: true
        }
    }
    //game_info
    Rectangle {
        id: game_info
        width: parent.width - 40;
        height: 30
        radius: 10
        color: "black"
        anchors.top: pitch.bottom
        anchors.horizontalCenter: pitch.horizontalCenter
        Text {
            id: game_info_text
            text: "Game info."
            color: "white"
            anchors.left: game_info.left
            anchors.leftMargin: 20
            anchors.verticalCenter: game_info.verticalCenter
            horizontalAlignment: Text.AlignCenter
            font.pointSize: 10; font.bold: true
        }
    }
    //foul_cards
    Rectangle{
        id:foul_card_box
        width:150
        height:20
        radius: 10
        anchors.bottom:	pitch.top
        anchors.right:	parent.right
        anchors.rightMargin: 10
        color: 'black'
        property alias foul_text: card_info_text.text
        property alias foul_color:foul_card.color
        Rectangle{
            id:foul_card
            width:14
            height: 14
            radius: 10
            anchors.left: foul_card_box.left
            anchors.leftMargin:4
            anchors.verticalCenter: foul_card_box.verticalCenter
            color: 'limegreen'
                }
        Text{
            id:card_info_text
            text: "Foul Card Display"
            anchors.left: foul_card.right
            anchors.leftMargin:4
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 6
            color: 'white'
            font.bold: true
            }
        Text{
            id:card_player_info_text
            text:""
            anchors.right: parent.right
            anchors.rightMargin:2
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 6
            color: 'white'
            font.bold: true
            }

    }

    //ball
    Rectangle{
        id: ball
        x: pitch.x + pitch.height / 2
        y: pitch.x + pitch.width / 2
        height: 5
        width: 5
        radius: 5
        color: fieldControl.m_ball_color
    }
    //players - right
    Row {
        anchors.right: parent.right
        anchors.rightMargin: 100
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 545
        anchors.top: parent.top
        anchors.topMargin: 35
        Repeater {
            id: players_right
            model: 11
            Rectangle{
                id: player
                width: 12
                height: 12
                radius: 12
                visible: true
                color: "black"
                z : parent.z + 100
                border.width: 0.3
                border.color: "white"
                property int rotate: 0
                Text {
                    id: player_number	//remove in final release
                    text: index % 11 + 1
                    color: "white"
                    anchors.bottom: parent.top
                    anchors.left: parent.right
                    // anchors.horizontalCenter: parent.horizontalCenter
                    // anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 7; font.bold: true
                }
                Rectangle{
                    z:parent.z +1
                    id: player_neck
                    width: parent.width  / 3
                    height: parent.height  / 3
                    color: parent.color
                    transform: Rotation { origin.x: 4; origin.y: 4; angle: player.rotate}
                    }
                /*MouseArea {
                    anchors.fill: parent
                    drag.target: player
                    drag.axis: Drag.XandYAxis
                    drag.minimumX: 0
                    //drag.maximumX: container.width - rect.width
                }*/
            }
        }
    }
    //players - left
    Row {
        anchors.right: parent.right
        anchors.rightMargin: 300
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 35
        anchors.left: parent.left
        anchors.leftMargin: 250
        Repeater {
            id: players_left
            model: 11
            Rectangle{
                id: player1
                width: 12
                height: 12
                radius: 12
                visible: true
                color: "black"
                z : parent.z + 100
                border.width: 0.3
                border.color: "white"
                property int rotate: 0
                Text {
                    id: player_number1
                    text: index % 11 + 1
                    color: "white"
                    anchors.bottom: parent.top
                    anchors.left: parent.right
                    // anchors.horizontalCenter: parent.horizontalCenter
                    // anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 7; font.bold: true
                }
                Rectangle{
                    z:parent.z +1
                    id: player_neck1
                    width: parent.width  / 3
                    height: parent.height / 3
                    color: parent.color
                    transform: Rotation { origin.x: 4; origin.y: 4; angle: player.rotate}
                }
                /*MouseArea {
                    anchors.fill: parent
                    drag.target: parent
                    drag.axis: Drag.XandYAxis
                    drag.minimumX: 0
                    drag.maximumX: pitch.width
                    drag.minimumY: 0
                    drag.maximumY: pitch.height
                    onPressed:{
                        monitor_timer.stop();

                    }
                    onReleased:{
                        monitor_timer.start();
                        sendPlayerMove(index);
                    }

                }*/
            }
        }
    }


        //Game info
        function getGameInfo()
        {
            return playerControl.getPitchInfo();
        }
        //Ball
        function getBallPoint()
        {
            return playerControl.getBallPoint();
        }
        //Player
        function getPlayerPoint(player_id)
        {
            //timer.start()
            return playerControl.getPlayerPoint(player_id);
        }
        //Player Move
        function sendPlayerMove(player_id)
        {
            return monitorControl.sendPlayerMove(player_id,players_left.itemAt(player_id).x - 7.5,players_left.itemAt(player_id).y+10,players_left.itemAt(player_id).rotate);
        }
        //Foul Card
        function getFoulCardInfo()
        {
            return playerControl.getFoulCardInfo();
        }
        function getFoulCardColor()
        {
            return playerControl.getFoulCardColor();
        }
        function getPlayerColor(player_id)
        {
            //timer.start()
            return playerControl.getPlayerColor(player_id);
        }
        function getPlayerNeckAngle(player_id)
        {
            return playerControl.getPlayerNeckAngle(player_id);
        }

        //Monitor
        function monitorStart()
        {
            monitorControl.monitorStart();
        }
        //Tactics
        function sendTacticCommand()
        {
            monitorControl.sendTactics(managerUser.clubName);
        }
        Timer {
            id: timer
            interval: 16
            running: false
            repeat: true

            onTriggered: {
                monitorControl.update();
            }
        }
        // function delay(delayTime, cb) {
        //     timer.interval = delayTime;
        //     timer.repeat = true;
        //     timer.triggered.connect(cb);
        //     timer.start();
        // }

        Timer {
            id: start
            repeat: true
            running: false
            interval: 2000

            onTriggered: {
                console.log("Monitor.qml.start timer triggered");
                if( !monitorControl.isConnected() )
                {
                    monitorControl.monitorStart();
                }
            }
        }
        Timer {
            id: game_info_timer
            interval: 15
            repeat: true
            running: false

            onTriggered: {
                game_info_text.text = getGameInfo();
            }
        }
        Timer {
            id: foul_card_timer
            interval: 15
            repeat: true
            running: false

            onTriggered: {
                foul_card_box.foul_text=getFoulCardInfo();
                foul_card_box.foul_color=(getFoulCardInfo().startsWith("Red")?'red':getFoulCardInfo().startsWith("Yellow")?'yellow':'limegreen');
            }
        }
        // function delay_game_info(delay_game_info, cb) {
        //     game_info_timer.interval = delay_game_info;
        //     game_info_timer.repeat = true;
        //     game_info_timer.triggered.connect(cb);
        //     game_info_timer.start();
        // }

        Timer {
            id: monitor_timer
            interval: 16
            repeat: true
            running: false

            onTriggered: {
                //score_card.left_team_color = getPlayerColor(0)
                //score_card.left_team_name = monitorControl.getLeftName()
                //score_card.left_team_score = monitorControl.getLeftScore()
                firstTeamScoreFigure.color = playerControl.getPlayerColor(1) !== null ? playerControl.getPlayerColor(1) : "transparent";
                secondTeamScoreFigure.color = playerControl.getPlayerColor(13) !== null ? playerControl.getPlayerColor(13) : "transparent";
                var firstText = "";
                firstTeamScoreFigure.visible = false;
                if( monitorControl.getRightName().trim().length > 0 )
                {
                    firstTeamScoreFigure.visible = true
                    firstText += monitorControl.getRightName();
                    if( monitorControl.getRightScore().trim().length > 0 )
                    {
                      firstText += ": ";
                      firstText +=  monitorControl.getRightScore();
                    }
                    else
                    {
                        firstText += ": 0";
                    }
                }
                firstTeamScoreFigureText.text = firstText;

                secondTeamScoreFigure.visible = false;
                var secondText = "";
                if( monitorControl.getLeftName().trim().length > 0 )
                {
                    secondTeamScoreFigure.visible = true;
                    secondText += monitorControl.getLeftName();
                    if( monitorControl.getLeftScore().trim().length > 0 )
                    {
                      secondText += ": ";
                      secondText +=  monitorControl.getLeftScore();
                    }
                    else
                    {
                        secondText += ": 0";
                    }
                }
                secondTeamScoreFigureText.text = secondText;

                for(var i = 0; i < players_left.model; i++)
                    {
                        players_left.itemAt(i).color = getPlayerColor(i)
                        players_left.itemAt(i).x = getPlayerPoint(i)[0] + 7.5 // HACK
                        players_left.itemAt(i).y = getPlayerPoint(i)[1] - 10
                        players_left.itemAt(i).rotate = getPlayerNeckAngle(i)
                        ball.x = getBallPoint()[0] + 263; //HACK
                        ball.y = getBallPoint()[1] + 4.5; //HACK
                    }
                //score_card.right_team_color = getPlayerColor(11)
                //score_card.right_team_name = monitorControl.getRightName()
                //score_card.right_team_score = monitorControl.getRightScore()
                for(var i = 0; i < players_right.model; i++)
                    {
                        players_right.itemAt(i).color = getPlayerColor(i+11)
                        players_right.itemAt(i).x = getPlayerPoint(i+11)[0] + 7.5-(pitch.width / 2) // HACK
                        players_right.itemAt(i).y = getPlayerPoint(i+11)[1] - 10
                        players_right.itemAt(i).rotate = getPlayerNeckAngle(i+11)
                        ball.x = getBallPoint()[0] + 263; //HACK
                        ball.y = getBallPoint()[1] + 4.5; //HACK
                    }
            }
        }
        // function delay_monitor(delay_monitor, cb) {
        //     monitor_timer.interval = delay_monitor;
        //     monitor_timer.repeat = true;
        //     monitor_timer.triggered.connect(cb);
        //     monitor_timer.start();
        // }
        // Component.onCompleted: {
        //     // delay_monitor(15, function(){
        //     //     monitorControl.update();
        //     // })

        //     // delay(16, function() {
        //     //         for(var i = 0; i < players.model; i++)
        //     //         {
        //     //             players.itemAt(i).color = getPlayerColor(i)
        //     //             players.itemAt(i).x = getPlayerPoint(i)[0] + 7.5 // HACK
        //     //             players.itemAt(i).y = getPlayerPoint(i)[1]
        //     //             players.itemAt(i).player.player_neck.rotation = getPlayerNeckAngle(i)
        //     //             ball.x = getBallPoint()[0] + 263;
        //     //             ball.y = getBallPoint()[1] + 3.5;
        //     //         }
        //     // })

        //     // delay_game_info(15, function(){
        //     //     game_info_text.text = getGameInfo();
        //     // })
        //     monitorControl.monitorStart();
        //     // if(!monitorControl.isConnected())
        //     // {
        //     //     monitorControl.monitorStart();
        //     // }
        // }
}



/*##^## Designer {
    D{i:10;anchors_height:30}D{i:12;anchors_height:20;anchors_width:300;anchors_x:292}
D{i:17;anchors_x:448;anchors_y:390}D{i:23;anchors_x:300;anchors_y:0}
}
 ##^##*/
