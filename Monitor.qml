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
import Constants 1.0

Rectangle
{
    function hideButtonsStartMatchOnClicked(startServer)
    {
        if(game_start.startTime == 0){
            game_start.startTime = new Date().getTime()
            game_start.currTime = new Date().getTime()
            innerTimer.start()
            game_start.button_text = "Prepared?";	//User can set tactics on the tactics center meanwhile
            if(startServer)
            {
                monitorControl.startMatchServerCmd( managerUser.token, 23292170, 406 )
            }

        }
        else if(game_start.currTime - game_start.startTime > 100){
            innerTimer.stop()
            game_start.startTime = 0
            game_start.currTime = 0
            if(!monitorControl.isConnected()){
                game_start.button_text = "      Waiting match start\nChestnut proudly presents\n       Work in progress";
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
            game_start.button_text = "      Waiting match start\nChestnut proudly presents\n       Work in progress";
            monitorControl.getMatchParams();
            }
        hideButtonsStartMatch();
        }
    }

    function hideButtonsStartMatch()
    {
        game_start_timer.visible = false;
        if(monitorControl.isConnected()){
            game_start.visible = false;
        }
        else{
            game_start.enabled = false;
        }

        start.start();
    }

    Connections{
        target: monitorControl
        onConnectedChanged: {
            if(monitorControl.connected)
                game_start.visible = false;
        }
    }

    Connections{
        target: monitorControl
        onRightTeamNameChanged: {
            monitorControl.requestLiveMatchClubsDetails(user.token, monitorControl.leftTeamName, monitorControl.rightTeamName);
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
            width: 300
//            height: 150
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
                        hideButtonsStartMatchOnClicked(true);
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
            text: monitorControl.pitchInfo
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
        Rectangle{
            id:foul_card
            width:14
            height: 14
            radius: 10
            anchors.left: foul_card_box.left
            anchors.leftMargin:4
            anchors.verticalCenter: foul_card_box.verticalCenter
            color: monitorControl.foulCardInfo.startsWith("Red") ? 'red' : monitorControl.foulCardInfo.startsWith("Yellow") ? 'yellow' : 'limegreen'
                }
        Text{
            id:card_info_text
            text: monitorControl.foulCardInfo
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
        x: monitorControl.ballPosition.x === -1 ? pitch.x + pitch.height / 2 : monitorControl.ballPosition.x + 263
        y: monitorControl.ballPosition.y === -1 ? pitch.x + pitch.width / 2 : monitorControl.ballPosition.y + 4.5
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
            model: monitorControl.getRightLiveMatchPlayerInfoModel();
            Rectangle{
                id: player_right
                width: 15
                height: 15
                radius: 15
                x: model.playerPosition.x + 7.5 - (pitch.width / 2) //HACK
                y: model.playerPosition.y - 10
                visible: true
                color: model.playerColor
                z : parent.z + 100
                border.width: 0.5
                border.color: "black"
                Rectangle{
                    id: player_right_inner_circle
                    width: 5
                    height: 5
                    radius: 5
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: true
                    color: "transparent"
                    border.color: "black"
                    border.width: 0.5
                }

                Text {
                    id: player_right_number	//remove in final release
                    text: model.number
                    color: "white"
                    anchors.bottom: parent.top
                    anchors.left: parent.right
                    // anchors.horizontalCenter: parent.horizontalCenter
                    // anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 7; font.bold: true
                }
                Rectangle{
                    // is actually a line
                    z:parent.z +1
                    id: player_right_neck
                    width: 1
                    height: parent.height / 2
                    radius: 1
                    anchors.bottom: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "black"
                    transformOrigin: Item.Bottom
                    rotation: model.bodyAngle + model.neckAngle
                    }
                Rectangle{
                    // is actually a line
                    z:parent.z +1
                    id: player_right_body
                    width: 1
                    height: parent.height / 2
                    radius: 1
                    anchors.bottom: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "black"
                    transformOrigin: Item.Bottom
                    rotation: model.bodyAngle
                }
                /*MouseArea {
                    anchors.fill: parent
                    drag.target: player_right
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
        //property var leftLiveMatchPlayerInfoModel monitorControl.getLeftLiveMatchPlayerInfoModel()
        //property var rightLiveMatchPlayerInfoModel monitorControl.getRightLiveMatchPlayerInfoModel()

        Repeater {
            id: players_left
            model: monitorControl.getLeftLiveMatchPlayerInfoModel();
            Rectangle{
                id: player_left
                width: 15
                height: 15
                radius: 15
                visible: true
//                players_left.itemAt(i).x = getPlayerPoint(i)[0] + 7.5 // HACK
//                players_left.itemAt(i).y = getPlayerPoint(i)[1] - 10
                x: model.playerPosition.x + 7.5 // HACK
                y: model.playerPosition.y - 10
                color: model.playerColor
                z : parent.z + 100
                border.width: 0.5
                border.color: model.playerColor
                Rectangle{
                    id: player_left_inner_cicle
                    width: 5
                    height: 5
                    radius: 5
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: true
                    color: "transparent"
                    border.color: "black"
                    border.width: 0.5
                }
                Text {
                    id: player_number1
                    text: model.number
                    color: "white"
                    anchors.bottom: parent.top
                    anchors.left: parent.right
                    // anchors.horizontalCenter: parent.horizontalCenter
                    // anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 7; font.bold: true
                }
                Rectangle{
                    z:parent.z +1
                    id: player_left_neck
                    width: 1
                    height: parent.height / 2
                    radius: 1
                    anchors.bottom: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "black"
                    transformOrigin: Item.Bottom
                    rotation: model.bodyAngle + model.neckAngle
                }
                Rectangle{
                    z:parent.z +1
                    id: player_left_body
                    width: 1
                    height: parent.height / 2
                    radius: 1
                    anchors.bottom: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "black"
                    transformOrigin: Item.Bottom
                    rotation: model.bodyAngle
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

//    //Player Move
//    function sendPlayerMove(player_id)
//    {
//        return monitorControl.sendPlayerMove(player_id,players_left.itemAt(player_id).x - 7.5,players_left.itemAt(player_id).y+10,players_left.itemAt(player_id).rotate);
//    }

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
}



/*##^## Designer {
    D{i:10;anchors_height:30}D{i:12;anchors_height:20;anchors_width:300;anchors_x:292}
D{i:17;anchors_x:448;anchors_y:390}D{i:23;anchors_x:300;anchors_y:0}
}
 ##^##*/
