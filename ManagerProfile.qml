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
import com.Game.User 1.0

Rectangle
{
    id: managerProfile
    color: "transparent"
    property string titleBar: qsTr("Manager Profile")

    property UserCommentsModel usercommentmodel: UserCommentsModel{
        id:usercommentmodel
    }

    function setUser() {
        console.log(managerUser.clubId)

        app_title_bar.selectedplayer = "qrc:/images/portrait/" + managerUser.userPortrait + ".jpg"
        app_title_bar.selectedclubportrait = "qrc:/images/clubs/normal/" + managerUser.clubId + ".png"
        app_title_bar.title = managerUser.firstName + " " + managerUser.lastName//titleBar
        app_title_bar.titleFontSize = 20
        app_title_bar.setportrailVisible = true
        //        app_title_bar.backgroundColor = managerUser.club.background1Value !== "" ? managerUser.club.background1Value : app_title_bar.defaultBackgroundColor;
        //        app_title_bar.textColor = managerUser.club.background1Value !== "" ? managerUser.club.foreground1Value : app_title_bar.defaultTextColor;
        app_title_bar.selectedclubid = managerUser.clubId
        app_title_bar.selectedclubname = managerUser.clubName

        //set the  values
        overviewlistModel.clear()
        overviewlistModel.append({"pname": "Name", "pvalue" : app.user.firstName + " " + app.user.lastName})//player.age.toString()})
        overviewlistModel.append({"pname": "Nick Name", "pvalue" : app.user.nickName})//Qt.formatDateTime(player.dob, "yyyy-MM-dd")})
        overviewlistModel.append({"pname": "City", "pvalue" : app.user.city})//Qt.formatDateTime(player.dob, "yyyy-MM-dd")})
        overviewlistModel.append({"pname": "Club Name", "pvalue" : app.user.clubName})//Qt.formatDateTime(player.dob, "yyyy-MM-dd")})
        overviewlistModel.append({"pname": "favFormation", "pvalue" : app.user.favFormation})
        //        overviewModel.append({"pname": "Position", "pvalue" : player.position})
        //        overviewModel.append({"pname": "Club", "pvalue" : player.clubName})
        //        overviewModel.append({"pname": "Based", "pvalue" : player.based})
        //        overviewModel.append({"pname": "Division", "pvalue" : player.division})
        //        overviewModel.append({"pname": "Squad", "pvalue" : player.squad})
        //        //overviewModel.append({"pname": "EU Member", "pvalue" : player.})

        //        contractModel.clear()
        //        contractModel.append({"pname": "Wage", "pvalue" : currencyFormatter.currencyString(player.wage)})
        //        contractModel.append({"pname": "Value", "pvalue" : currencyFormatter.currencyString(player.value)})
        //        contractModel.append({"pname": "Joind Club", "pvalue" : player.joinedClub})
        //        contractModel.append({"pname": "Contract End", "pvalue" : player.contractEnd.toString()})
        //        contractModel.append({"pname": "Leaving on Bosman", "pvalue" : player.leavingOnBosman.toString()})
        //        contractModel.append({"pname": "Minimum Fee", "pvalue" : player.minimumFee.toString()})
        //        contractModel.append({"pname": "Relegation Fee", "pvalue" : player.relegationFee.toString()})
        //        contractModel.append({"pname": "Non Promotion Fee", "pvalue" : player.nonPromotionFee.toString()})
        //        contractModel.append({"pname": "Squad Status", "pvalue" : player.squadStatus.toString()})
        //        contractModel.append({"pname": "Transfer Status", "pvalue" : player.transferStatus.toString()})
        //        //contractModel.append({"pname": "", "pvalue" : player})

        //        emotionModel.clear()
        //        emotionModel.append({"pname": "Happiness Level", "pvalue" : player.happinessLevel.toString()})

        //        injuryModel.clear()
        //        //injuryModel.append({"pname": "Happiness Level", "pvalue" : player.inj})

        //        app_title_bar.backgroundColor = managerUser.club.background1Value
        //        app_title_bar.textColor = managerUser.club.foreground1Value
        //        app_title_bar.showselectedclubname = true

        //        playerActions.setPlayer(player);
    }

    ListModel {
        id: overviewlistModel
    }
    ListModel {
        id: relationcontactlistModel
    }
    ListModel {
        id: achivementlistModel
    }
    ListModel {
        id: bSlistModel
    }
    ListModel{
        id : recordlistModel
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
            width: parent.width/3-20
            anchors.left: parent.left
            height:parent.height
            color: "gray"
            //            Text {
            //                id :portraittext
            //                anchors.horizontalCenter: parent.horizontalCenter
            //                anchors.verticalCenter: parent.verticalCenter
            //                font.pointSize: 9
            //                text: qsTr("Large Portrait")
            //                color:"black"
            //            }
            Image{
                anchors.fill: parent
                height: 2*parent.height/3
                width: height
                source: app_title_bar.selectedplayer
                fillMode: Image.PreserveAspectCrop
                layer.enabled: true
                //                layer.effect: OpacityMask {
                //                    maskSource: mask1
                //                }
            }
        }
        Rectangle{
            id:knowlegerect
            width: parent.width/3-20
            anchors.horizontalCenter: parent.horizontalCenter
            height:parent.height
            color: "gray"
            Rectangle{
                id :knowlegerect1
                anchors.top: parent.top
                width: parent.width
                height: parent.height/4
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
                        id :knowlegetext
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 9
                        text: qsTr("Knowlege")
                        color:"black"
                    }
                }

            }
            Rectangle{
                id :tacticrect
                anchors.top: knowlegerect1.bottom
                width: parent.width
                height: parent.height/4
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
                    Text {
                        id :tactictext
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 9
                        text: qsTr("Tactic")
                        color:"black"
                    }
                }

            }
            Rectangle{
                id :discplinerect
                anchors.top: tacticrect.bottom
                width: parent.width
                height: parent.height/4
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
                    Text {
                        id :discplinetext
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 9
                        text: qsTr("Discpline")
                        color:"black"
                    }
                }

            }
            Rectangle{
                id :youthrect
                anchors.top: discplinerect.bottom
                width: parent.width
                height: parent.height/4
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
                    Text {
                        id :youthtext
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 9
                        text: qsTr("Youth Dev")
                        color:"black"
                    }
                }

            }
        }
        Rectangle{
            id:determinationrect
            width: parent.width/3-20
            anchors.right: parent.right
            height:parent.height
            color: "gray"
            Rectangle{
                id :determinationrect1
                anchors.top: parent.top
                width: parent.width
                height: parent.height/4
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
                        id :determinationtext
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 9
                        text: qsTr("Determination")
                        color:"black"
                    }
                }

            }
            Rectangle{
                id :ambitionrect
                anchors.top: determinationrect1.bottom
                width: parent.width
                height: parent.height/4
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
                    Text {
                        id :ambitiontext
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 9
                        text: qsTr("Ambition")
                        color:"black"
                    }
                }

            }
            Rectangle{
                id :adaptabilityrect
                anchors.top: ambitionrect.bottom
                width: parent.width
                height: parent.height/4
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
                    Text {
                        id :adaptabilitytext
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 9
                        text: qsTr("Adaptability")
                        color:"black"
                    }
                }

            }
            Rectangle{
                id :pointsrect
                anchors.top: adaptabilityrect.bottom
                width: parent.width
                height: parent.height/4
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
                    Text {
                        id :pointstext
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 9
                        text: qsTr("Points")
                        color:"black"
                    }
                }

            }
        }
    }
    //    Rectangle{
    //        id: map
    //        anchors.right: parent.right
    //        anchors.top : parent.top
    //        width: parent.width/3-10
    //        height: parent.height
    //        border.color: "gray"
    //        color: "black"
    //        z:parent.z+1
    //        MouseArea{
    //            anchors.fill: parent
    //            cursorShape: Qt.PointingHandCursor
    //        }
    //    }

    CommentBoard {
        id: map
        anchors.right: parent.right
        anchors.top : parent.top
        width: parent.width/3-10
        height: parent.height
        z:parent.z+1
        isUser: true
        commmentModel:usercommentmodel
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
                    listmodel: overviewlistModel
                }
                //                Rectangle {
                //                    color : "#6a6a8f"
                //                    ViewRectList{
                //                        id: overViewlist
                //                        anchors.left: parent.left
                //                        backgroungcolor : "#6a6a8f"
                //                        textcolor: "white"
                //                        width: parent.width+20
                //                        height: parent.height
                //                        anchors.topMargin: 5
                //                        listmodel :overViewcontactModel
                //                        ListModel {
                //                            id :overViewcontactModel
                //                            ListElement {name: qsTr("Age")}
                //                            ListElement {name: qsTr("City of birth")}
                //                            ListElement {name: qsTr("Wages")}
                //                            ListElement {name: qsTr("Expires")}
                //                            ListElement {name: qsTr("Hoppy")}

                //                        }
                //                    }
                //                }
            }
            Tab {
                title: qsTr("Relation")
                PlayerAttTableView {
                    id: relationcontactModel
                    listmodel: relationcontactlistModel
                }
                //                Rectangle {
                //                    color : "#6a6a8f"
                //                    ViewRectList{
                //                        id: relationlist
                //                        anchors.left: parent.left
                //                        width: parent.width+20
                //                        backgroungcolor : "#6a6a8f"
                //                        textcolor: "white"
                //                        height: parent.height
                //                        anchors.topMargin: 5
                //                        listmodel :relationcontactModel
                //                        ListModel {
                //                            id :relationcontactModel
                //                            ListElement {name: qsTr("Fav club")}
                //                            ListElement {name: qsTr("Hated club")}
                //                            ListElement {name: qsTr("Fav Footballer")}
                //                            ListElement {name: qsTr("Dislike Footballer")}
                //                            ListElement {name: qsTr("Fav Manager")}

                //                        }
                //                    }

                //                }
            }
            Tab {
                title: qsTr("Achivement")
                PlayerAttTableView {
                    id: achivementcontactModel
                    listmodel: achivementlistModel
                }/*
                Rectangle {
                    color : "#6a6a8f"
                    ViewRectList{
                        id: achivementlist
                        anchors.left: parent.left
                        width: parent.width+20
                        backgroungcolor : "#6a6a8f"
                        textcolor: "white"
                        height: parent.height
                        anchors.topMargin: 5
                        listmodel :achivementcontactModel
                        ListModel {
                            id :achivementcontactModel
                            ListElement {name: qsTr("Ero Championship 2016")}

                        }
                    }

                }*/
            }
            Tab {
                title: qsTr("B/S")
                PlayerAttTableView {
                    id: bScontactModel
                    listmodel: bSlistModel
                }
                //                Rectangle { color : "#6a6a8f" }
            }
            Tab {
                title: qsTr("Record")
                PlayerAttTableView {
                    id: recordcontactModel
                    listmodel: recordlistModel
                }
                //                Rectangle { color : "#6a6a8f" }
            }
        }
    }

        Connections {
            target: APIConnection
            onGetUserCommentFinished:{
                //playerCommentBoard.playerAnnoncementRect.setcommentRectHeight()
                map.annoncementRect.setcommentRectHeight()
                usercommentmodel.setuserComment(usercomment)
            }

    //        onGetUsersFinished :{

    //            managerProfile.setUser(u)
    //        }
        }
}
