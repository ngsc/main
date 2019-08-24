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
import com.Game.Player 1.0

Rectangle
{
    id: tactic
    color: "transparent"
    property string titleBar: qsTr("Tactics Page")

/*
    "GK",       //GoalKeeper
    "SW",       //Sweeper

    "D R",      //Right Defender(Full Back in map)
    "D C",      //Central Defender
    "D L",      //Left Defender(Full Back in map)

    "WB R",     //Right WingBack(Right Defensive Midfielder in map)
    "DM C",     //Central Defensive Midfielder(Defensive Midfielder in map)
    "WB L",     //Left WingBack(left Defensive Midfielder in map)

    "M R",      //Right Midfielder(Side Midfielder in map)
    "M C",      //Central Midfielder(Midfielder in map)
    "M L",      //Left Midfielder(Side Midfielder in map)

    "AM R",     //Right Attacking Midfielder(Attacking Winger in map)
    "AM C",     //Central Attacking Midfielder(Attacking Midfielder in map)
    "AM L",     //Left Attacking Midfielder(Attacking Winger in map)

    "ST"        //Forward
*/

    function setPlayers(players) {
        //set the players positions here...
        goal.visible = false
        circle1.visible = false
        circle2.visible = false
        circle3.visible = false
        circle4.visible = false
        circle5.visible = false
        circle6.visible = false
        circle7.visible = false
        circle8.visible = false
        circle9.visible = false
        circle10.visible = false

        var currentPos = 1;
        for(var i =0; i < clubPage.pModel.count(); i++) {

            var p = clubPage.pModel.at(i);

            //onsole.log("type of: " + typeof(p));
            if(typeof(p) === "undefined" || !p) {
                console.log(i + " is not defined...");
                continue;
            }

            if(p.assignedPosition === "" || p.assignedPosition === "") {
                continue;
            }

            if(p.assignedPosition === "GK") {
                console.log("setting the GK position for player: " + p.name + ", to x,y: " + gks.x + ", " + gks.y);
                goal.p0  = p;
                goal.x = gks.x
                goal.y = gks.y
                goal.visible = true

                continue;
            }

            if(currentPos == 1) {
                circle1.p = p;
                circle1.visible = true;
                var point = mapcontainer.setPlayerPosition(circle1.p.assignedPosition)
                circle1.x = point[0]
                circle1.y = point[1]
            }
            else if(currentPos == 2) {
                circle2.p = p;
                circle2.visible = true;
                var point = mapcontainer.setPlayerPosition(circle2.p.assignedPosition)
                circle2.x = point[0]
                circle2.y = point[1]
            }
            else if(currentPos == 3) {
                circle3.p = p;
                circle3.visible = true;
                var point = mapcontainer.setPlayerPosition(circle3.p.assignedPosition)
                circle3.x = point[0]
                circle3.y = point[1]

            }
            else if(currentPos == 4) {
                circle4.p = p;
                circle4.visible = true;
                var point = mapcontainer.setPlayerPosition(circle4.p.assignedPosition)
                circle4.x = point[0]
                circle4.y = point[1]

            }
            else if(currentPos == 5) {
                circle5.p = p;
                circle5.visible = true;
                var point = mapcontainer.setPlayerPosition(circle5.p.assignedPosition)
                circle5.x = point[0]
                circle5.y = point[1]
            }
            else if(currentPos == 6) {
                circle6.p = p;
                circle6.visible = true;
                var point = mapcontainer.setPlayerPosition(circle6.p.assignedPosition)
                circle6.x = point[0]
                circle6.y = point[1]

            }
            else if(currentPos == 7) {
                circle7.p = p;
                circle7.visible = true;
                var point = mapcontainer.setPlayerPosition(circle7.p.assignedPosition)
                circle7.x = point[0]
                circle7.y = point[1]

            }
            else if(currentPos == 8) {
                circle8.p = p;
                circle8.visible = true;
                var point = mapcontainer.setPlayerPosition(circle8.p.assignedPosition)
                circle8.x = point[0]
                circle8.y = point[1]

            }
            else if(currentPos == 9) {
                circle9.p = p;
                circle9.visible = true;
                var point = mapcontainer.setPlayerPosition(circle9.p.assignedPosition)
                circle9.x = point[0]
                circle9.y = point[1]

            }
            else if(currentPos == 10) {
                circle10.p = p;
                circle10.visible = true;
                var point = mapcontainer.setPlayerPosition(circle10.p1.assignedPosition)
                circle10.x = point[0]
                circle10.y = point[1]
            }

            currentPos++;

        }

    }

    MouseArea{
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
    }

    Rectangle{
        id: mapcontainer
        anchors.left: parent.left
        anchors.top : parent.top
        anchors.leftMargin: 40
        width: parent.width/2-80+1
        height: parent.height
        color: "transparent"
        z:parent.z+1

        function hideAll(){
            individualinstructionrect.visible = false
            gkRect.visible = false
            amRect.visible = false
            awRect.visible = false
            cdRect.visible = false
            dmRect.visible = false
            fsRect.visible = false
            mfRect.visible = false
            fbRect.visible = false
            sdmRect.visible =false
            smRect.visible = false
            sweeperRect.visible = false
            arrowgk.visible =false
            arrow1.visible = false
            arrow2.visible = false
            arrow3.visible = false
            arrow4.visible = false
            arrow5.visible = false
            arrow6.visible = false
            arrow7.visible = false
            arrow8.visible = false
            arrow9.visible = false
            arrow10.visible = false
            teaminstructionrect.visible = true

        }

        function showPlayerInstruction(posX,posY){
            hideAll()
            teaminstructionrect.visible = false
            individualinstructionrect.visible = true
            if((posX>(2*mapcontainer.width/5))&&(posX<(3*mapcontainer.width/5))&&
                    (posY>(7*mapcontainer.height/8))&&((posY<(8*mapcontainer.height/8)))){
                gkRect.visible = true
                return "GK"
            }
            else if((posX>(2*mapcontainer.width/5))&&(posX<(3*mapcontainer.width/5))&&
                     (posY>(6*mapcontainer.height/8))&&((posY<(7*mapcontainer.height/8)))){
                sweeperRect.visible = true
                return "SW"
            }
            ////////////////////////////
            else if((posX>(1*mapcontainer.width/5))&&(posX<(4*mapcontainer.width/5))&&
                     (posY>(5*mapcontainer.height/8))&&((posY<(6*mapcontainer.height/8)))){
                cdRect.visible = true
                return "D C"
            }
            else if((posX>(0*mapcontainer.width/5))&&(posX<(1*mapcontainer.width/5))&&
                     (posY>(5*mapcontainer.height/8))&&((posY<(6*mapcontainer.height/8)))){
                fbRect.visible = true
                return "D L"
            }
            else if((posX>(4*mapcontainer.width/5))&&(posX<(5*mapcontainer.width/5))&&
                     (posY>(5*mapcontainer.height/8))&&((posY<(6*mapcontainer.height/8)))){
                fbRect.visible = true
                return "D R"
            }
            ////////////////////////////

            else if((posX>(1*mapcontainer.width/5))&&(posX<(4*mapcontainer.width/5))&&
                     (posY>(4*mapcontainer.height/8))&&((posY<(5*mapcontainer.height/8)))){
                dmRect.visible = true
                return "DM C"
            }
            else if((posX>(0*mapcontainer.width/5))&&(posX<(1*mapcontainer.width/5))&&
                     (posY>(4*mapcontainer.height/8))&&((posY<(5*mapcontainer.height/8)))){
                sdmRect.visible = true
                return "WB L"
            }
            else if((posX>(4*mapcontainer.width/5))&&(posX<(5*mapcontainer.width/5))&&
                     (posY>(4*mapcontainer.height/8))&&((posY<(5*mapcontainer.height/8)))){
                sdmRect.visible = true
                return "WB R"
            }
            ////////////////////////////

            else if((posX>(1*mapcontainer.width/5))&&(posX<(4*mapcontainer.width/5))&&
                     (posY>(3*mapcontainer.height/8))&&((posY<(4*mapcontainer.height/8)))){
                mfRect.visible = true
                return "M C"
            }
            else if((posX>(0*mapcontainer.width/5))&&(posX<(1*mapcontainer.width/5))&&
                     (posY>(3*mapcontainer.height/8))&&((posY<(4*mapcontainer.height/8)))){
                smRect.visible = true
                return "M L"
            }else if((posX>(4*mapcontainer.width/5))&&(posX<(5*mapcontainer.width/5))&&
                     (posY>(3*mapcontainer.height/8))&&((posY<(4*mapcontainer.height/8)))){
                smRect.visible = true
                return ("M R")
            }
            ////////////////////////////

            else if((posX>(1*mapcontainer.width/5))&&(posX<(4*mapcontainer.width/5))&&
                     (posY>(2*mapcontainer.height/8))&&((posY<(3*mapcontainer.height/8)))){
                amRect.visible = true
                return ("AM C")
            }else if((posX>(0*mapcontainer.width/5))&&(posX<(1*mapcontainer.width/5))&&
                     (posY>(2*mapcontainer.height/8))&&((posY<(3*mapcontainer.height/8)))){
                awRect.visible = true
                return ("AM L")
            }else if((posX>(4*mapcontainer.width/5))&&(posX<(5*mapcontainer.width/5))&&
                     (posY>(2*mapcontainer.height/8))&&((posY<(3*mapcontainer.height/8)))){
                awRect.visible = true
                return ("AM R")
            }
            ////////////////////////////

            else if((posX>(1*mapcontainer.width/5))&&(posX<(4*mapcontainer.width/5))&&
                     (posY>(1*mapcontainer.height/8))&&((posY<(2*mapcontainer.height/8)))){
                fsRect.visible = true
                return ("ST")
            }


        }

        function getX(value){
            if((0*mapcontainer.width/5<value)&&(1*mapcontainer.width/5>value)){
                return (mapcontainer.width/10)
            }else if((1*mapcontainer.width/5<value)&&(2*mapcontainer.width/5>value)){
                return ((1*mapcontainer.width/5)+(mapcontainer.width/10))
            }else if((2*mapcontainer.width/5<value)&&(3*mapcontainer.width/5>value)){
                return ((2*mapcontainer.width/5)+(mapcontainer.width/10))
            }else if((3*mapcontainer.width/5<value)&&(4*mapcontainer.width/5>value)){
                return ((3*mapcontainer.width/5)+(mapcontainer.width/10))
            }else if((4*mapcontainer.width/5<value)&&(5*mapcontainer.width/5>value)){
                return ((4*mapcontainer.width/5)+(mapcontainer.width/10))
            }else if((0*mapcontainer.width/5>value)){
                return mapcontainer.width/10
            }else if((7*mapcontainer.width/5<value)){
                return mapcontainer.width
            }
        }

        function getY(value){
            if((1*mapcontainer.height/8<value)&&(2*mapcontainer.height/8>value)){
                return ((1*mapcontainer.height/8)+(mapcontainer.height/16))
            }else if((2*mapcontainer.height/8<value)&&(3*mapcontainer.height/8>value)){
                return ((2*mapcontainer.height/8)+(mapcontainer.height/16))
            }else if((3*mapcontainer.height/8<value)&&(4*mapcontainer.height/8>value)){
                return ((3*mapcontainer.height/8)+(mapcontainer.height/16))
            }else if((4*mapcontainer.height/8<value)&&(5*mapcontainer.height/8>value)){
                return ((4*mapcontainer.height/8)+(mapcontainer.height/16))
            }else if((5*mapcontainer.height/8<value)&&(6*mapcontainer.height/8>value)){
                return ((5*mapcontainer.height/8)+(mapcontainer.height/16))
            }else if((6*mapcontainer.height/8<value)&&(7*mapcontainer.height/8>value)){
                return ((6*mapcontainer.height/8)+(mapcontainer.height/16))
            }else if((7*mapcontainer.height/8<value)&&(8*mapcontainer.height/5>value)){
                return ((7*mapcontainer.height/8)+(mapcontainer.height/16))
            }else if((1*mapcontainer.height/8>value)){
                return ((1*mapcontainer.height/8)+ (mapcontainer.height/16))
            }else if((8*mapcontainer.height/8<value)){
                return mapcontainer.height
            }

        }

        function setPlayerPosition(position) {

            if(position === "GK") {	//GoalKeeper
                return [gks.x, gks.y]
            }
            else if(position === "SW") {	//Sweeper
                return [sws.x, sws.y]
            }

            else if(position === "D R") {	//Right Defender(Full Back in map)
                return [drs.x, drs.y]
            }
            else if(position === "D C") {	//Central Defender
                return [dcs1.x, dcs1.y]
            }
            else if(position === "D L") {	//Left Defender(Full Back in map)
                return [dls.x, dls.y]
            }

            else if(position === "WB R") {	//Right WingBack(Right Defensive Midfielder in map)
                return [wbrs.x, wbrs.y]
            }
            else if(position === "DM C") {	//Central Defensive Midfielder(Defensive Midfielder in map)
                //if()
                return [dmcs1.x, dmcs1.y]
            }
            else if(position === "WB L") {	//Left WingBack(left Defensive Midfielder in map)
                return [wbls.x, wbls.y]
            }

            else if(position === "M R") {		//Right Midfielder(Side Midfielder in map)
                return [mrs.x, mrs.y]
            }
            else if(position === "M C") {		//Central Midfielder(Midfielder in map)
                return [mcs1.x, mcs1.y]
            }
            else if(position === "M L") {		//Left Midfielder(Side Midfielder in map)
                return [mls.x, mls.y]
            }

            else if(position === "AM R") {	//Right Attacking Midfielder(Attacking Winger in map)
                return [amrs.x, amrs.y]
            }
            else if(position === "AM C") {	//Central Attacking Midfielder(Attacking Midfielder in map)
                return [amcs1.x, amcs1.y]
            }
            else if(position === "AM L") {	//Left Attacking Midfielder(Attacking Winger in map)
                return [amls.x, amls.y]
            }

            else if(position === "ST") {	//Forward
                return [sts1.x, sts1.y]
            }

        }/*
		function updateOffsideTrap(){
			return monitorControl.UpdateOffsideTrap();
		}
		function updateHardTackle(){
			return monitorControl.UpdateHardTackle();
		}
		function updateHighLineClosingDown(){
			return monitorControl.UpdateHighLineClosingDown();
		} 
		function updateOffsideLine(){
			return monitorControl.UpdateOffsideLine();
		}
		function updatePreventPass(){
			return monitorControl.UpdatePreventPass();
		}
		function updatePreventingCutInside(){
			return monitorControl.UpdatePreventingCutInside();
		}
		function updateTightMarking(){
			return monitorControl.UpdateTightMarking();
		} 
		function updateStopsPlay(){
			return monitorControl.UpdateStopsPlay();
		}
		function updateGetsForward(){
			return monitorControl.UpdateGetsForward();
		}
		function updateShootFromDistance(){
			return monitorControl.UpdateShootFromDistance();
		}
		function updateStayBack(){
			return monitorControl.UpdateStayBack();
		}
		function updateRunDownTheLine(){
			return monitorControl.UpdateRunDownTheLine();
		}
		function updateMovesIntoChannels(){
			return monitorControl.UpdateMovesIntoChannels();
		}
		function updatePreferDribbleOverPass(){
			return monitorControl.UpdatePreferDribbleOverPass();
		}
		function updateDictatesTempo(){
			return monitorControl.UpdateDictatesTempo();
		}
		function updateComesDeepToGetBall(){
			return monitorControl.UpdateComesDeepToGetBall();
		}
		function updateLongPasses(){
			return monitorControl.UpdateLongPasses();
		}
		function updateRoundToKeeper(){
			return monitorControl.UpdateRoundToKeeper();
		}
		function updateBeatOffsideTrap(){
			return monitorControl.UpdateBeatOffsideTrap();
		}
		function updateCutInside(){
			return monitorControl.UpdateCutInside();
		}
		function updateCrossTheBallMoreOften(){
			return monitorControl.UpdateCrossTheBallMoreOften();
		}
		function updateRushOut(){
			return monitorControl.UpdateRushOut();
		}
		function updateForwardInCornerKick(){
			return monitorControl.UpdateForwardInCornerKick();
		}
		function updatePassBallToDefender(){
			return monitorControl.UpdatePassBallToDefender();
		}
		function updateTriesKillerBallOften(){
			return monitorControl.UpdateTriesKillerBallOften();
		}
		function sendTactics(){
			return monitorControl.sendTactics();
		}*/
        Rectangle{
            id: map
            anchors.left: parent.left
            anchors.top : parent.top
            width: parent.width
            height: parent.height
            color: "green"
            z:parent.z+1
            border.width: 4
            border.color: "white"
            property int angle: 0
            property int originX: map.width/2
            property int originY: map.height/2
            smooth: true
            transform: Rotation { origin.x: map.originX; origin.y: map.originY; angle: map.angle}

            Rectangle{
                id: mapshadow
                anchors.left: parent.left
                anchors.top : parent.top
                width: parent.width
                height: parent.height
                color: "transparent"
                border.color: "white"
                opacity: 0.7
                z:parent.z
                Rectangle{
                    width: 2*mapcontainer.width/5
                    height: 1*mapcontainer.height/8
                    color: "transparent"
                    border.width: 4
                    border.color: "white"
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Rectangle{
                    width: 3*mapcontainer.width/5
                    height: 2*mapcontainer.height/8
                    color: "transparent"
                    border.width: 4
                    border.color: "white"
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Rectangle{
                    width: 2*mapcontainer.width/5
                    height: 1*mapcontainer.height/8
                    color: "transparent"
                    border.width: 4
                    border.color: "white"
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Rectangle{
                    width: 3*mapcontainer.width/5
                    height: 2*mapcontainer.height/8
                    color: "transparent"
                    border.width: 4
                    border.color: "white"
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Rectangle{
                    width: parent.width
                    height: parent.height/2+2
                    color: "transparent"
                    border.width: 4
                    border.color: "white"
                    anchors.top: parent.top
                }
                Rectangle{
                    width: parent.width
                    height: parent.height/2
                    color: "transparent"
                    border.width: 4
                    border.color: "white"
                    anchors.bottom: parent.bottom
                }
                Rectangle{
                    width: 2*parent.width/5
                    height: width
                    radius: width/2
                    color: "transparent"
                    border.width: 4
                    border.color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }

                Rectangle{
                    id: playershadow
                    anchors.left: parent.left
                    anchors.top : parent.top
                    width: parent.width
                    height: parent.height
                    color: "transparent"
                    visible: false
                    opacity: 0.4
                    z:parent.z
                    Rectangle{
                        id: gks
                        width: 40
                        height: 40
                        x : 2*parent.width/5+parent.width/10-width/2
                        y : 8*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        id: sws
                        width: 40
                        height: 40
                        x : 2*parent.width/5+parent.width/10-width/2
                        y : 7*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        id: dcs2
                        width: 40
                        height: 40
                        x : 2*parent.width/5+parent.width/10-width/2
                        y : 6*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        id: dls
                        width: 40
                        height: 40
                        x : 0*parent.width/5+parent.width/10-width/2
                        y : 6*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        id: dcs3
                        width: 40
                        height: 40
                        x : 1*parent.width/5+parent.width/10-width/2
                        y : 6*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        id: dcs1
                        width: 40
                        height: 40
                        x : 3*parent.width/5+parent.width/10-width/2
                        y : 6*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        id: drs
                        width: 40
                        height: 40
                        x : 4*parent.width/5+parent.width/10-width/2
                        y : 6*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        id: wbls
                        width: 40
                        height: 40
                        x : 0*parent.width/5+parent.width/10-width/2
                        y : 5*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        id: dmcs3
                        width: 40
                        height: 40
                        x : 1*parent.width/5+parent.width/10-width/2
                        y : 5*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        id: dmcs2
                        width: 40
                        height: 40
                        x : 2*parent.width/5+parent.width/10-width/2
                        y : 5*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        id: dmcs1
                        width: 40
                        height: 40
                        x : 3*parent.width/5+parent.width/10-width/2
                        y : 5*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        id: wbrs
                        width: 40
                        height: 40
                        x : 4*parent.width/5+parent.width/10-width/2
                        y : 5*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        id: mls
                        width: 40
                        height: 40
                        x : 0*parent.width/5+parent.width/10-width/2
                        y : 4*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        id: mcs3
                        width: 40
                        height: 40
                        x : 1*parent.width/5+parent.width/10-width/2
                        y : 4*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        id: mcs2
                        width: 40
                        height: 40
                        x : 2*parent.width/5+parent.width/10-width/2
                        y : 4*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        id: mcs1
                        width: 40
                        height: 40
                        x : 3*parent.width/5+parent.width/10-width/2
                        y : 4*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        id: mrs
                        width: 40
                        height: 40
                        x : 4*parent.width/5+parent.width/10-width/2
                        y : 4*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        id: amls
                        width: 40
                        height: 40
                        x : 0*parent.width/5+parent.width/10-width/2
                        y : 3*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        id: amcs3
                        width: 40
                        height: 40
                        x : 1*parent.width/5+parent.width/10-width/2
                        y : 3*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        id: amcs2
                        width: 40
                        height: 40
                        x : 2*parent.width/5+parent.width/10-width/2
                        y : 3*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        id: amcs1
                        width: 40
                        height: 40
                        x : 3*parent.width/5+parent.width/10-width/2
                        y : 3*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        id: amrs
                        width: 40
                        height: 40
                        x : 4*parent.width/5+parent.width/10-width/2
                        y : 3*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        id: sts3
                        width: 40
                        height: 40
                        x : 1*parent.width/5+parent.width/10-width/2
                        y : 2*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        id: sts2
                        width: 40
                        height: 40
                        x : 2*parent.width/5+parent.width/10-width/2
                        y : 2*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        id: sts1
                        width: 40
                        height: 40
                        x : 3*parent.width/5+parent.width/10-width/2
                        y : 2*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }

                }
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
            }

            Rectangle{
                id : goal
                width: 40
                height: 40
                x : 2*parent.width/5+parent.width/10-width/2
                y : 8*(parent.height/8)-parent.height/16-height/2
                radius: 20
                visible: false
                color: "red"
                z : parent.z+2
                border.width: 4
                border.color: "white"
                property Player p0

                onP0Changed: {
                    console.log("\t\tplayer changed to : " + p0.name)
                    console.log("\t\tplayer position to : " + p0.assignedPosition)
                    txt.text = Qt.binding(function() { return p0.assignedPosition});
                }

                Text {
                    id: txt
                    color:"White"
                    font.pointSize: 9
                    text: ""
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    acceptedButtons: Qt.RightButton | Qt.LeftButton
                    cursorShape: Qt.PointingHandCursor
                    property int mouseButtonClicked: Qt.NoButton
                    anchors.fill: parent
                    onReleased: {
                        playershadow.visible = false
                        if (mouse.button  === Qt.LeftButton) {
                            p0.assignedPosition = mapcontainer.showPlayerInstruction(parent.x, parent.y)
                            APIConnection.updatePlayerPosition(managerUser.token, goal.p0);
                            gkRect.visible = true
                            individualinstructionrect.visible = true
                        } else if (mouse.button === Qt.RightButton) {
                            mapcontainer.hideAll()
                            arrowgk.visible = true

                        }
                    }
                    onPositionChanged: {
                        if (mouseButtonClicked === Qt.RightButton){
                            var point =  mapToItem (parent, mouseX, mouseY);
                            var diffX = (point.x + parent.x);
                            var diffY = (point.y + parent.y);
                            var difX = mapcontainer.getX(diffX)
                            var difY = mapcontainer.getY(diffY)
                            diffX = difX - parent.x - parent.width/2
                            diffY = difY - parent.y - parent.height/2
                            var rad = Math.atan (diffY / diffX);
                            var deg = (rad * 180 / Math.PI);
                            if (diffX > 0 && diffY > 0) {
                                arrowgk.angle = 90 + Math.abs (deg);
                            }
                            else if (diffX > 0 && diffY < 0) {
                                arrowgk.angle = 90 - Math.abs (deg);
                            }
                            else if (diffX < 0 && diffY > 0) {
                                arrowgk.angle = 270 - Math.abs (deg);
                            }
                            else if (diffX < 0 && diffY < 0) {
                                arrowgk.angle = 270 + Math.abs (deg);
                            }else if(diffX === 0 && diffY < 0){
                                arrowgk.angle = 0
                            }else if(diffX === 0 && diffY > 0){
                                arrowgk.angle = 180
                            }else if(diffX > 0 && diffY === 0){
                                arrowgk.angle = 90
                            }else if(diffX < 0 && diffY === 0){
                                arrowgk.angle = 270
                            }
                            arrowgk.height = Math.sqrt((difX-parent.x)*(difX-parent.x)+(difY-parent.y)*(difY-parent.y))
                        }
                    }
                    onPressed: {
                        playershadow.visible = true
                        if (mouse.button  === Qt.LeftButton) {
                            arrowgk.visible = false
                            mouseButtonClicked = Qt.LeftButton
                        }else if (mouse.button === Qt.RightButton) {
                            arrowgk.visible = true
                            mouseButtonClicked = Qt.RightButton
                        }
                    }
                }
            }
            Rectangle{
                id : circle1
                width: 40
                height: 40
                x:2*parent.width/5+parent.width/10-width/2
                y:7*(parent.height/8)-parent.height/16-height/2
                radius: 20
                visible: false
                color: "red"
                z : parent.z+2
                border.width: 4
                border.color: "white"
                //property string name: "S"//mapcontainer.showPlayerInstruction(x,y)
                property Player p
                onPChanged: {
                    //console.log("\t\tplayer changed to : " + p0.name) //console.log("\t\tplayer position to : " + p0.assignedPosition)
                    c1txt.text = Qt.binding(function() { return p.assignedPosition});
                }
                Text {
                    id: c1txt
                    color:"White"
                    font.pointSize: 9
                    text: ""
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    id: mousecircle1
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    cursorShape: Qt.PointingHandCursor
                    property int mouseButtonClicked: Qt.NoButton
                    onReleased: playershadow.visible =false
                    onPressed: {
                        playershadow.visible = true
                        if (mouse.button  === Qt.LeftButton) {
                            circle1.p.assignedPosition = mapcontainer.showPlayerInstruction(parent.x,parent.y)
                            APIConnection.updatePlayerPosition(managerUser.token, circle1.p);
                            arrow1.visible = false
                            mouseButtonClicked = Qt.LeftButton
                        }else if (mouse.button === Qt.RightButton) {
                            mapcontainer.hideAll()
                            arrow1.visible = true
                            mouseButtonClicked = Qt.RightButton
                        }
                    }
                    onPositionChanged: {
                        if (mouseButtonClicked === Qt.LeftButton) {
                            circle1.p.assignedPosition = mapcontainer.showPlayerInstruction(parent.x,parent.y)
                            APIConnection.updatePlayerPosition(managerUser.token, circle1.p);
                            if((parent.x+mouseX)>(0*mapcontainer.width/5)&&(parent.x+mouseX)<(5*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(2*mapcontainer.height/8))&&((parent.y+mouseY)<(6*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                            if((parent.x+mouseX)>(1*mapcontainer.width/5)&&(parent.x+mouseX)<(4*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(1*mapcontainer.height/8))&&((parent.y+mouseY)<(2*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                            if((parent.x+mouseX)>(2*mapcontainer.width/5)&&(parent.x+mouseX)<(3*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(6*mapcontainer.height/8))&&((parent.y+mouseY)<(8*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                        }else if (mouseButtonClicked === Qt.RightButton){
                            var point =  mapToItem (parent, mouseX, mouseY);
                            var diffX = (point.x + parent.x - parent.width/2);
                            var diffY = (point.y + parent.y - parent.height/2);
                            var difX = mapcontainer.getX(diffX)
                            var difY = mapcontainer.getY(diffY)
                            diffX = difX - parent.x - parent.width/2
                            diffY = difY - parent.y - parent.height/2
                            var rad = Math.atan (diffY / diffX);
                            var deg = (rad * 180 / Math.PI);
                            if (diffX > 0 && diffY > 0) {
                                arrow1.angle = 90 + Math.abs (deg);
                            }
                            else if (diffX > 0 && diffY < 0) {
                                arrow1.angle = 90 - Math.abs (deg);
                            }
                            else if (diffX < 0 && diffY > 0) {
                                arrow1.angle = 270 - Math.abs (deg);
                            }
                            else if (diffX < 0 && diffY < 0) {
                                arrow1.angle = 270 + Math.abs (deg);
                            }else if(diffX === 0 && diffY < 0){
                                arrow1.angle = 0
                            }else if(diffX === 0 && diffY > 0){
                                arrow1.angle = 180
                            }else if(diffX > 0 && diffY === 0){
                                arrow1.angle = 90
                            }else if(diffX < 0 && diffY === 0){
                                arrow1.angle = 270
                            }
                            arrow1.height = Math.sqrt((difX-parent.x)*(difX-parent.x)+(difY-parent.y)*(difY-parent.y))
                        }
                    }
                }
            }
            Rectangle{
                id : circle2
                x:2*parent.width/5+parent.width/10-width/2
                y:6*(parent.height/8)-parent.height/16-height/2
                width: 40
                height: 40
                radius: 20
                visible: false
                color: "red"
                z : parent.z+2
                border.width: 4
                border.color: "white"
                //property string name: "CD"//mapcontainer.showPlayerInstruction(x,y)
                property Player p
                onPChanged: {
                    //console.log("\t\tplayer changed to : " + p0.name) //console.log("\t\tplayer position to : " + p0.assignedPosition)
                    c2txt.text = Qt.binding(function() { return p.assignedPosition});
                }
                Text {
                    id: c2txt
                    color:"White"
                    font.pointSize: 9
                    text: ""
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    cursorShape: Qt.PointingHandCursor
                    property int mouseButtonClicked: Qt.NoButton
                    onReleased: playershadow.visible =false
                    onPressed: {
                        playershadow.visible = true
                        if (mouse.button  === Qt.LeftButton) {
                            circle2.p.assignedPosition = mapcontainer.showPlayerInstruction(parent.x,parent.y)
                            APIConnection.updatePlayerPosition(managerUser.token, circle2.p);
                            arrow2.visible = false
                            mouseButtonClicked = Qt.LeftButton
                        }else if (mouse.button === Qt.RightButton) {
                            mapcontainer.hideAll()
                            arrow2.visible = true
                            mouseButtonClicked = Qt.RightButton
                        }
                    }
                    onPositionChanged: {
                        if (mouseButtonClicked === Qt.LeftButton) {
                            circle2.p.assignedPosition = mapcontainer.showPlayerInstruction(parent.x,parent.y)
                            APIConnection.updatePlayerPosition(managerUser.token, circle2.p);
                            if((parent.x+mouseX)>(0*mapcontainer.width/5)&&(parent.x+mouseX)<(5*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(2*mapcontainer.height/8))&&((parent.y+mouseY)<(6*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                            if((parent.x+mouseX)>(1*mapcontainer.width/5)&&(parent.x+mouseX)<(4*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(1*mapcontainer.height/8))&&((parent.y+mouseY)<(2*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                            if((parent.x+mouseX)>(2*mapcontainer.width/5)&&(parent.x+mouseX)<(3*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(6*mapcontainer.height/8))&&((parent.y+mouseY)<(8*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                        }else if (mouseButtonClicked === Qt.RightButton){
                            var point =  mapToItem (parent, mouseX, mouseY);
                            var diffX = (point.x + parent.x);
                            var diffY = (point.y + parent.y);
                            var difX = mapcontainer.getX(diffX)
                            var difY = mapcontainer.getY(diffY)
                            diffX = difX - parent.x - parent.width/2
                            diffY = difY - parent.y - parent.height/2
                            var rad = Math.atan (diffY / diffX);
                            var deg = (rad * 180 / Math.PI);
                            if (diffX > 0 && diffY > 0) {
                                arrow2.angle = 90 + Math.abs (deg);
                            }
                            else if (diffX > 0 && diffY < 0) {
                                arrow2.angle = 90 - Math.abs (deg);
                            }
                            else if (diffX < 0 && diffY > 0) {
                                arrow2.angle = 270 - Math.abs (deg);
                            }
                            else if (diffX < 0 && diffY < 0) {
                                arrow2.angle = 270 + Math.abs (deg);
                            }else if(diffX === 0 && diffY < 0){
                                arrow2.angle = 0
                            }else if(diffX === 0 && diffY > 0){
                                arrow2.angle = 180
                            }else if(diffX > 0 && diffY === 0){
                                arrow2.angle = 90
                            }else if(diffX < 0 && diffY === 0){
                                arrow2.angle = 270
                            }
                            arrow2.height = Math.sqrt((difX-parent.x)*(difX-parent.x)+(difY-parent.y)*(difY-parent.y))
                        }
                    }
                }
            }
            Rectangle{
                id : circle3
                width: 40
                height: 40
                x:2*parent.width/5+parent.width/10-width/2
                y:5*(parent.height/8)-parent.height/16-height/2
                radius: 20
                visible: false
                color: "red"
                z : parent.z+2
                border.width: 4
                border.color: "white"
                property Player p
                onPChanged: {
                    //console.log("\t\tplayer changed to : " + p0.name) //console.log("\t\tplayer position to : " + p0.assignedPosition)
                    c3txt.text = Qt.binding(function() { return p.assignedPosition});
                }
                Text {
                    id: c3txt
                    color:"White"
                    font.pointSize: 9
                    text: ""
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    cursorShape: Qt.PointingHandCursor
                    property int mouseButtonClicked: Qt.NoButton
                    onReleased: playershadow.visible =false
                    onPressed: {
                        playershadow.visible = true
                        if (mouse.button  === Qt.LeftButton) {
                            circle3.p.assignedPosition = mapcontainer.showPlayerInstruction(parent.x,parent.y)
                            APIConnection.updatePlayerPosition(managerUser.token, circle3.p);
                            arrow3.visible = false
                            mouseButtonClicked = Qt.LeftButton
                        }else if (mouse.button === Qt.RightButton) {
                            mapcontainer.hideAll()
                            arrow3.visible = true
                            mouseButtonClicked = Qt.RightButton
                        }
                    }
                    onPositionChanged: {
                        if (mouseButtonClicked === Qt.LeftButton) {
                            circle3.p.assignedPosition = mapcontainer.showPlayerInstruction(parent.x,parent.y)
                            APIConnection.updatePlayerPosition(managerUser.token, circle3.p);
                            if((parent.x+mouseX)>(0*mapcontainer.width/5)&&(parent.x+mouseX)<(5*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(2*mapcontainer.height/8))&&((parent.y+mouseY)<(6*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                            if((parent.x+mouseX)>(1*mapcontainer.width/5)&&(parent.x+mouseX)<(4*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(1*mapcontainer.height/8))&&((parent.y+mouseY)<(2*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                            if((parent.x+mouseX)>(2*mapcontainer.width/5)&&(parent.x+mouseX)<(3*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(6*mapcontainer.height/8))&&((parent.y+mouseY)<(8*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                        }else if (mouseButtonClicked === Qt.RightButton){
                            var point =  mapToItem (parent, mouseX, mouseY);
                            var diffX = (point.x + parent.x);
                            var diffY = (point.y + parent.y);
                            var difX = mapcontainer.getX(diffX)
                            var difY = mapcontainer.getY(diffY)
                            diffX = difX - parent.x - parent.width/2
                            diffY = difY - parent.y - parent.height/2
                            var rad = Math.atan (diffY / diffX);
                            var deg = (rad * 180 / Math.PI);
                            if (diffX > 0 && diffY > 0) {
                                arrow3.angle = 90 + Math.abs (deg);
                            }
                            else if (diffX > 0 && diffY < 0) {
                                arrow3.angle = 90 - Math.abs (deg);
                            }
                            else if (diffX < 0 && diffY > 0) {
                                arrow3.angle = 270 - Math.abs (deg);
                            }
                            else if (diffX < 0 && diffY < 0) {
                                arrow3.angle = 270 + Math.abs (deg);
                            }else if(diffX === 0 && diffY < 0){
                                arrow3.angle = 0
                            }else if(diffX === 0 && diffY > 0){
                                arrow3.angle = 180
                            }else if(diffX > 0 && diffY === 0){
                                arrow3.angle = 90
                            }else if(diffX < 0 && diffY === 0){
                                arrow3.angle = 270
                            }
                            arrow3.height = Math.sqrt((difX-parent.x)*(difX-parent.x)+(difY-parent.y)*(difY-parent.y))
                        }
                    }
                }
            }
            Rectangle{
                id : circle4
                width: 40
                height: 40
                x:2*parent.width/5+parent.width/10-width/2
                y:4*(parent.height/8)-parent.height/16-height/2
                radius: 20
                visible: false
                color: "red"
                z : parent.z+2
                border.width: 4
                border.color: "white"
                //property string name: "MF"//mapcontainer.showPlayerInstruction(x,y)
                property Player p
                onPChanged: {
                    //console.log("\t\tplayer changed to : " + p0.name) //console.log("\t\tplayer position to : " + p0.assignedPosition)
                    c4txt.text = Qt.binding(function() { return p.assignedPosition});
                }
                Text {
                    id: c4txt
                    color:"White"
                    font.pointSize: 9
                    text: ""
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    cursorShape: Qt.PointingHandCursor
                    property int mouseButtonClicked: Qt.NoButton
                    onReleased: playershadow.visible =false
                    onPressed: {
                        playershadow.visible = true
                        if (mouse.button  === Qt.LeftButton) {
                            circle4.p.assignedPosition = mapcontainer.showPlayerInstruction(parent.x,parent.y)
                            APIConnection.updatePlayerPosition(managerUser.token, circle4.p);
                            arrow4.visible = false
                            mouseButtonClicked = Qt.LeftButton
                        }else if (mouse.button === Qt.RightButton) {
                            mapcontainer.hideAll()
                            arrow4.visible = true
                            mouseButtonClicked = Qt.RightButton
                        }
                    }
                    onPositionChanged: {
                        if (mouseButtonClicked === Qt.LeftButton) {
                            circle4.p.assignedPosition = mapcontainer.showPlayerInstruction(parent.x,parent.y)
                            APIConnection.updatePlayerPosition(managerUser.token, circle4.p);
                            if((parent.x+mouseX)>(0*mapcontainer.width/5)&&(parent.x+mouseX)<(5*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(2*mapcontainer.height/8))&&((parent.y+mouseY)<(6*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                            if((parent.x+mouseX)>(1*mapcontainer.width/5)&&(parent.x+mouseX)<(4*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(1*mapcontainer.height/8))&&((parent.y+mouseY)<(2*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                            if((parent.x+mouseX)>(2*mapcontainer.width/5)&&(parent.x+mouseX)<(3*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(6*mapcontainer.height/8))&&((parent.y+mouseY)<(8*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                        }else if (mouseButtonClicked === Qt.RightButton){
                            var point =  mapToItem (parent, mouseX, mouseY);
                            var diffX = (point.x + parent.x);
                            var diffY = (point.y + parent.y);
                            var difX = mapcontainer.getX(diffX)
                            var difY = mapcontainer.getY(diffY)
                            diffX = difX - parent.x - parent.width/2
                            diffY = difY - parent.y - parent.height/2
                            var rad = Math.atan (diffY / diffX);
                            var deg = (rad * 180 / Math.PI);
                            if (diffX > 0 && diffY > 0) {
                                arrow4.angle = 90 + Math.abs (deg);
                            }
                            else if (diffX > 0 && diffY < 0) {
                                arrow4.angle = 90 - Math.abs (deg);
                            }
                            else if (diffX < 0 && diffY > 0) {
                                arrow4.angle = 270 - Math.abs (deg);
                            }
                            else if (diffX < 0 && diffY < 0) {
                                arrow4.angle = 270 + Math.abs (deg);
                            }else if(diffX === 0 && diffY < 0){
                                arrow4.angle = 0
                            }else if(diffX === 0 && diffY > 0){
                                arrow4.angle = 180
                            }else if(diffX > 0 && diffY === 0){
                                arrow4.angle = 90
                            }else if(diffX < 0 && diffY === 0){
                                arrow4.angle = 270
                            }
                            arrow4.height = Math.sqrt((difX-parent.x)*(difX-parent.x)+(difY-parent.y)*(difY-parent.y))
                        }
                    }
                }
            }
            Rectangle{
                id : circle5
                width: 40
                height: 40
                x:2*parent.width/5+parent.width/10-width/2
                y:3*(parent.height/8)-parent.height/16-height/2
                radius: 20
                visible: false
                color: "red"
                z : parent.z+2
                border.width: 4
                border.color: "white"
                property Player p
                onPChanged: {
                    //console.log("\t\tplayer changed to : " + p0.name) //console.log("\t\tplayer position to : " + p0.assignedPosition)
                    c5txt.text = Qt.binding(function() { return p.assignedPosition});
                }
                Text {
                    id: c5txt
                    color:"White"
                    font.pointSize: 9
                    text: ""
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    cursorShape: Qt.PointingHandCursor
                    property int mouseButtonClicked: Qt.NoButton
                    onReleased: playershadow.visible =false
                    onPressed: {
                        playershadow.visible = true
                        if (mouse.button  === Qt.LeftButton) {
                            circle5.p.assignedPosition = mapcontainer.showPlayerInstruction(parent.x,parent.y)
                            APIConnection.updatePlayerPosition(managerUser.token, circle5.p);
                            arrow5.visible = false
                            mouseButtonClicked = Qt.LeftButton
                        }else if (mouse.button === Qt.RightButton) {
                            mapcontainer.hideAll()
                            arrow5.visible = true
                            mouseButtonClicked = Qt.RightButton
                        }
                    }
                    onPositionChanged: {
                        if (mouseButtonClicked === Qt.LeftButton) {
                            circle5.p.assignedPosition = mapcontainer.showPlayerInstruction(parent.x,parent.y)
                            APIConnection.updatePlayerPosition(managerUser.token, circle5.p);
                            if((parent.x+mouseX)>(0*mapcontainer.width/5)&&(parent.x+mouseX)<(5*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(2*mapcontainer.height/8))&&((parent.y+mouseY)<(6*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                            if((parent.x+mouseX)>(1*mapcontainer.width/5)&&(parent.x+mouseX)<(4*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(1*mapcontainer.height/8))&&((parent.y+mouseY)<(2*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                            if((parent.x+mouseX)>(2*mapcontainer.width/5)&&(parent.x+mouseX)<(3*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(6*mapcontainer.height/8))&&((parent.y+mouseY)<(8*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                        }else if (mouseButtonClicked === Qt.RightButton){
                            var point =  mapToItem (parent, mouseX, mouseY);
                            var diffX = (point.x + parent.x);
                            var diffY = (point.y + parent.y);
                            var difX = mapcontainer.getX(diffX)
                            var difY = mapcontainer.getY(diffY)
                            diffX = difX - parent.x - parent.width/2
                            diffY = difY - parent.y - parent.height/2
                            var rad = Math.atan (diffY / diffX);
                            var deg = (rad * 180 / Math.PI);
                            if (diffX > 0 && diffY > 0) {
                                arrow5.angle = 90 + Math.abs (deg);
                            }
                            else if (diffX > 0 && diffY < 0) {
                                arrow5.angle = 90 - Math.abs (deg);
                            }
                            else if (diffX < 0 && diffY > 0) {
                                arrow5.angle = 270 - Math.abs (deg);
                            }
                            else if (diffX < 0 && diffY < 0) {
                                arrow5.angle = 270 + Math.abs (deg);
                            }else if(diffX === 0 && diffY < 0){
                                arrow5.angle = 0
                            }else if(diffX === 0 && diffY > 0){
                                arrow5.angle = 180
                            }else if(diffX > 0 && diffY === 0){
                                arrow5.angle = 90
                            }else if(diffX < 0 && diffY === 0){
                                arrow5.angle = 270
                            }
                            arrow5.height = Math.sqrt((difX-parent.x)*(difX-parent.x)+(difY-parent.y)*(difY-parent.y))
                        }
                    }
                }
            }
            Rectangle{
                id : circle6
                width: 40
                height: 40
                x:2*parent.width/5+parent.width/10-width/2
                y:2*(parent.height/8)-parent.height/16-height/2
                radius: 20
                visible: false
                color: "red"
                z : parent.z+2
                border.width: 4
                border.color: "white"
                property Player p
                onPChanged: {
                    //console.log("\t\tplayer changed to : " + p0.name) //console.log("\t\tplayer position to : " + p0.assignedPosition)
                    c6txt.text = Qt.binding(function() { return p.assignedPosition});
                }
                Text {
                    id: c6txt
                    color:"White"
                    font.pointSize: 9
                    text: ""    //qsTr(parent.name)
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    cursorShape: Qt.PointingHandCursor
                    property int mouseButtonClicked: Qt.NoButton
                    onReleased: playershadow.visible =false
                    onPressed: {
                        playershadow.visible = true
                        if (mouse.button  === Qt.LeftButton) {
                            circle6.p.assignedPosition = mapcontainer.showPlayerInstruction(parent.x,parent.y)
                            APIConnection.updatePlayerPosition(managerUser.token, circle6.p);
                            arrow6.visible = false
                            mouseButtonClicked = Qt.LeftButton
                        }else if (mouse.button === Qt.RightButton) {
                            mapcontainer.hideAll()
                            arrow6.visible = true
                            mouseButtonClicked = Qt.RightButton
                        }
                    }
                    onPositionChanged: {
                        if (mouseButtonClicked === Qt.LeftButton) {
                            circle6.p.assignedPosition = mapcontainer.showPlayerInstruction(parent.x,parent.y)
                            APIConnection.updatePlayerPosition(managerUser.token, circle6.p);
                            if((parent.x+mouseX)>(0*mapcontainer.width/5)&&(parent.x+mouseX)<(5*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(2*mapcontainer.height/8))&&((parent.y+mouseY)<(6*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                            if((parent.x+mouseX)>(1*mapcontainer.width/5)&&(parent.x+mouseX)<(4*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(1*mapcontainer.height/8))&&((parent.y+mouseY)<(2*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                            if((parent.x+mouseX)>(2*mapcontainer.width/5)&&(parent.x+mouseX)<(3*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(6*mapcontainer.height/8))&&((parent.y+mouseY)<(8*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                        }else if (mouseButtonClicked === Qt.RightButton){
                            var point =  mapToItem (parent, mouseX, mouseY);
                            var diffX = (point.x + parent.x);
                            var diffY = (point.y + parent.y);
                            var difX = mapcontainer.getX(diffX)
                            var difY = mapcontainer.getY(diffY)
                            diffX = difX - parent.x - parent.width/2
                            diffY = difY - parent.y - parent.height/2
                            var rad = Math.atan (diffY / diffX);
                            var deg = (rad * 180 / Math.PI);
                            if (diffX > 0 && diffY > 0) {
                                arrow6.angle = 90 + Math.abs (deg);
                            }
                            else if (diffX > 0 && diffY < 0) {
                                arrow6.angle = 90 - Math.abs (deg);
                            }
                            else if (diffX < 0 && diffY > 0) {
                                arrow6.angle = 270 - Math.abs (deg);
                            }
                            else if (diffX < 0 && diffY < 0) {
                                arrow6.angle = 270 + Math.abs (deg);
                            }else if(diffX === 0 && diffY < 0){
                                arrow6.angle = 0
                            }else if(diffX === 0 && diffY > 0){
                                arrow6.angle = 180
                            }else if(diffX > 0 && diffY === 0){
                                arrow6.angle = 90
                            }else if(diffX < 0 && diffY === 0){
                                arrow6.angle = 270
                            }
                            arrow6.height = Math.sqrt((difX-parent.x)*(difX-parent.x)+(difY-parent.y)*(difY-parent.y))
                        }
                    }
                }
            }
            Rectangle{
                id : circle7
                x : 3*(parent.width/5)+parent.width/10-width/2
                y : 6*(parent.height/8)-parent.height/16-height/2
                width: 40
                height: 40
                radius: 20
                visible: false
                color: "red"
                z : parent.z+2
                border.width: 4
                border.color: "white"
                property Player p
                onPChanged: {
                    c7txt.text = Qt.binding(function() { return p.assignedPosition});
                }
                Text {
                    id: c7txt
                    color:"White"
                    font.pointSize: 9
                    text: ""
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    cursorShape: Qt.PointingHandCursor
                    property int mouseButtonClicked: Qt.NoButton
                    onReleased: playershadow.visible =false
                    onPressed: {
                        playershadow.visible = true
                        if (mouse.button  === Qt.LeftButton) {
                            circle7.p.assignedPosition = mapcontainer.showPlayerInstruction(parent.x,parent.y)
                            APIConnection.updatePlayerPosition(managerUser.token, circle7.p);
                            arrow7.visible = false
                            mouseButtonClicked = Qt.LeftButton
                        }else if (mouse.button === Qt.RightButton) {
                            mapcontainer.hideAll()
                            arrow7.visible = true
                            mouseButtonClicked = Qt.RightButton
                        }
                    }
                    onPositionChanged: {
                        if (mouseButtonClicked === Qt.LeftButton) {
                            circle7.p.assignedPosition = mapcontainer.showPlayerInstruction(parent.x,parent.y)
                            APIConnection.updatePlayerPosition(managerUser.token, circle7.p);
                            if((parent.x+mouseX)>(0*mapcontainer.width/5)&&(parent.x+mouseX)<(5*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(2*mapcontainer.height/8))&&((parent.y+mouseY)<(6*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                            if((parent.x+mouseX)>(1*mapcontainer.width/5)&&(parent.x+mouseX)<(4*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(1*mapcontainer.height/8))&&((parent.y+mouseY)<(2*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                            if((parent.x+mouseX)>(2*mapcontainer.width/5)&&(parent.x+mouseX)<(3*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(6*mapcontainer.height/8))&&((parent.y+mouseY)<(8*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                        }else if (mouseButtonClicked === Qt.RightButton){
                            var point =  mapToItem (parent, mouseX, mouseY);
                            var diffX = (point.x + parent.x);
                            var diffY = (point.y + parent.y);
                            var difX = mapcontainer.getX(diffX)
                            var difY = mapcontainer.getY(diffY)
                            diffX = difX - parent.x - parent.width/2
                            diffY = difY - parent.y - parent.height/2
                            var rad = Math.atan (diffY / diffX);
                            var deg = (rad * 180 / Math.PI);
                            if (diffX > 0 && diffY > 0) {
                                arrow7.angle = 90 + Math.abs (deg);
                            }
                            else if (diffX > 0 && diffY < 0) {
                                arrow7.angle = 90 - Math.abs (deg);
                            }
                            else if (diffX < 0 && diffY > 0) {
                                arrow7.angle = 270 - Math.abs (deg);
                            }
                            else if (diffX < 0 && diffY < 0) {
                                arrow7.angle = 270 + Math.abs (deg);
                            }else if(diffX === 0 && diffY < 0){
                                arrow7.angle = 0
                            }else if(diffX === 0 && diffY > 0){
                                arrow7.angle = 180
                            }else if(diffX > 0 && diffY === 0){
                                arrow7.angle = 90
                            }else if(diffX < 0 && diffY === 0){
                                arrow7.angle = 270
                            }
                            arrow7.height = Math.sqrt((difX-parent.x)*(difX-parent.x)+(difY-parent.y)*(difY-parent.y))
                        }
                    }
                }
            }
            Rectangle{
                id : circle8
                x : 4*(parent.width/5)+parent.width/10-width/2
                y : 6*(parent.height/8)-parent.height/16-height/2
                width: 40
                height: 40
                radius: 20
                visible: false
                color: "red"
                z : parent.z+2
                border.width: 4
                border.color: "white"
                property Player p
                onPChanged: {
                    //console.log("\t\tplayer changed to : " + p0.name) //console.log("\t\tplayer position to : " + p0.assignedPosition)
                    c8txt.text = Qt.binding(function() { return p.assignedPosition});
                }
                Text {
                    id: c8txt
                    color:"White"
                    font.pointSize: 9
                    text: ""
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    cursorShape: Qt.PointingHandCursor
                    property int mouseButtonClicked: Qt.NoButton
                    onReleased: playershadow.visible =false
                    onPressed: {
                        playershadow.visible = true
                        if (mouse.button  === Qt.LeftButton) {
                            circle8.p.assignedPosition = mapcontainer.showPlayerInstruction(parent.x,parent.y)
                            APIConnection.updatePlayerPosition(managerUser.token, circle8.p);
                            arrow8.visible = false
                            mouseButtonClicked = Qt.LeftButton
                        }else if (mouse.button === Qt.RightButton) {
                            mapcontainer.hideAll()
                            arrow8.visible = true
                            mouseButtonClicked = Qt.RightButton
                        }
                    }
                    onPositionChanged: {
                        if (mouseButtonClicked === Qt.LeftButton) {
                            circle8.p.assignedPosition = mapcontainer.showPlayerInstruction(parent.x,parent.y)
                            APIConnection.updatePlayerPosition(managerUser.token, circle8.p);
                            if((parent.x+mouseX)>(0*mapcontainer.width/5)&&(parent.x+mouseX)<(5*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(2*mapcontainer.height/8))&&((parent.y+mouseY)<(6*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                            if((parent.x+mouseX)>(1*mapcontainer.width/5)&&(parent.x+mouseX)<(4*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(1*mapcontainer.height/8))&&((parent.y+mouseY)<(2*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                            if((parent.x+mouseX)>(2*mapcontainer.width/5)&&(parent.x+mouseX)<(3*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(6*mapcontainer.height/8))&&((parent.y+mouseY)<(8*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                        }else if (mouseButtonClicked === Qt.RightButton){
                            var point =  mapToItem (parent, mouseX, mouseY);
                            var diffX = (point.x + parent.x);
                            var diffY = (point.y + parent.y);
                            var difX = mapcontainer.getX(diffX)
                            var difY = mapcontainer.getY(diffY)
                            diffX = difX - parent.x - parent.width/2
                            diffY = difY - parent.y - parent.height/2
                            var rad = Math.atan (diffY / diffX);
                            var deg = (rad * 180 / Math.PI);
                            if (diffX > 0 && diffY > 0) {
                                arrow8.angle = 90 + Math.abs (deg);
                            }
                            else if (diffX > 0 && diffY < 0) {
                                arrow8.angle = 90 - Math.abs (deg);
                            }
                            else if (diffX < 0 && diffY > 0) {
                                arrow8.angle = 270 - Math.abs (deg);
                            }
                            else if (diffX < 0 && diffY < 0) {
                                arrow8.angle = 270 + Math.abs (deg);
                            }else if(diffX === 0 && diffY < 0){
                                arrow8.angle = 0
                            }else if(diffX === 0 && diffY > 0){
                                arrow8.angle = 180
                            }else if(diffX > 0 && diffY === 0){
                                arrow8.angle = 90
                            }else if(diffX < 0 && diffY === 0){
                                arrow8.angle = 270
                            }
                            arrow8.height = Math.sqrt((difX-parent.x)*(difX-parent.x)+(difY-parent.y)*(difY-parent.y))
                        }
                    }
                }
            }
            Rectangle{
                id : circle9
                x : 0*(parent.width/5)+parent.width/10-width/2
                y : 5*(parent.height/8)-parent.height/16-height/2
                width: 40
                height: 40
                radius: 20
                visible: false
                color: "red"
                z : parent.z+2
                border.width: 4
                border.color: "white"
                property Player p
                onPChanged: {
                    //console.log("\t\tplayer changed to : " + p0.name) //console.log("\t\tplayer position to : " + p0.assignedPosition)
                    c9txt.text = Qt.binding(function() { return p.assignedPosition});
                }
                Text {
                    id: c9txt
                    color:"White"
                    font.pointSize: 9
                    text: ""
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    cursorShape: Qt.PointingHandCursor
                    property int mouseButtonClicked: Qt.NoButton
                    onReleased: playershadow.visible =false
                    onPressed: {
                        playershadow.visible = true
                        if (mouse.button  === Qt.LeftButton) {
                            circle9.p.assignedPosition = mapcontainer.showPlayerInstruction(parent.x,parent.y)
                            APIConnection.updatePlayerPosition(managerUser.token, circle9.p);
                            arrow9.visible = false
                            mouseButtonClicked = Qt.LeftButton
                        }else if (mouse.button === Qt.RightButton) {
                            mapcontainer.hideAll()
                            arrow9.visible = true
                            mouseButtonClicked = Qt.RightButton
                        }
                    }
                    onPositionChanged: {
                        if (mouseButtonClicked === Qt.LeftButton) {
                            circle9.p.assignedPosition = mapcontainer.showPlayerInstruction(parent.x,parent.y)
                            APIConnection.updatePlayerPosition(managerUser.token, circle9.p);
                            if((parent.x+mouseX)>(0*mapcontainer.width/5)&&(parent.x+mouseX)<(5*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(2*mapcontainer.height/8))&&((parent.y+mouseY)<(6*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                            if((parent.x+mouseX)>(1*mapcontainer.width/5)&&(parent.x+mouseX)<(4*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(1*mapcontainer.height/8))&&((parent.y+mouseY)<(2*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                            if((parent.x+mouseX)>(2*mapcontainer.width/5)&&(parent.x+mouseX)<(3*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(6*mapcontainer.height/8))&&((parent.y+mouseY)<(8*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                        }else if (mouseButtonClicked === Qt.RightButton){
                            var point =  mapToItem (parent, mouseX, mouseY);
                            var diffX = (point.x + parent.x);
                            var diffY = (point.y + parent.y);
                            var difX = mapcontainer.getX(diffX)
                            var difY = mapcontainer.getY(diffY)
                            diffX = difX - parent.x - parent.width/2
                            diffY = difY - parent.y - parent.height/2
                            var rad = Math.atan (diffY / diffX);
                            var deg = (rad * 180 / Math.PI);
                            if (diffX > 0 && diffY > 0) {
                                arrow9.angle = 90 + Math.abs (deg);
                            }
                            else if (diffX > 0 && diffY < 0) {
                                arrow9.angle = 90 - Math.abs (deg);
                            }
                            else if (diffX < 0 && diffY > 0) {
                                arrow9.angle = 270 - Math.abs (deg);
                            }
                            else if (diffX < 0 && diffY < 0) {
                                arrow9.angle = 270 + Math.abs (deg);
                            }else if(diffX === 0 && diffY < 0){
                                arrow9.angle = 0
                            }else if(diffX === 0 && diffY > 0){
                                arrow9.angle = 180
                            }else if(diffX > 0 && diffY === 0){
                                arrow9.angle = 90
                            }else if(diffX < 0 && diffY === 0){
                                arrow9.angle = 270
                            }
                            arrow9.height = Math.sqrt((difX-parent.x)*(difX-parent.x)+(difY-parent.y)*(difY-parent.y))
                        }
                    }
                }
            }
            Rectangle{
                id : circle10
                x : 4*(parent.width/5)+parent.width/10-width/2
                y : 4*(parent.height/8)-parent.height/16-height/2
                width: 40
                height: 40
                radius: 20
                visible: false
                color: "red"
                z : parent.z+2
                border.width: 4
                border.color: "white"
                property Player p
                onPChanged: {
                    c10txt.text = Qt.binding(function() { return p.assignedPosition});
                }
                Text {
                    id: c10txt
                    color:"White"
                    font.pointSize: 9
                    text: ""
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    cursorShape: Qt.PointingHandCursor
                    property int mouseButtonClicked: Qt.NoButton
                    onReleased: playershadow.visible =false
                    onPressed: {
                        playershadow.visible = true
                        if (mouse.button  === Qt.LeftButton) {
                            circle10.p.assignedPosition = mapcontainer.showPlayerInstruction(parent.x,parent.y)
                            APIConnection.updatePlayerPosition(managerUser.token, circle10.p);
                            arrow10.visible = false
                            mouseButtonClicked = Qt.LeftButton
                        }else if (mouse.button === Qt.RightButton) {
                            mapcontainer.hideAll()
                            arrow10.visible = true
                            mouseButtonClicked = Qt.RightButton
                        }
                    }
                    onPositionChanged: {
                        if (mouseButtonClicked === Qt.LeftButton) {
                            circle10.p.assignedPosition = mapcontainer.showPlayerInstruction(parent.x,parent.y)
                            APIConnection.updatePlayerPosition(managerUser.token, circle10.p);
                            if((parent.x+mouseX)>(0*mapcontainer.width/5)&&(parent.x+mouseX)<(5*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(2*mapcontainer.height/8))&&((parent.y+mouseY)<(6*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                            if((parent.x+mouseX)>(1*mapcontainer.width/5)&&(parent.x+mouseX)<(4*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(1*mapcontainer.height/8))&&((parent.y+mouseY)<(2*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                            if((parent.x+mouseX)>(2*mapcontainer.width/5)&&(parent.x+mouseX)<(3*mapcontainer.width/5)
                                    &&((parent.y+mouseY)>(6*mapcontainer.height/8))&&((parent.y+mouseY)<(8*mapcontainer.height/8))){
                                parent.x = mapcontainer.getX(parent.x+mouseX)-parent.width/2
                                parent.y = mapcontainer.getY(parent.y+mouseY)-parent.height/2
                            }
                        }else if (mouseButtonClicked === Qt.RightButton){
                            var point =  mapToItem (parent, mouseX, mouseY);
                            var diffX = (point.x + parent.x);
                            var diffY = (point.y + parent.y);
                            var difX = mapcontainer.getX(diffX)
                            var difY = mapcontainer.getY(diffY)
                            diffX = difX - parent.x - parent.width/2
                            diffY = difY - parent.y - parent.height/2
                            var rad = Math.atan (diffY / diffX);
                            var deg = (rad * 180 / Math.PI);
                            if (diffX > 0 && diffY > 0) {
                                arrow10.angle = 90 + Math.abs (deg);
                            }else if(diffX === 0 && diffY < 0){
                                arrow10.angle = 0
                            }else if(diffX === 0 && diffY > 0){
                                arrow10.angle = 180
                            }else if(diffX > 0 && diffY === 0){
                                arrow10.angle = 90
                            }else if(diffX < 0 && diffY === 0){
                                arrow10.angle = 270
                            }
                            else if (diffX > 0 && diffY < 0) {
                                arrow10.angle = 90 - Math.abs (deg);
                            }
                            else if (diffX < 0 && diffY > 0) {
                                arrow10.angle = 270 - Math.abs (deg);
                            }
                            else if (diffX < 0 && diffY < 0) {
                                arrow10.angle = 270 + Math.abs (deg);
                            }
                            arrow10.height = Math.sqrt((difX-parent.x)*(difX-parent.x)+(difY-parent.y)*(difY-parent.y))
                        }
                    }
                }
            }


            Rectangle {
                id : arrowgk
                color: "transparent"
                x: goal.x+(goal.width/2)-width/2; y : goal.y+(goal.height/2)-height
                visible: false
                width: 40; height: 10
                z :parent.z+1
                property int angle: 0
                property int originX: width/2
                property int originY: height
                smooth: true
                transform: Rotation { origin.x: arrowgk.originX; origin.y: arrowgk.originY; angle: arrowgk.angle}
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.fill: parent
                    source: "qrc:/icons/blue.png"
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Rectangle {
                id : arrow1
                color: "transparent"
                x: circle1.x+(circle1.width/2)-width/2; y : circle1.y+(circle1.height/2)-height
                visible: false
                width: 40; height: 10
                z :parent.z+1
                property int angle: 0
                property int originX: width/2
                property int originY: height
                smooth: true
                transform: Rotation { origin.x: arrow1.originX; origin.y: arrow1.originY; angle: arrow1.angle}
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.fill: parent
                    source: "qrc:/icons/blue.png"
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Rectangle {
                id : arrow2
                color: "transparent"
                x: circle2.x+(circle2.width/2)-width/2; y : circle2.y+(circle2.height/2)-height
                visible: false
                width: 40; height: 10
                z :parent.z+1
                property int angle: 0
                property int originX: width/2
                property int originY: height
                smooth: true
                transform: Rotation { origin.x: arrow2.originX; origin.y: arrow2.originY; angle: arrow2.angle}
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.fill: parent
                    source: "qrc:/icons/blue.png"
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Rectangle {
                id : arrow3
                color: "transparent"
                x: circle3.x+(circle3.width/2)-width/2; y : circle3.y+(circle3.height/2)-height
                visible: false
                width: 40; height: 10
                z :parent.z+1
                property int angle: 0
                property int originX: width/2
                property int originY: height
                smooth: true
                transform: Rotation { origin.x: arrow3.originX; origin.y: arrow3.originY; angle: arrow3.angle}
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.fill: parent
                    source: "qrc:/icons/blue.png"
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Rectangle {
                id : arrow4
                color: "transparent"
                x: circle4.x+(circle4.width/2)-width/2; y : circle4.y+(circle4.height/2)-height
                visible: false
                width: 40; height: 10
                z :parent.z+1
                property int angle: 0
                property int originX: width/2
                property int originY: height
                smooth: true
                transform: Rotation { origin.x: arrow4.originX; origin.y: arrow4.originY; angle: arrow4.angle}
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.fill: parent
                    source: "qrc:/icons/blue.png"
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Rectangle {
                id : arrow5
                color: "transparent"
                x: circle5.x+(circle5.width/2)-width/2; y : circle5.y+(circle5.height/2)-height
                visible: false
                width: 40; height: 10
                z :parent.z+1
                property int angle: 0
                property int originX: width/2
                property int originY: height
                smooth: true
                transform: Rotation { origin.x: arrow5.originX; origin.y: arrow5.originY; angle: arrow5.angle}
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.fill: parent
                    source: "qrc:/icons/blue.png"
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Rectangle {
                id : arrow6
                color: "transparent"
                x: circle6.x+(circle6.width/2)-width/2; y : circle6.y+(circle6.height/2)-height
                visible: false
                width: 40; height: 10
                z :parent.z+1
                property int angle: 0
                property int originX: width/2
                property int originY: height
                smooth: true
                transform: Rotation { origin.x: arrow6.originX; origin.y: arrow6.originY; angle: arrow6.angle}
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.fill: parent
                    source: "qrc:/icons/blue.png"
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Rectangle {
                id : arrow7
                color: "transparent"
                x: circle7.x+(circle7.width/2)-width/2; y : circle7.y+(circle7.height/2)-height
                visible: false
                width: 40; height: 10
                z :parent.z+1
                property int angle: 0
                property int originX: width/2
                property int originY: height
                smooth: true
                transform: Rotation { origin.x: arrow7.originX; origin.y: arrow7.originY; angle: arrow7.angle}
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.fill: parent
                    source: "qrc:/icons/blue.png"
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Rectangle {
                id : arrow8
                color: "transparent"
                x: circle8.x+(circle8.width/2)-width/2; y : circle8.y+(circle8.height/2)-height
                visible: false
                width: 40; height: 10
                z :parent.z+1
                property int angle: 0
                property int originX: width/2
                property int originY: height
                smooth: true
                transform: Rotation { origin.x: arrow8.originX; origin.y: arrow8.originY; angle: arrow8.angle}
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.fill: parent
                    source: "qrc:/icons/blue.png"
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Rectangle {
                id : arrow9
                color: "transparent"
                x: circle9.x+(circle9.width/2)-width/2; y : circle9.y+(circle9.height/2)-height
                visible: false
                width: 40; height: 10
                z :parent.z+1
                property int angle: 0
                property int originX: width/2
                property int originY: height
                smooth: true
                transform: Rotation { origin.x: arrow9.originX; origin.y: arrow9.originY; angle: arrow9.angle}
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.fill: parent
                    source: "qrc:/icons/blue.png"
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Rectangle {
                id : arrow10
                color: "transparent"
                x: circle10.x+(circle10.width/2)-width/2; y : circle10.y+(circle10.height/2)-height
                visible: false
                width: 40; height: 10
                z :parent.z+1
                property int angle: 0
                property int originX: width/2
                property int originY: height
                smooth: true
                transform: Rotation { origin.x: arrow10.originX; origin.y: arrow10.originY; angle: arrow10.angle}
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.fill: parent
                    source: "qrc:/icons/blue.png"
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Rectangle{
                id : offside
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width-20
                height: 30
                visible: true
                x : 0
                y : 6*(parent.height/7)
                z : parent.parent.z+1
                Image {

                    anchors.fill: parent
                    source: "qrc:/icons/Blackline.png"
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    drag.target: parent;
                    drag.axis:  Drag.YAxis
                    drag.minimumY: 4*(parent.parent.height/7)
                    drag.maximumY: 6*(parent.parent.height/7)
                }
            }

            MouseArea{
                id : mouse1
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    mapcontainer.hideAll()
                    teaminstructionrect.visible = true
                }
            }
        }
    }

    Rectangle{
        id: detailes
        anchors.right: parent.right
        anchors.top : parent.top
        width: parent.width/2-5
        height: parent.height
        z:parent.z+1
        MouseArea{
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
        }
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#34537a" }
            GradientStop { position: 0.50; color: "#5283bf" }
            GradientStop { position: 1.0; color: "#6dafff" }
        }

        Rectangle{
            id : teaminstruction
            width: parent.width/2
            height: 30
            border.color: "gray"
            color: "light gray"
            anchors.left: parent.left
            anchors.top: parent.top
            Text {
                id : teaminstructiontext
                color: "black"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.family:"Times"
                //font.family: "Comic Sans MS"
                font.bold: true
                font.italic: true
                font.pointSize: 10
                text: qsTr("Team Instruction")
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: {
                    teaminstruction.color = "gray"
                }
                onExited: {
                    teaminstruction.color = "light gray"
                }
                onClicked: {
                    mapcontainer.hideAll()
                    teaminstructionrect.visible = trueupdateOffsideTrap
                }
            }
        }

        Rectangle{
            id : teaminstructionrect
            width: parent.width/2-20
            height: parent.height
            anchors.left: parent.left
            anchors.top: teaminstruction.bottom
            color: "transparent"

            Column {
                spacing: 15
                padding: 20
                CheckBox {
                    text: qsTr("Offside Trap")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdateOffsideTrap()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
                CheckBox {
                    text: qsTr("Hard Tackle")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdateHardTackle()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
                CheckBox {
                    text: qsTr("High line Closing Down")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdateHighLineClosingDown()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
                CheckBox {
                    text: qsTr("Offside Line")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdateOffsideLine()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
                CheckBox {
                    text: qsTr("Prevent Pass")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdatePreventPass()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
                CheckBox {
                    text: qsTr("Preventing Cut Inside")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdatePreventingCutInside()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
                CheckBox {
                    text: qsTr("Tight Marking")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdateTightMarking()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
                CheckBox {
                    text: qsTr("Run Down The Line")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdateRunDownTheLine()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
                CheckBox {
                    text: qsTr("Prefer Dribble Over Pass")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdatePreferDribbleOverPass()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
                CheckBox {
                    text: qsTr("Long Passes")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdateLongPasses()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
            }
        }

        Rectangle{
            id : gkRect
            width: parent.width/2-10
            height: parent.height
            anchors.left: parent.left
            anchors.top: teaminstruction.bottom
            visible: false
            color: "transparent"
            z:parent.z+1
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
            }
            Rectangle{
                id : gkinstruction
                width: parent.width
                height: 30
                border.color: "transparent"
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                z:parent.z+1
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
                Text {
                    id : gkinstructiontext
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.family:"Times"
                    font.bold: true
                    font.italic: true
                    font.pointSize: 10
                    text: qsTr("Goal Keeper")
                }
            }

            Column {
                anchors.top: gkinstruction.bottom
                spacing: 5
                padding: 20
                CheckBox {
                    text: qsTr("Gets forward in corner kick")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdateForwardInCornerKick()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
                CheckBox {
                    text: qsTr("Rush out")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdateRushOut()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
                CheckBox {
                    text: qsTr("Deliver the ball to the defender")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdatePassBallToDefender()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
            }

        }

        Rectangle{
            id : sweeperRect
            width: parent.width/2-10
            height: parent.height
            anchors.left: parent.left
            anchors.top: teaminstruction.bottom
            visible: false
            color: "transparent"
            z:parent.z+1
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
            }
            Rectangle{
                id : sweeperinstruction
                width: parent.width
                height: 30
                border.color: "transparent"
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                z:parent.z+1
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
                Text {
                    id : sweeperinstructiontext
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.family:"Times"
                    font.bold: true
                    font.italic: true
                    font.pointSize: 10
                    text: qsTr("Sweeper")
                }
            }

            Column {
                anchors.top: sweeperinstruction.bottom
                spacing: 5
                padding: 20
                CheckBox {
                    text: qsTr("Shoots from distance")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
                CheckBox {
                    text: qsTr("Gets further forward")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
                CheckBox {
                    text: qsTr("Tries killes ball often")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdateTriesKillerBallOften()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
                CheckBox {
                    text: qsTr("Stay back all the time")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdateStayBack()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
                CheckBox {
                    text: qsTr("Run with ball rarely")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
            }
        }

        Rectangle{
            id : cdRect
            width: parent.width/2-10
            height: parent.height
            anchors.left: parent.left
            anchors.top: teaminstruction.bottom
            visible: false
            color: "transparent"
            z:parent.z+1
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
            }
            Rectangle{
                id : cdinstruction
                width: parent.width
                height: 30
                border.color: "transparent"
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                z:parent.z+1
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
                Text {
                    id : cdinstructiontext
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.family:"Times"
                    font.bold: true
                    font.italic: true
                    font.pointSize: 10
                    text: qsTr("Central Defender")
                }
            }

            Column {
                anchors.top: cdinstruction.bottom
                spacing: 5
                padding: 20
                CheckBox {
                    text: qsTr("Tries to play way out of trouble")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
                CheckBox {
                    text: qsTr("Stay back all the times")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
                CheckBox {
                    text: qsTr("Shoot from distance")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
            }
        }

        Rectangle{
            id : fbRect
            width: parent.width/2-10
            height: parent.height
            anchors.left: parent.left
            anchors.top: teaminstruction.bottom
            visible: false
            color: "transparent"
            z:parent.z+1
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
            }
            Rectangle{
                id : fbinstruction
                width: parent.width
                height: 30
                border.color: "transparent"
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                z:parent.z+1
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
                Text {
                    id : fbinstructiontext
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.family:"Times"
                    font.bold: true
                    font.italic: true
                    font.pointSize: 10
                    text: qsTr("Full Back")
                }
            }

            Column {
                anchors.top: fbinstruction.bottom
                spacing: 5
                padding: 20
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdateCutInside()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Cut inside")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Plays no through balls")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Plays one-two")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Knock the ball past opponent")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Curls ball")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdateCrossTheBallMoreOften()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Cross th ball more often ")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Hug the Line")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Switch ball to the other flank")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Gets forward whenever possible")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Cross from deep")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Cross from byline")
                    checked: false
                }
                CheckBox {                 z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Shoot from distance")
                    checked: false
                }
            }

        }

        Rectangle{
            id : sdmRect
            width: parent.width/2-10
            height: parent.height
            anchors.left: parent.left
            anchors.top: teaminstruction.bottom
            visible: false
            color: "transparent"
            Rectangle{
                id : sdminstruction
                width: parent.width
                height: 30
                border.color: "transparent"
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    id : sdminstructiontext
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.family:"Times"
                    font.bold: true
                    font.italic: true
                    font.pointSize: 9
                    text: qsTr("Side Defensive Midifielder")
                }
            }

            Column {
                anchors.top: sdminstruction.bottom
                spacing: 5
                padding: 20
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Cut inside")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Plays no through balls")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Plays one-two")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("knock the ball past opponent")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Curls ball")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Cross th ball more often ")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Hug the Line")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Switch ball to the other flank")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Gets forward whenever possible")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Cross from deep")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Cross from byline")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Shoot from distance")
                    checked: false
                }
            }

        }

        Rectangle{
            id : dmRect
            width: parent.width/2-10
            height: parent.height
            anchors.left: parent.left
            anchors.top: teaminstruction.bottom
            visible: false
            color: "transparent"
            Rectangle{
                id : dminstruction
                width: parent.width
                height: 30
                border.color: "transparent"
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                z:parent.z+1
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
                Text {
                    id : dminstructiontext
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.family:"Times"
                    font.bold: true
                    font.italic: true
                    font.pointSize: 10
                    text: qsTr("Defensive Midifielder")
                }
            }

            Column {
                anchors.top: dminstruction.bottom
                spacing: 5
                padding: 20
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Box to box")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Gets forward whenever")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdateDictatesTempo()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Dictates tempo")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Does not dive into tackles")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdateComesDeepToGetBall()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("comes deep to get the ball")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Likes switch ball to the other flanks")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Looks for pass rather \nthan attempting to score")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Shoot from distance")
                    checked: false
                }
            }

        }

        Rectangle{
            id : mfRect
            width: parent.width/2-10
            height: parent.height
            anchors.left: parent.left
            anchors.top: teaminstruction.bottom
            visible: false
            color: "transparent"
            Rectangle{
                id : mfinstruction
                width: parent.width
                height: 30
                border.color: "transparent"
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    id : mfinstructiontext
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.family:"Times"
                    font.bold: true
                    font.italic: true
                    font.pointSize: 10
                    text: qsTr("Middle Fielder")
                }
            }

            Column {
                anchors.top: mfinstruction.bottom
                spacing: 5
                padding: 20
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdateStopsPlay()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Stops play")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Run with ball through center")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Gets forward whenever possible")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Tries tricks")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Dictates Tempo")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Does not ddive into tackles")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Shoot from distance")
                    checked: false
                }
            }

        }

        Rectangle{
            id : amRect
            width: parent.width/2-10
            height: parent.height
            anchors.left: parent.left
            anchors.top: teaminstruction.bottom
            visible: false
            color: "transparent"
            Rectangle{
                id : aminstruction
                width: parent.width
                height: 30
                border.color: "transparent"
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    id : aminstructiontext
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.family:"Times"
                    font.bold: true
                    font.italic: true
                    font.pointSize: 10
                    text: qsTr("Attacking Midifielder")
                }
            }

            Column {
                anchors.top: aminstruction.bottom
                spacing: 5
                padding: 20
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Stops play")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Run with ball through center")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdateGetsForward()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Gets forward whenever possible")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Tries tricks")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdateShootFromDistance()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Shoot from distance")
                    checked: false
                }
            }

        }

        Rectangle{
            id : smRect
            width: parent.width/2-10
            height: parent.height
            anchors.left: parent.left
            anchors.top: teaminstruction.bottom
            visible: false
            color: "transparent"
            Rectangle{
                id : sminstruction
                width: parent.width
                height: 30
                border.color: "transparent"
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    id : sminstructiontext
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.family:"Times"
                    font.bold: true
                    font.italic: true
                    font.pointSize: 10
                    text: qsTr("Side Midifielder")
                }
            }

            Column {
                anchors.top: sminstruction.bottom
                spacing: 5
                padding: 20
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Likes to beat man repeatedly")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Likes to lab the keeper")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Knocks  the ball past the opponent")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Tries tricks")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Runs with ball down left")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Looks for pass rather \nthan attempting to score")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdateMovesIntoChannels()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Move into channels")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Shoot from distance")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Cross from deep")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Cross from touchline")
                    checked: false
                }
            }

        }

        Rectangle{
            id : awRect
            width: parent.width/2-10
            height: parent.height
            anchors.left: parent.left
            anchors.top: teaminstruction.bottom
            visible: false
            color: "transparent"
            Rectangle{
                id : awinstruction
                width: parent.width
                height: 30
                border.color: "transparent"
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    id : awinstructiontext
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.family:"Times"
                    font.bold: true
                    font.italic: true
                    font.pointSize: 10
                    text: qsTr("Attacking Wingers")
                }
            }

            Column {
                anchors.top: awinstruction.bottom
                spacing: 5
                padding: 20
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Likes to beat man repeatedly")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Likes to lab the keeper")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Knocks the ball past the opponent")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Tries tricks")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Runs with ball down left")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Looks for pass rather than attempting to score")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Move into channels")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Shoot from distance")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Cross from deep")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Cross from touchline")
                    checked: false
                }
            }

        }

        Rectangle{
            id : fsRect
            width: parent.width/2-10
            height: parent.height
            anchors.left: parent.left
            anchors.top: teaminstruction.bottom
            visible: false
            color: "transparent"
            Rectangle{
                id : fsinstruction
                width: parent.width
                height: 30
                border.color: "transparent"
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    id : fsinstructiontext
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.family:"Times"
                    font.bold: true
                    font.italic: true
                    font.pointSize: 10
                    text: qsTr("Forward and Striker")
                }
            }

            Column {
                anchors.top: fsinstruction.bottom
                spacing: 5
                padding: 20
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Gets into oppostion area")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdateRoundToKeeper()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Likes to round the keeper")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
							monitorControl.UpdateBeatOffsideTrap()
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Likes to beat the offside")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Attempts overhead kicks")
                    checked: false
                }
            }

        }

        Rectangle{
            id : individualinstructionrect
            width: parent.width/2-20
            height: parent.height
            anchors.right: parent.right
            anchors.top: parent.top
            visible: false
            color: "transparent"
            z:parent.z+1
            Rectangle{
                id : individualinstruction
                width: parent.width
                height: 30
                border.color: "gray"
                color: "light gray"
                z:parent.z+1
                anchors.horizontalCenter: parent.horizontalCenter
                MouseArea
                {
                    anchors.fill:parent
                    cursorShape: Qt.PointingHandCursor
                }

                Text {
                    id : individualinstructiontext
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.family:"Times"
                    font.bold: true
                    font.italic: true
                    font.pointSize: 10
                    text: qsTr("Individual Instruction")
                }
            }

            Column {
                anchors.top : individualinstruction.bottom
                spacing: 5
                padding: 20
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Zonel Mark")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Free Role")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Challenge The Referee")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Shoots From Distance")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Shoots With Power")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Uses Outside Of Foot")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Tries Long Range Freekick")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Hits FreeKick With Power")
                    checked: false
                }
                CheckBox {
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                                parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                    text: qsTr("Plays One-Two")
                    checked: false
                }


            }

        }
		Rectangle{
			id: sendTactic
			width: parent.width/2
			height: 30
			color:"light gray"
			anchors.right: parent.right
			anchors.top: parent.top
			anchors.topMargin: height
            property bool hoveredornot : false
			Text {
				id: sendTacticText
                color: "black"
				text: qsTr("Set Tactic")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.family:"Times"
                font.bold: true
                font.italic: true
                font.pointSize: 10
			}
			MouseArea
			{
				id:mouseAreaSendTactic
                anchors.fill:parent
                onHoveredChanged: {
                    if(sendTactic.hoveredornot){
                        sendTactic.color = "light gray"
                        sendTactic.hoveredornot = false
                    }else{
                        sendTactic.color = "gray"
                        sendTactic.hoveredornot = true
                    }
                }
				onClicked: {
                    if(monitorControl.isConnected() ){monitorControl.sendTactics()}
                }
			}
		}
        Rectangle{
            id : antiOpponentTacticRect
            width: parent.width/2
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            height: 30
            border.color: "gray"
            color: "light gray"
            z:parent.z+1
            property bool hoveredornot : false
            Text {
                id : antiOpponentTacticRecttext
                color: "black"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.family:"Times"
                font.bold: true
                font.italic: true
                font.pointSize: 10
                text: qsTr("Anti-Opponent Tactic")
            }
            MouseArea
            {
                id:mouseAreatTactic
                anchors.fill:parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled:true
                onHoveredChanged: {
                    if(antiOpponentTacticRect.hoveredornot){
                        antiOpponentTacticRect.color = "light gray"
                        antiOpponentTacticRect.hoveredornot = false
                    }else{
                        antiOpponentTacticRect.color = "gray"
                        antiOpponentTacticRect.hoveredornot = true
                    }
                }
                onClicked: {
                    app.callinsidepage2(antiOpponentTactic)
                }
            }
        }
    }
}

















/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:14;invisible:true}
}
 ##^##*/
