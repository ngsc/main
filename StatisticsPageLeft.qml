import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

import com.Game.APIConnection 1.0
import com.Game.Player 1.0


Rectangle {
    id: team_home_statistic_page
	anchors.right: parent.right
	radius: 20
    property string titleBar: "Team Left Statistics"
    property alias text: team_home_statistic_page_text.text
	color: "transparent"
	TextArea{
		anchors.top: parent.top
		anchors.left: parent.left
		anchors.right: parent.right
		height: 300
        id:team_home_statistic_page_text
        font.pointSize: 10
        font.family: "Comic Sans MS"
		textColor: "white"
        backgroundVisible: false
		verticalAlignment: TextEdit.AlignVCenter
		/*style: TextAreaStyle {
		backgroundColor: "blue"
		}*/
		text: ""
	}
	Panel5Button{
        id: overview_button
        anchors.top: team_home_statistic_page_text.bottom
        anchors.left: parent.left
        button_text: "Team Overview"
        MouseArea
        {
            anchors.fill: parent
            hoverEnabled: true
            onPressed:  {//console.log(stackView.__currentItem.objectName.toString())
                team_home_statistic_page.text= monitorControl.getTeamRightStats();
            }
            onEntered:
            {
                overview_button.button_bottom_line_visibility=true
            }
            onExited:
            {
                overview_button.button_bottom_line_visibility=false
            }
        }

    }
	Panel5Button{
        id: player_stats_button
        anchors.top: team_home_statistic_page_text.bottom
        anchors.left: overview_button.right
        button_text: "Player Stamina"
        MouseArea
        {
            anchors.fill: parent
            hoverEnabled: true
            onPressed:  {//console.log(stackView.__currentItem.objectName.toString())
                team_home_statistic_page.text= monitorControl.getPlayerLeftStats();
            }
            onEntered:
            {
                player_stats_button.button_bottom_line_visibility=true
            }
            onExited:
            {
                player_stats_button.button_bottom_line_visibility=false
            }
        }

    }	
	Panel5Button{
        id: interception_button
        anchors.top: team_home_statistic_page_text.bottom
        anchors.left: player_stats_button.right
        button_text: "Interceptions"
        MouseArea
        {
            anchors.fill: parent
            hoverEnabled: true
            onPressed:  {//console.log(stackView.__currentItem.objectName.toString())
                team_home_statistic_page.text= monitorControl.getLeftInterception();
            }
            onEntered:
            {
                interception_button.button_bottom_line_visibility=true
            }
            onExited:
            {
                interception_button.button_bottom_line_visibility=false
            }
        }

    }	
	Panel5Button{
        id: foul_button
        anchors.top: team_home_statistic_page_text.bottom
        anchors.left: interception_button.right
        button_text: "Fouls"
        MouseArea
        {
            anchors.fill: parent
            hoverEnabled: true
            onPressed:  {//console.log(stackView.__currentItem.objectName.toString())
                team_home_statistic_page.text= monitorControl.getLeftFoul();
            }
            onEntered:
            {
                foul_button.button_bottom_line_visibility=true
            }
            onExited:
            {
                foul_button.button_bottom_line_visibility=false
            }
        }

    }	
	Panel5Button{
        id: tackle_button
        anchors.top: foul_button.bottom
        anchors.left: foul_button.left
        button_text: "Tackles"
        MouseArea
        {
            anchors.fill: parent
            hoverEnabled: true
            onPressed:  {//console.log(stackView.__currentItem.objectName.toString())
                team_home_statistic_page.text= monitorControl.getLeftTackle();
            }
            onEntered:
            {
                tackle_button.button_bottom_line_visibility=true
            }
            onExited:
            {
                tackle_button.button_bottom_line_visibility=false
            }
        }

    }	
	Panel5Button{
        id: goals_button
        anchors.top: foul_button.bottom
        anchors.left: parent.left
        button_text: "Goals"
        MouseArea
        {
            anchors.fill: parent
            hoverEnabled: true
            onPressed:  {//console.log(stackView.__currentItem.objectName.toString())
                team_home_statistic_page.text= monitorControl.getLeftGoal();
            }
            onEntered:
            {
                goals_button.button_bottom_line_visibility=true
            }
            onExited:
            {
                goals_button.button_bottom_line_visibility=false
            }
        }

    }	
	Panel5Button{
        id: yellowcard_button
        anchors.top: foul_button.bottom
        anchors.left: goals_button.right
        button_text: "Yellow Cards"
        MouseArea
        {
            anchors.fill: parent
            hoverEnabled: true
            onPressed:  {//console.log(stackView.__currentItem.objectName.toString())
                team_home_statistic_page.text= monitorControl.getLeftYellowCard();
            }
            onEntered:
            {
                yellowcard_button.button_bottom_line_visibility=true
            }
            onExited:
            {
                yellowcard_button.button_bottom_line_visibility=false
            }
        }

    }	
	Panel5Button{
        id: redcard_button
        anchors.top: foul_button.bottom
        anchors.left: yellowcard_button.right
        button_text: "Red Cards"
        MouseArea
        {
            anchors.fill: parent
            hoverEnabled: true
            onPressed:  {//console.log(stackView.__currentItem.objectName.toString())
                team_home_statistic_page.text= monitorControl.getLeftRedCard();
            }
            onEntered:
            {
                redcard_button.button_bottom_line_visibility=true
            }
            onExited:
            {
                redcard_button.button_bottom_line_visibility=false
            }
        }

    }
}
