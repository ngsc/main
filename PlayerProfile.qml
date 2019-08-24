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

Rectangle {
    id: playerProfile
    color: "transparent"

    property string titleBar: player.name
    property alias playerCommentBoard: playerCommentBoard
    property string runningStamina: qsTr("Running/Stamina: %1/%2").arg(player.running).arg(player.stamina)
    property string challengingDirtness: qsTr("Challenging/Dirtness: %1/%2").arg(player.challenging).arg(player.dirtiness)
    property string bodyInjury: qsTr("Body/Injury proneness: %1/%2").arg(player.body).arg(player.injuryProneness)
    property string crossingVision: qsTr("Crossing/Vision: %1/%2" + player.crossing).arg(player.vision)
    property string setPieceTechnique: qsTr("Set Piece/Technique: %1/%2").arg(player.setPiece).arg(player.technique)
    property string passingVision: qsTr("Passing/Vision: %1/%2").arg(player.passing).arg(player.vision)
    property string headingWorkRate: qsTr("Heading/Work Rate: %1/%2").arg(player.heading).arg(player.workRate)
    property string shootingFlair: qsTr("Shooting/Flair: %1/%2").arg(player.shooting).arg(player.flair)
    property date gameClockDate

    property Player player: Player {
        id: tmpPlayer
    }

    property PlayerCommentsModel playerCommentmodel:PlayerCommentsModel {
        id: playercommmentModel
    }

    function setPlayer(p) {
        player = p
        player.setGameClock(gameClockDate)

        app_title_bar.selectedplayer = "file:///" + applicationPath + "../images/players/" + player.id + ".png"
        app_title_bar.selectedclubportrait = "file:///" + applicationPath + "../images/clubs/normal/" + player.clubId + ".png"
        app_title_bar.title = titleBar
        app_title_bar.titleFontSize = 20
        app_title_bar.setportrailVisible = true
        app_title_bar.backgroundColor = player.background1Value !== "" ? player.background1Value : app_title_bar.defaultBackgroundColor
        app_title_bar.textColor = player.background1Value !== "" ? player.foreground1Value : app_title_bar.defaultTextColor
        app_title_bar.selectedclubid = player.clubId
        app_title_bar.selectedclubname = player.clubName

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

        playerActions.setPlayer(player);
//        //set the  values
//        overviewModel.clear()
//        overviewModel.append({pname: "Age",pvalue: player.age.toString()})
//        overviewModel.append({pname: "Date of Birth", pvalue: Qt.formatDateTime(player.dob,"yyyy-MM-dd")})
//        overviewModel.append({pname: "Nation", pvalue: player.nation})
//        overviewModel.append({pname: "Position", pvalue: player.position})
//        overviewModel.append({
//                                 pname: "Club",
//                                 pvalue: player.clubName
//                             })
//        overviewModel.append({
//                                 pname: "Based",
//                                 pvalue: player.based
//                             })
//        overviewModel.append({
//                                 pname: "Division",
//                                 pvalue: player.division
//                             })
//        overviewModel.append({
//                                 pname: "Squad",
//                                 pvalue: player.squad
//                             })

//        //overviewModel.append({"pname": "EU Member", "pvalue" : player.})
//        contractModel.clear()
//        contractModel.append({ pname: "PlayerType", pvalue: playerType })
//        contractModel.append({
//                                 pname: "Wage",
//                                 pvalue: currencyFormatter.currencyString(
//                                             player.wage)
//                             })
//        contractModel.append({
//                                 pname: "Value",
//                                 pvalue: currencyFormatter.currencyString(
//                                             player.value)
//                             })
//        contractModel.append({
//                                 pname: "Joind Club",
//                                 pvalue: player.joinedClub
//                             })
//        contractModel.append({
//                                 pname: "Contract End",
//                                 pvalue: player.contractEnd.toString()
//                             })
//        contractModel.append({
//                                 pname: "Leaving on Bosman",
//                                 pvalue: player.leavingOnBosman.toString()
//                             })
//        contractModel.append({
//                                 pname: "Minimum Fee",
//                                 pvalue: player.minimumFee.toString()
//                             })
//        contractModel.append({
//                                 pname: "Relegation Fee",
//                                 pvalue: player.relegationFee.toString()
//                             })
//        contractModel.append({
//                                 pname: "Non Promotion Fee",
//                                 pvalue: player.nonPromotionFee.toString()
//                             })
//        contractModel.append({
//                                 pname: "Squad Status",
//                                 pvalue: player.squadStatus.toString()
//                             })
//        contractModel.append({
//                                 pname: "Transfer Status",
//                                 pvalue: player.transferStatus.toString()
//                             })

//        //contractModel.append({"pname": "", "pvalue" : player})
//        emotionModel.clear()
//        emotionModel.append({
//                                pname: "Happiness Level",
//                                pvalue: player.happinessLevel.toString()
//                            })

//        injuryModel.clear()
//        //injuryModel.append({"pname": "Happiness Level", "pvalue" : player.inj})

//        //        app_title_bar.backgroundColor =player.background1Value// managerUser.club.background1Value
//        //        app_title_bar.textColor = player.foreground1Value//managerUser.club.foreground1Value
//        app_title_bar.showselectedclubname = true

//        playerActions.setPlayer(player)
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

    Rectangle {
        id: detailes
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottomMargin: 10
        width: 2 * parent.width / 3 - 10
        height: parent.height / 2 - 10
        border.color: "gray"
        color: "transparent"

        Rectangle {
            id: portraitrect
            width: parent.width / 3 - 27
            anchors.left: parent.left
            height: parent.height
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

        BravoThumbDown {
            id: bravothumbrate
            anchors.left: portraitrect.right
            anchors.bottom: portraitrect.bottom
            width: 60
            color: "transparent"
            playerName: player.name
            playerID: player.id
            likeRateText: player.likeRate
            dislikeRateText: player.dislikeRate
            z: 11
        }

        Rectangle {
            id: knowlegerect
            width: parent.width / 3 - 15
            //            anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: bravothumbrate.right
            //            anchors.leftMargin: 5
            height: parent.height
            color: "gray"
            Rectangle {
                id: runningrect1
                anchors.top: parent.top
                width: parent.width
                height: parent.height / 4
                border.color: "black"
                color: "gray"
                Rectangle {
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"
                    color: "gray"
                }
                Rectangle {
                    anchors.right: parent.right
                    width: parent.width - 20
                    height: parent.height
                    border.color: "black"
                    color: "gray"
                }
                Text {
                    id: runningtext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr(runningStamina)
                    color: "black"
                    fontSizeMode: Text.Fit
                    minimumPointSize: 7
                    font.pointSize: 9
                    anchors.leftMargin: 5
                    anchors.rightMargin: 5
                }
            }
            Rectangle {
                id: challengingrect
                anchors.top: runningrect1.bottom
                width: parent.width
                height: parent.height / 4
                border.color: "black"
                Rectangle {
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"
                }
                Rectangle {
                    anchors.right: parent.right
                    width: parent.width - 20
                    height: parent.height
                    border.color: "black"
                }
                Text {
                    id: challengingtext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 9
                    text: qsTr(challengingDirtness)
                    color: "black"
                    fontSizeMode: Text.Fit
                    minimumPointSize: 7
                    anchors.leftMargin: 5
                    anchors.rightMargin: 5
                }
            }
            Rectangle {
                id: bodyrect
                anchors.top: challengingrect.bottom
                width: parent.width
                height: parent.height / 4
                border.color: "black"
                Rectangle {
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"
                }
                Rectangle {
                    anchors.right: parent.right
                    width: parent.width - 20
                    height: parent.height
                    border.color: "black"
                }
                Text {
                    id: bodytext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 9
                    text: qsTr(bodyInjury)
                    color: "black"
                    fontSizeMode: Text.Fit
                    minimumPointSize: 7
                    anchors.leftMargin: 5
                    anchors.rightMargin: 5
                }
            }
            Rectangle {
                id: crossingrect
                anchors.top: bodyrect.bottom
                width: parent.width
                height: parent.height / 4
                border.color: "black"
                Rectangle {
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"
                }
                Rectangle {
                    anchors.right: parent.right
                    width: parent.width - 20
                    height: parent.height
                    border.color: "black"
                }
                Text {
                    id: crossingtext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 9
                    text: qsTr(crossingVision)
                    color: "black"
                    fontSizeMode: Text.Fit
                    minimumPointSize: 7
                    anchors.leftMargin: 5
                    anchors.rightMargin: 5
                }
            }
        }
        Rectangle {
            id: setpiecerect
            width: parent.width / 3 - 15
            //            anchors.right: parent.right
            anchors.left: knowlegerect.right
            anchors.leftMargin: 5
            height: parent.height
            color: "gray"
            Rectangle {
                id: setpiecerect1
                anchors.top: parent.top
                width: parent.width
                height: parent.height / 4
                border.color: "black"
                color: "gray"
                Rectangle {
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"
                    color: "gray"
                }
                Rectangle {
                    anchors.right: parent.right
                    width: parent.width - 20
                    height: parent.height
                    border.color: "black"
                    color: "gray"
                }
                Text {
                    id: setpiecerectext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    fontSizeMode: Text.HorizontalFit
                    font.pointSize: 9
                    text: qsTr(setPieceTechnique)
                    color: "black"
                    minimumPointSize: 7
                    anchors.leftMargin: 5
                    anchors.rightMargin: 5
                }
            }
            Rectangle {
                id: passingrect
                anchors.top: setpiecerect1.bottom
                width: parent.width
                height: parent.height / 4
                border.color: "black"
                Rectangle {
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"
                }
                Rectangle {
                    anchors.right: parent.right
                    width: parent.width - 20
                    height: parent.height
                    border.color: "black"
                }
                Text {
                    id: passingtext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 9
                    text:qsTr(passingVision)
                    color: "black"
                    fontSizeMode: Text.Fit
                    minimumPointSize: 7
                    anchors.leftMargin: 5
                    anchors.rightMargin: 5
                }
            }
            Rectangle {
                id: headingrect
                anchors.top: passingrect.bottom
                width: parent.width
                height: parent.height / 4
                border.color: "black"
                Rectangle {
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"
                }
                Rectangle {
                    anchors.right: parent.right
                    width: parent.width - 20
                    height: parent.height
                    border.color: "black"
                }
                Text {
                    id: headingtext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 9
                    text: qsTr(headingWorkRate)
                    color: "black"
                    fontSizeMode: Text.Fit
                    minimumPointSize: 7
                    anchors.leftMargin: 5
                    anchors.rightMargin: 5
                }
            }
            Rectangle {
                id: shootingrect
                anchors.top: headingrect.bottom
                width: parent.width
                height: parent.height / 4
                border.color: "black"
                Rectangle {
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"
                }
                Rectangle {
                    anchors.right: parent.right
                    width: parent.width - 20
                    height: parent.height
                    border.color: "black"
                }
                Text {
                    id: shootingtext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 9
                    text: qsTr(shootingFlair)
                    color: "black"
                    fontSizeMode: Text.Fit
                    minimumPointSize: 7
                    anchors.leftMargin: 5
                    anchors.rightMargin: 5
                }
            }
        }
    }

    CommentBoard {
        //    Rectangle{
        id: playerCommentBoard
        anchors.right: parent.right
        anchors.top: parent.top
        width: parent.width / 3 - 10
        height: parent.height
        isUser: false
        commmentModel:playerCommentmodel
        //        border.color: "gray"
        //        color: "black"
    }
    Rectangle {
        id: overveiw
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: 2 * parent.width / 3 - 10
        height: parent.height / 2 - 10
        border.color: "gray"
        color: "transparent"
        TabView {
            anchors.fill: parent
            Tab {
                title: "OverView"
                PlayerAttTableView {
                    id: overviewTableModel
                    listmodel: overviewModel
                }
            }
            Tab {
                title: "Contract"
                PlayerAttTableView {
                    id: contractTableModel
                    listmodel: contractModel
                }
            }
            Tab {
                title: "Emotion"
                PlayerAttTableView {
                    id: emotionTableModel
                    listmodel: emotionModel
                }
            }
            Tab {
                title: "Injury/Ban"
                PlayerAttTableView {
                    id: injuryTableModel
                    listmodel: injuryModel
                }
            }
        }
    }
    /*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
}
