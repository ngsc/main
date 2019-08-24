/*
** Added by Ahmed Soliman
** For further information use the contact form at AhmedSoliman_1234@hotmail.com.
*/
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import com.Game.PlayerComment 1.0
import com.Game.Player 1.0

Rectangle
{
    id: goalkeeperProfile
    color: "transparent"
    property string titleBar: player.name
    property alias playerCommentBoard: playerCommentBoard

    property string handling : qsTr("Handling: %1").arg(player.handling)
    property string onOnOne : qsTr("One On One: %1").arg(player.oneOnOnes)
    property string positioning : qsTr("Positioning: %1").arg(player.positioning)
    property string reflexes : qsTr("Reflexes: %1").arg(player.reflexes)
    property string kicking: qsTr("Kicking: %1").arg(player.kicking)
    property string rushingOut: qsTr("Rushing out: %1").arg(player.rushingOut)
    property string communication: qsTr("Communication: %1").arg(player.communication)
    property string eccentricity: qsTr("Eccentricity: %1").arg(player.eccentricity)
    property string tendencyToPunch: qsTr("Tendency to punch: %1").arg(player.tendencyToPunch)
    property string commandOfArea: qsTr("Command of area: %1").arg(player.commandOfArea)
    property string aerialAbility: qsTr("Aerial ability: %1").arg(player.aerialAbility)
    property date gameClockDate

    property Player player : Player {id: tmpPlayer}

    property PlayerCommentsModel playerCommentmodel:PlayerCommentsModel {
        id: playercommmentModel
    }

    function setPlayer(p) {
        player = p
        player.setGameClock(gameClockDate)
        app_title_bar.selectedplayer = "file:///" + applicationPath + "../images/players/" + player.id + ".png"
        app_title_bar.selectedclubportrait = "file:///" + applicationPath + "../images/clubs/normal/" + player.clubId + ".png"
        app_title_bar.title = titleBar
        app_title_bar.titleFontSize = 25
        app_title_bar.clubFontSize = 15
        app_title_bar.setportrailVisible = true
        app_title_bar.backgroundColor = player.background1Value !== "" ? player.background1Value : app_title_bar.defaultBackgroundColor;
        app_title_bar.textColor = player.background1Value !== "" ? player.foreground1Value : app_title_bar.defaultTextColor;
        app_title_bar.selectedclubname = player.clubName
        app_title_bar.selectedclubid = player.clubId

        console.log(player.background1Value)
        console.log(player.clubName)
        console.log(player.clubId)
        console.log(player.foreground1Value)

        //set the  values
        overviewModel.clear()
        overviewModel.append({"pname": qsTr("Age"), "pvalue" : player.age.toString()})
        overviewModel.append({"pname": qsTr("Date of Birth"), "pvalue" : Qt.formatDateTime(player.dob, "yyyy-MM-dd")})
        overviewModel.append({"pname": qsTr("Nation"), "pvalue" : player.nation})
        overviewModel.append({"pname": qsTr("Position"), "pvalue" : player.position})
        overviewModel.append({"pname": qsTr("Club"), "pvalue" : player.clubName})
        overviewModel.append({"pname": qsTr("Based"), "pvalue" : player.based})
        overviewModel.append({"pname": qsTr("Division"), "pvalue" : player.division})
        overviewModel.append({"pname": qsTr("Squad"), "pvalue" : player.squad})
        //overviewModel.append({"pname": qsTr("EU Member"), "pvalue" : player.})

        contractModel.clear()
        contractModel.append({"pname": qsTr("PlayerType"), "pvalue": player.getPlayertype })
        contractModel.append({"pname": qsTr("Wage"), "pvalue" : currencyFormatter.currencyString(player.wage)})
        contractModel.append({"pname": qsTr("Value"), "pvalue" : currencyFormatter.currencyString(player.value)})
        contractModel.append({"pname": qsTr("Joind Club"), "pvalue" : player.joinedClub})
        contractModel.append({"pname": qsTr("Contract End"), "pvalue" : player.contractEnd.toString()})
        contractModel.append({"pname": qsTr("Leaving on Bosman"), "pvalue" : player.leavingOnBosman.toString()})
        contractModel.append({"pname": qsTr("Minimum Fee"), "pvalue" : player.minimumFee.toString()})
        contractModel.append({"pname": qsTr("Relegation Fee"), "pvalue" : player.relegationFee.toString()})
        contractModel.append({"pname": qsTr("Non Promotion Fee"), "pvalue" : player.nonPromotionFee.toString()})
        contractModel.append({"pname": qsTr("Squad Status"), "pvalue" : player.squadStatus.toString()})
        contractModel.append({"pname": qsTr("Transfer Status"), "pvalue" : player.transferStatus.toString()})
        //contractModel.append({"pname": "", "pvalue" : player})

        emotionModel.clear()
        emotionModel.append({"pname": qsTr("Happiness Level"), "pvalue" : player.happinessLevel.toString()})

        //injuryModel.clear()
        //injuryModel.append({"pname": qsTr("Happiness Level"), "pvalue" : player.inj})
        //.setGameClock(dateTime)
        playerActions.setPlayer(player);

    }

    ListModel {
        id: overviewModel
    }
    ListModel {
        id: contractModel
    }
    ListModel {
        id: emotionModel
    }
    ListModel {
        id: injuryModel
    }

    Rectangle{
        id: detailes
        anchors.left: parent.left
        anchors.top : parent.top
        anchors.bottomMargin: 10
        width: 2*parent.width/3-10
        height: parent.height/2-10
        border.color: "gray"
        color: "transparent"
        Rectangle{
            id:portraitrect
            width: parent.width/3-27
            anchors.left: parent.left
            height:parent.height
            color: "gray"
            Image {
                id: portraitimg
                z: parent.z + 1
                anchors.fill: parent
                fillMode: Image.Stretch
                source: app_title_bar.selectedplayer
                smooth: true
            }
        }

        BravoThumbDown{
            id : bravothumbrate
            anchors.left: portraitrect.right
            anchors.bottom: portraitrect.bottom
            width: 60
            color: "transparent"
            playerName: player.name
            likeRateText: player.likeRate
            dislikeRateText: player.dislikeRate
//            border.color: "gray"
            z: 11
        }

        Rectangle{
            id:knowlegerect
            width: parent.width/3-15
            //            anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: bravothumbrate.right
            //            anchors.leftMargin: 5
            height:parent.height
            color: "gray"
            Rectangle{
                id :communicationrect
                anchors.top: parent.top
                width: parent.width
                height: parent.height/6
                border.color: "black"
                color: "gray"
                Rectangle{
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"
                    color: "gray"
                }
                Rectangle{
                    anchors.right: parent.right
                    width: parent.width-20
                    height: parent.height
                    border.color: "black"
                    color: "gray"
                    Text {
                        id :communcationtext
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        fontSizeMode: Text.Fit;
                        minimumPointSize: 7;
                        font.pointSize: 9;
                        anchors.leftMargin: 5;
                        anchors.rightMargin: 5;
                        text: qsTr(communication)
                        color:"black"
                    }
                }

            }
            Rectangle{
                id :eccentricityrect
                anchors.top: communicationrect.bottom
                width: parent.width
                height: parent.height/6
                border.color: "black"
                Rectangle{
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"

                }
                Rectangle{
                    anchors.right: parent.right
                    width: parent.width-20
                    height: parent.height
                    border.color: "black"
                }
                Text {
                    id :eccentricitytext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    fontSizeMode: Text.Fit;
                    minimumPointSize: 7;
                    font.pointSize: 9;
                    anchors.leftMargin: 5;
                    anchors.rightMargin: 5;
                    text: qsTr(eccentricity)
                    color:"black"
                }

            }
            Rectangle{
                id :tendencyrect
                anchors.top: eccentricityrect.bottom
                width: parent.width
                height: parent.height/6
                border.color: "black"
                Rectangle{
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"

                }
                Rectangle{
                    anchors.right: parent.right
                    width: parent.width-20
                    height: parent.height
                    border.color: "black"
                }
                Text {
                    id :tendencytext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    fontSizeMode: Text.Fit;
                    minimumPointSize: 7;
                    font.pointSize: 9;
                    anchors.leftMargin: 5;
                    anchors.rightMargin: 5;
                    text: qsTr(tendencyToPunch)
                    color:"black"
                }

            }
            Rectangle{
                id :commandrect
                anchors.top: tendencyrect.bottom
                width: parent.width
                height: parent.height/6
                border.color: "black"
                Rectangle{
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"

                }
                Rectangle{
                    anchors.right: parent.right
                    width: parent.width-20
                    height: parent.height
                    border.color: "black"
                }
                Text {
                    id :commandtext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    fontSizeMode: Text.Fit;
                    minimumPointSize: 7;
                    font.pointSize: 9;
                    anchors.leftMargin: 5;
                    anchors.rightMargin: 5;
                    text: qsTr(commandOfArea)
                    color:"black"
                }
            }
            Rectangle{
                id : aerialrect
                anchors.top: commandrect.bottom
                width: parent.width
                height: parent.height/6
                border.color: "black"
                Rectangle{
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"

                }
                Rectangle{
                    anchors.right: parent.right
                    width: parent.width-20
                    height: parent.height
                    border.color: "black"
                }
                Text {
                    id :aerialtext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    fontSizeMode: Text.Fit;
                    minimumPointSize: 7;
                    font.pointSize: 9;
                    anchors.leftMargin: 5;
                    anchors.rightMargin: 5;
                    text: qsTr(aerialAbility)
                    color:"black"
                }
            }
            Rectangle{
                id :extrarect
                anchors.top: aerialrect.bottom
                width: parent.width
                height: parent.height/6
                border.color: "black"
                Rectangle{
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"

                }
                Rectangle{
                    anchors.right: parent.right
                    width: parent.width-20
                    height: parent.height
                    border.color: "black"
                }
                Text {
                    id :extratext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    fontSizeMode: Text.Fit;
                    minimumPointSize: 7;
                    font.pointSize: 9;
                    anchors.leftMargin: 5;
                    anchors.rightMargin: 5;
                    text: ""
                    color:"black"
                }
            }
        }
        Rectangle{
            id:handlingrect
            width: parent.width/3-15
            //            anchors.right: parent.right
            anchors.left: knowlegerect.right
            anchors.leftMargin: 5
            height:parent.height
            color: "gray"
            Rectangle{
                id :handlingrect1
                anchors.top: parent.top
                width: parent.width
                height: parent.height/6
                border.color: "black"
                color: "gray"
                Rectangle{
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"
                    color: "gray"
                }
                Rectangle{
                    anchors.right: parent.right
                    width: parent.width-20
                    height: parent.height
                    border.color: "black"
                    color: "gray"
                }
                Text {
                    id :handlingtext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    fontSizeMode: Text.Fit;
                    minimumPointSize: 7;
                    font.pointSize: 9;
                    anchors.leftMargin: 5;
                    anchors.rightMargin: 5;
                    text: qsTr(handling)
                    color:"black"
                }

            }
            Rectangle{
                id :oneOnOnerect
                anchors.top: handlingrect1.bottom
                width: parent.width
                height: parent.height/6
                border.color: "black"
                Rectangle{
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"

                }
                Rectangle{
                    anchors.right: parent.right
                    width: parent.width-20
                    height: parent.height
                    border.color: "black"
                }
                Text {
                    id :oneOnOnetext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    fontSizeMode: Text.Fit;
                    minimumPointSize: 7;
                    font.pointSize: 9;
                    anchors.leftMargin: 5;
                    anchors.rightMargin: 5;
                    text: qsTr(onOnOne)
                    color:"black"
                }

            }
            Rectangle{
                id :postioningrect
                anchors.top: oneOnOnerect.bottom
                width: parent.width
                height: parent.height/6
                border.color: "black"
                Rectangle{
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"

                }
                Rectangle{
                    anchors.right: parent.right
                    width: parent.width-20
                    height: parent.height
                    border.color: "black"
                }
                Text {
                    id :postioningtext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    fontSizeMode: Text.Fit;
                    minimumPointSize: 7;
                    font.pointSize: 9;
                    anchors.leftMargin: 5;
                    anchors.rightMargin: 5;
                    text: qsTr(positioning)
                    color:"black"
                }

            }
            Rectangle{
                id :reflexesrect
                anchors.top: postioningrect.bottom
                width: parent.width
                height: parent.height/6
                border.color: "black"
                Rectangle{
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"

                }
                Rectangle{
                    anchors.right: parent.right
                    width: parent.width-20
                    height: parent.height
                    border.color: "black"
                }
                Text {
                    id :reflexestext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    fontSizeMode: Text.Fit;
                    minimumPointSize: 7;
                    font.pointSize: 9;
                    anchors.leftMargin: 5;
                    anchors.rightMargin: 5;
                    text: qsTr(reflexes)
                    color:"black"
                }

            }
            Rectangle{
                id :kickingrect
                anchors.top: reflexesrect.bottom
                width: parent.width
                height: parent.height/6
                border.color: "black"
                Rectangle{
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"
                }
                Rectangle{
                    anchors.right: parent.right
                    width: parent.width-20
                    height: parent.height
                    border.color: "black"
                }
                Text {
                    id :kickingrecttext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    fontSizeMode: Text.Fit;
                    minimumPointSize: 7;
                    font.pointSize: 9;
                    anchors.leftMargin: 5;
                    anchors.rightMargin: 5;
                    text: qsTr(kicking)
                    color:"black"
                }

            }
            Rectangle{
                id :rushingOutrect
                anchors.top: kickingrect.bottom
                width: parent.width
                height: parent.height/6
                border.color: "black"
                Rectangle{
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"
                }
                Rectangle{
                    anchors.right: parent.right
                    width: parent.width-20
                    height: parent.height
                    border.color: "black"
                }
                Text {
                    id :rushingOuttext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    fontSizeMode: Text.Fit;
                    minimumPointSize: 7;
                    font.pointSize: 9;
                    anchors.leftMargin: 5;
                    anchors.rightMargin: 5;
                    text: qsTr(rushingOut)
                    color:"black"
                }
            }
        }
    }
    CommentBoard{
        id: playerCommentBoard
        anchors.right: parent.right
        anchors.top : parent.top
        width: parent.width/3-10
        height: parent.height
        isUser: false
        commmentModel:playerCommentmodel
        //        border.color: "gray"
        //        color: "black"
    }
    Rectangle{
        id: overveiw
        anchors.left: parent.left
        anchors.bottom : parent.bottom
        width: 2*parent.width/3-10
        height: parent.height/2-10
        border.color: "gray"
        color: "transparent"
        TabView {
            anchors.fill: parent
            Tab {
                title: qsTr("OverView")
                PlayerAttTableView {
                    id: overviewTableModel
                    listmodel: overviewModel
                }
            }
            Tab {
                title: qsTr("Contract")
                PlayerAttTableView {
                    id: contractTableModel
                    listmodel: contractModel
                }
            }
            Tab {
                title: qsTr("Emotion")
                PlayerAttTableView {
                    id: emotionTableModel
                    listmodel: emotionModel
                }
            }
            Tab {
                title: qsTr("Injury/Ban")
                PlayerAttTableView {
                    id: injuryTableModel
                    listmodel: injuryModel
                }
            }
        }
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
