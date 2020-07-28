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
    id: inside_2
    color: "transparent"
    anchors.horizontalCenter: parent.horizontalCenter
    property string titleBar: "Inside 2"

    ColumnLayout
    {
        anchors.horizontalCenter: parent.horizontalCenter
        width: 300
        height: 400
        z:parent.z+1
        ButtonMainPage
        {
            id: knowledge
            width: 300
            property bool boldfont_1: false
            property bool italicfont_1: false
            boldfont: knowledge.boldfont_1
            italicfont: knowledge.italicfont_1
            //anchors.leftMargin: 30
            button_text: qsTr("Knowledge Survey")
            enabled: managerUser.quizPass === false
            Rectangle{
                id: knowledgehint
                x:300
                y:50
                radius: 10
                implicitWidth: knowledgehinttext.width+2
                height: knowledgehinttext.height+2
                visible: false
                ///anchors.leftMargin: 30
                color: "#DAF7A6"
                Text {
                    id: knowledgehinttext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    padding: 5
                    font.pointSize: 9
                    text: !managerUser.quizPass ? qsTr("Take quick soccr knowledge quiz") : qsTr("Already passed knowledge quiz :)");
                    color:"gray"
                }
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: managerUser.quizPass === false
                cursorShape: managerUser.quizPass ? Qt.ArrowCursor : Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton
                onPressed: {parent.state="clicked"}
                onReleased: {parent.state="unclicked"}
                onHoveredChanged: {
                    if(knowledge.boldfont_1 === false){
                        knowledge.boldfont_1 = true
                        knowledge.italicfont_1 = true
                        knowledgehint.visible = true
                    }else{
                        knowledge.boldfont_1 = false
                        knowledge.italicfont_1 = false
                        knowledgehint.visible = false
                    }
                }
                onClicked: {
                    app.callinsidepage2(knowledgeSurvey);
                    knowledgeSurvey.start_count_down()
                }
            }
        }

        ButtonMainPage
        {
            id: arsenal
            width: 300
            property bool boldfont_1: false
            property bool italicfont_1: false
            boldfont: arsenal.boldfont_1
            //italicfont: arsenal.italicfont_1
            //anchors.leftMargin: 30
            enabled: managerUser.quizPass
            button_text: qsTr("Club Selection ")
            Rectangle{
                id: arsenalhint
                x:300
                y:50
                radius: 10
                implicitWidth: arsenalhinttext.width+2
                height: arsenalhinttext.height+2
                visible: false
                ///anchors.leftMargin: 30
                color: "#DAF7A6"
                Text {
                    id:arsenalhinttext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    padding: 5
                    font.pointSize: 9
                    text: qsTr("Pick up your club")
                    color:"gray"
                }
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: managerUser.quizPass
                cursorShape: managerUser.quizPass ? Qt.PointingHandCursor : Qt.ArrowCursor
                acceptedButtons: Qt.LeftButton
                onClicked: {
                    if(managerUser.clubId === 0) {
                        app.callinsidepage2(clubSelection)
                        clubSelection.loadLeagueClubs(406);     //load league B (club id: 406 belongs to league B)
                        clubSelection.loadLeagueClubs(406);     //this is a bug for now, models has to be called twice to pass the values correctly
                    }
                    else {
                        ///
                        if(managerUser.userPortrait == ""){
                            app.clubDetailsforManager = true
    //                        app_title_bar.selectedportrail = "qrc:/images/portrait/"+managerUser.userPortrait+".jpg"
                            APIConnection.getClubDetails(managerUser.token, managerUser.clubId);
//                            APIConnection.getClubDetails(managerUser.token, managerUser.clubId);

//                            getInvitationsTimer.running = true
                            getNewsTimer.running = true
                            callinsidepage2(managerProfileGenerator)
                        }else{

                            app.clubDetailsforManager = false
                            app_title_bar.selectedportrail = "/images/portrait/"+managerUser.userPortrait+".jpg"

                            console.log(app_title_bar.selectedportrail)
                            APIConnection.getClubDetails(managerUser.token, managerUser.clubId);
                            clubPage.loadClubPlayers(managerUser.clubId)
//                            clubPage.loadClubPlayers(managerUser.clubId)
                            //add club players. Call it twice to populate it. needx fixing later on
//                            getInvitationsTimer.running = true
                            getNewsTimer.running = true
                            callinsidepage2(clubPage)
                            clubPage.setClub()
                        }
//                        app.callinsidepage2(clubPage)
//                        clubPage.setClub();
                    }
                }
                onPressed: {parent.state="clicked"}
                onReleased: {parent.state="unclicked"}
                onHoveredChanged: {
                    if(arsenal.boldfont_1 === false){
                        arsenal.boldfont_1 = true
                        arsenal.italicfont_1 = true
                        arsenalhint.visible = true
                    }else{
                        arsenal.boldfont_1 = false
                        arsenal.italicfont_1 = false
                        arsenalhint.visible = false
                    }
                }
            }
        }

        //not needed in alpha stage
        ButtonMainPage
        {
            id: brazil
            width: 300
            property bool boldfont_1: false
            property bool italicfont_1: false
            boldfont: brazil.boldfont_1
            italicfont: brazil.italicfont_1
            enabled: managerUser.quizPass
            button_text: qsTr("Classic Brazil Beat")
            visible: false
            Rectangle{
                id: brazilhint
                x:300
                y:50
                radius: 10
                implicitWidth: brazilhinttext.width+2
                height: brazilhinttext.height+2
                visible: false
                ///anchors.leftMargin: 30
                color: "#DAF7A6"
                Text {
                    id: brazilhinttext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    padding: 5
                    font.pointSize: 9
                    text: qsTr("pick up the club and then beat\nthe Wolrd Champion Brazil 2002\nWWC")
                    color:"gray"
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: managerUser.quizPass
                cursorShape: managerUser.quizPass ? Qt.PointingHandCursor : Qt.ArrowCursor
                acceptedButtons: Qt.LeftButton
                onPressed: {parent.state="clicked"}
                onReleased: {parent.state="unclicked"}
                onHoveredChanged: {
                    if(brazil.boldfont_1 === false){
                        brazil.boldfont_1 = true
                        brazil.italicfont_1 = true
                        brazilhint.visible  = true
                    }else{
                        brazil.boldfont_1 = false
                        brazil.italicfont_1 = false
                        brazilhint.visible  = false
                    }
                }
            }
        }
    }
}
