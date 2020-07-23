import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import com.Game.SortFilterProxyModel 1.0
import QtQml.Models 2.2
import com.Game.Announcement 1.0
import com.Game.SimpleUser 1.0
import com.Game.APIConnection 1.0
import Constants 1.0

Item {
    id: announcement_board
    width: 370
    property alias userAnnouncenemtList: userAnnouncenemtList
    property alias userAnnoncement: userAnnoncement

//    function addNewStatus(userName){

//        userSignInStatusList.append({name:userName , index: userSignInStatusList.count + 1})
//    }

    function addNewAdminNews(text,icon){
        adminAnnouncenemtList.append({newsText: text ,imageSource: "qrc:/icons/" + icon + ".png"})
    }

    function addNewUserNews(text,icon){
        userAnnouncenemtList.append({newsText: text ,imageSource: "qrc:/icons/" + icon + ".png"})
    }

    property alias pModel: adminAnnouncenemtList


    AnnouncementModel{
        id : adminAnnouncenemtList
    }

    HistoryBrief{
        id: userAnnouncenemtList
    }

//    ListModel {
//        id: adminAnnouncenemtList
//        ListElement {
//            newsText: "hello world"
//            imageSource: "qrc:/icons/wrong.png"
//        }
//        ListElement {
//            newsText: "hello world"
//            imageSource: "qrc:/icons/warning.png"
//        }
//        ListElement {
//            newsText: "hello world"
//            imageSource: "qrc:/icons/Correct.png"
//        }
//    }


//    ListModel {
//        id: userAnnouncenemtList
//    }
//    HistoryBrief{
//        id: userAnnouncenemtList
//    }

    Rectangle
    {
        id: comment_window_title_bar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        z: 2
        color: "#5283bf"
        height: 30
        radius: comment_window.radius
        visible: stackView.__currentItem !== signinPage && stackView.__currentItem !== signupPage
        MouseArea{cursorShape: Qt.PointingHandCursor}
        Image
        {
            id: comment_title_bar_cross
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            height: 20
            width: 20
            source: "qrc:/icons/cross-blue.png"
            MouseArea
            {
                anchors.fill : parent
                acceptedButtons: Qt.LeftButton
                onClicked: {
                    comment_window.visible=false
                    comment_window_title_bar.visible=false
                }
            }
        }
        Image
        {
            id: comment_title_bar_maximize
            anchors.right: comment_title_bar_cross.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 3
            height: 20
            width: 20
            source: "qrc:/icons/maximize-blue.png"
            MouseArea
            {
                anchors.fill : parent
                acceptedButtons: Qt.LeftButton
                onClicked: {
                    announcement_board_is_minim=false ;
                }
            }
        }
        Image
        {
            id: comment_title_bar_minimize
            anchors.right: comment_title_bar_maximize.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 3
            height: 20
            width: 20
            source: "qrc:/icons/minimize-blue.png"
            MouseArea
            {
                anchors.fill : parent
                acceptedButtons: Qt.LeftButton
                onClicked: {
                    announcement_board_is_minim=true ;
                }
            }
        }
        Text
        {
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            color: "#ffaa00"
            font.family: Constants.primaryFont ? Constants.primaryFont.name: null//"Kristen ITC"
            text: qsTr("Announcement Board") //+ Retranslate.onLanguageChaned
            font.pointSize: 12
            //font.letterSpacing: 1
        }
    }


    Rectangle
    {
        id: comment_window
        anchors.top: comment_window_title_bar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        color: "transparent"
        radius: 10
        Behavior on height {
            SmoothedAnimation{
                velocity: 200
            }
        }
        Rectangle
        {
            id: comment_window_content

            anchors.top: parent.top
            anchors.right: parent.right
            //anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            border.color:  "#5283bf"
            color: "transparent"
            border.width: 3
            radius: 10

            AnnouncementPart{
                id : adminAnnoncement
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 5
                anchors.topMargin: 5
                anchors.rightMargin: 5
                anchors.bottomMargin: 5
                width: parent.width - 10
                height: parent.height - 215
                listmodel: adminAnnouncenemtList
                Behavior on height {
                    SmoothedAnimation{
                        velocity: 200
                    }
                }
//                    SortFilterProxyModel {
////                    id: adminModel
////                    imageSource : ""
//                    sourceModel: adminAnnouncenemtList
//                    sortCaseSensitivity: Qt.CaseInsensitive
////                    sortRole: "name"
//                    sortOrder: Qt.AscendingOrder
////                    filterRole: "proposedPosition"      //filter by position
////                    filterString: "GK|SW|D C|D R|D L|D RC|D LC|D RL|D RLC|WB R|WB L|WB RL"
////                    filterSyntax: SortFilterProxyModel.RegExp
//                    filterCaseSensitivity: Qt.CaseInsensitive

//                }
            }


            UserHistoryBrief{
                id : userAnnoncement
                anchors.left: parent.left
                anchors.top: adminAnnoncement.bottom
                anchors.leftMargin: 5
                anchors.topMargin: 5
                anchors.rightMargin: 5
                anchors.bottomMargin: 5
                width: parent.width - 10
                height: parent.height - adminAnnoncement.height - 15
                listmodel:userAnnouncenemtList
                Behavior on height {
                    SmoothedAnimation{
                        velocity: 200
                    }
                }
//                    SortFilterProxyModel {
//                    id: userModel
//                    sourceModel: userAnnouncenemtList
//                    sortCaseSensitivity: Qt.CaseInsensitive
////                    sortRole: "name"
//                    sortOrder: Qt.AscendingOrder
////                    filterRole: "proposedPosition"      //filter by position
////                    filterString: "GK|SW|D C|D R|D L|D RC|D LC|D RL|D RLC|WB R|WB L|WB RL"
////                    filterSyntax: SortFilterProxyModel.RegExp
//                    filterCaseSensitivity: Qt.CaseInsensitive

//                }
            }
        }
    }

    Connections {
        target: APIConnection
        onGetAnnouncementFinished : {
            adminAnnoncement.setAnnouncementRectHeight();
            adminAnnouncenemtList.setAnnouncement(announcement)
        }
        onGetUsersHistoryFinished: {
            annonucement_board.userAnnoncement.sethistoryBriefRectHeight()
            annonucement_board.userAnnouncenemtList.setUserHistory(usersHistory, managerUser.username)
            }

    }
}
