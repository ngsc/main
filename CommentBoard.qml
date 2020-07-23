import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick 2.7
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import com.Game.APIConnection 1.0
import com.Game.SortFilterProxyModel 1.0
import QtQml.Models 2.2
import Constants 1.0

Item {
    id: commentpart

    //    width: 320
    property var commmentModel
    property string backgroungcolor: "light blue"
    property string textcolor: "black"
    property bool isUser//: false
    //    property alias commmentModel: commmentModel
    property alias annoncementRect: annoncement
    //    property model name: value

    //    PlayerCommentsModel {
    //        id: commmentModel
    //    }

    CommentRect {
        id: annoncement
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 5
        anchors.topMargin: 5
        anchors.rightMargin: 5
        anchors.bottomMargin: 5
        isUser: commentpart.isUser
        width: parent.width - 10
        height: parent.height - 40
        //        playerid : 0
        Behavior on height {
            SmoothedAnimation {
                velocity: 200
            }
        }
        listmodel: commmentModel
    }

    Rectangle {
        id: comment_Area
        width: parent.width
        height: 30
        anchors.top: annoncement.bottom
        color: "transparent"
        border.color: "gray"
        anchors.bottomMargin: 40
        //            width: 600
        //            height: 60
        //            color: "transparent"
        radius: width / 2
        //            visible: stackView.__currentItem !== signinPage && stackView.__currentItem !== signupPage
        MouseArea {
            cursorShape: Qt.PointingHandCursor
        }

        Rectangle {
            border.color: "#fdc807"
            border.width: 3
            anchors.fill: parent
            color: "#34537a"
            opacity: 0.7
            radius: parent.radius
        }

        TextField {
            id: bullet_comment_field_text
            anchors.left: parent.left
            anchors.top: parent.top
            //            anchors.bottom: parent.bottom
            activeFocusOnPress: true
            width: parent.width - 35
            font.family: Constants.primaryFont ? Constants.primaryFont.name: null
            font.pointSize: 12
            focus: true
            style: TextFieldStyle {
                textColor: "#ffffff"
                background: Rectangle {
                    //border.color: "#fdc807"
                    //border.width: 3
                    //radius: width/2
                    color: "transparent"
                }
            }

            Keys.onReturnPressed: {


                //                flowing_comment_field_text.text=bullet_comment_field_text.text;
            }
        }

        Keys.onPressed: {


            //            if(event.key === Qt.Key_Enter){
            //                flowing_comment_field_text.text=bullet_comment_field_text.text;
            //                flowing_comment_field_text.font.pointSize = (Math.random()*90)%20
            //                if(nameSliderTimer.running===false)
            //                    nameSliderTimer.start();
            //            }
        }

        Image {
            id: send_icon
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height - 15
            width: height
            fillMode: Image.Stretch
            source: "qrc:/icons/arrow-blue.png"

            property int fontIndex: (Math.random() * 95) % 5

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onClicked: {
                    if(isUser){
                        APIConnection.setUserComment(managerUser.token, managerUser.id,
                                                     bullet_comment_field_text.text)
                        APIConnection.getUserComment(managerUser.token, managerUser.id)
                    }else{
                        APIConnection.setPlayerComment(managerUser.token, playerProfile.player.id,
                                                       bullet_comment_field_text.text)
                        APIConnection.getPlayerComment(managerUser.token, playerProfile.player.id)
                    }
                }
            }
        }
    }
}
