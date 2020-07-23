import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

import com.Game.APIConnection 1.0
import com.Game.Player 1.0


Rectangle {
    id: team_away_statistic_page
	anchors.right: parent.right
	radius: 20
    property string titleBar: "Team Right Statistics"
	property alias text: team_away_statistic_page_text.text
	color: "transparent"
	TextArea{
		anchors.top: parent.top
		anchors.left: parent.left
		anchors.right: parent.right
		height: 300
		id:team_away_statistic_page_text
        font.pointSize: 10
        font.family: Constants.primaryFont ? Constants.primaryFont.name: null
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
        anchors.top: team_away_statistic_page_text.bottom
        anchors.left: parent.left
        button_text: "Team Overview"
        MouseArea
        {
            anchors.fill: parent
            hoverEnabled: true
            onPressed:  {//console.log(stackView.__currentItem.objectName.toString())
                team_away_statistic_page.text = monitorControl.getTeamLeftStats();
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
        anchors.top: team_away_statistic_page_text.bottom
        anchors.left: overview_button.right
        button_text: "Player Stamina"
        MouseArea
        {
            anchors.fill: parent
            hoverEnabled: true
            onPressed:  {//console.log(stackView.__currentItem.objectName.toString())
				team_away_statistic_page.text= monitorControl.getPlayerRightStats();
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
        anchors.top: team_away_statistic_page_text.bottom
        anchors.left: player_stats_button.right
        button_text: "Interceptions"
        MouseArea
        {
            anchors.fill: parent
            hoverEnabled: true
            onPressed:  {//console.log(stackView.__currentItem.objectName.toString())
				team_away_statistic_page.text= monitorControl.getRightInterception();
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
        anchors.top: team_away_statistic_page_text.bottom
        anchors.left: interception_button.right
        button_text: "Fouls"
        MouseArea
        {
            anchors.fill: parent
            hoverEnabled: true
            onPressed:  {//console.log(stackView.__currentItem.objectName.toString())
				team_away_statistic_page.text= monitorControl.getRightFoul();
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
				team_away_statistic_page.text= monitorControl.getRightTackle();
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
				team_away_statistic_page.text= monitorControl.getRightGoal();
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
				team_away_statistic_page.text= monitorControl.getRightYellowCard();
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
				team_away_statistic_page.text= monitorControl.getRightRedCard();
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
