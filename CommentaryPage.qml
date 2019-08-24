import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

import com.Game.APIConnection 1.0
import com.Game.Player 1.0



Rectangle {
    id: commentaryPage
	anchors.right: parent.right
	radius: 20
    property string titleBar: "Commentary Report"
	property alias text: commentaryPage_text.text
	color: "transparent"
	TextArea{
		anchors.fill: parent
		id:commentaryPage_text
        font.pointSize: 10
        font.family: "Comic Sans MS"
		textColor: "white"
        backgroundVisible: false
		/*style: TextAreaStyle {
		backgroundColor: "blue"
		}*/
		text: "Commentary will be displayed here"
	}
}
