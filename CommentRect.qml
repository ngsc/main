import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick 2.7
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import com.Game.SortFilterProxyModel 1.0
import com.Game.APIConnection 1.0
import QtQml.Models 2.2

Item {
    id: comment_part

    //    width: 320
    property var listmodel
    property string backgroungcolor: "light blue"
    property string textcolor: "black"
    property bool isUser

    //    property int playerid: playerProfile.player.id
    function setcommentRectHeight() {
        comment_rect.height = 1
    }

    Rectangle {
        id: comment_window
        anchors.fill: parent

        color: "transparent"
        radius: 10
        Behavior on height {
            SmoothedAnimation {
                velocity: 200
            }
        }
        Rectangle {
            id: comment_window_content

            anchors.top: parent.top
            anchors.right: parent.right
            //anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            border.color: "#5283bf"
            color: "transparent"
            border.width: 3
            radius: 10
            ScrollView {
                id: comment_board_scroll_view
                anchors.rightMargin: 10
                anchors.bottomMargin: 15
                anchors.leftMargin: 10
                anchors.topMargin: 15
                anchors.fill: parent
                anchors.margins: 2
                horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
                style: ScrollViewStyle {
                    handle: Rectangle {
                        id: comment_board_scroll_view_handle
                        implicitWidth: 15
                        radius: width / 2
                        color: "#55aaff"
                        border.color: "#577fa9"
                        border.width: 2
                    }
                    scrollBarBackground: Rectangle {
                        id: comment_board_scroll_view_background
                        implicitWidth: 15
                        implicitHeight: comment_board_scroll_view.height - (30) + 10
                        radius: 7
                        color: "#3b76b1"
                        border.color: "#34537a"
                        border.width: 1
                        //color: "#ffffff"

                        /*LinearGradient{
                                    anchors.fill: parent
                                    end: Qt.point(15,0)
                                    start: Qt.point(0,0)
                                    gradient:Gradient{
                                                GradientStop { position: 0.0;  color: "#7c99d0" }
                                                GradientStop { position: 0.25; color: "#ffffff" }
                                                GradientStop { position: 0.50; color: "#ffffff" }
                                                GradientStop { position: 1.0; color: "#7c99d0" }
                                    }
                                }*/
                    }
                    decrementControl: Rectangle {
                        id: comment_board_scroll_view_dec_control
                        implicitWidth: 15
                        implicitHeight: implicitWidth
                        color: "#34537a"
                        Image {
                            anchors.fill: parent
                            anchors.margins: 1
                            //anchors.margins: 1
                            fillMode: Image.Stretch
                            source: "qrc:/icons/arrow-orange-up.png"
                            opacity: 1
                        }
                    }
                    incrementControl: Rectangle {
                        id: comment_board_scroll_view_inc_control
                        implicitWidth: 15
                        implicitHeight: implicitWidth
                        color: "#34537a"
                        Image {
                            anchors.fill: parent
                            anchors.leftMargin: 1
                            fillMode: Image.Stretch
                            source: "qrc:/icons/arrow-orange-down.png"
                            opacity: 1
                        }
                    }
                }
                visible: (parent.height > 30) ? true : false

                Rectangle {
                    id: comment_rect
                    width: comment_part.width
                    height: 1 //+ contactsDelegate.height
                    color: backgroungcolor
                    opacity: 1
                    radius: 15
                    anchors.topMargin: 10
                    border.color: "green"

                    Component {
                        id: contactsDelegate
                        Item {
                            width: comment_part.width //- 40
                            implicitHeight: newsElementText.height + 40
                            //                                            > 70 ? newsElementText.height : 70
                            //                            width: parent.width - 10 //height: 80
                            Column {
                                id: annonucement_column
                                leftPadding: 10
                                rightPadding: 10
                                bottomPadding: 5

                                move: Transition {
                                    NumberAnimation {
                                        properties: "x,y"
                                        duration: 1000
                                    }
                                }

                                Rectangle {
                                    id: commentRect
                                    width: comment_part.width - 40
                                    implicitHeight: newsElementText.height + 40
                                    anchors.bottomMargin: 5
                                    anchors.topMargin: 5
                                    radius: 15
                                    border.color: "green"
                                    color: "transparent"

                                    Text {
                                        id: newsElementText
                                        width: parent.width - 200
                                        anchors.left: parent.left
                                        verticalAlignment: Text.AlignVCenter
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.rightMargin: 5
                                        anchors.leftMargin: 5
                                        fontSizeMode: Text.Fit
                                        minimumPointSize: 10
                                        font.pointSize: 12
                                        text: qsTr(message)
                                    }

                                    Text {
                                        id: rateText
                                        //                                        text: qsTr(0) //messageRate)
                                        height: 30
                                        width: 30
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        text: qsTr(messageRate.toString())
                                        visible: true
                                        anchors.bottomMargin: 5
                                        //                                        anchors.leftMargin: 5
                                        anchors.topMargin: 5
                                        anchors.bottom: parent.bottom
                                        anchors.right: parent.right
                                        font.pointSize: 12
                                        color: "blue"
                                    }

                                    Image {
                                        id: newsElementImage
                                        height: 30
                                        width: 30
                                        anchors.bottomMargin: 5
                                        anchors.leftMargin: 5
                                        anchors.topMargin: 5
                                        anchors.right: rateText.left
                                        anchors.bottom: parent.bottom
                                        source: "qrc:/icons/like.png"
                                        visible: true
                                        z: 11
                                        MouseArea {
                                            anchors.fill: parent
                                            hoverEnabled: true
                                            onEntered: {
                                                parent.scale = 1.3
                                            }
                                            onExited: {
                                                parent.scale = 1
                                            }
                                            onClicked: {
                                                if(isUser){
                                                    APIConnection.likeUserComment(managerUser.token,managerUser.id,id)
                                                    APIConnection.getUserComment(managerUser.token, managerUser.id)
                                                }else{
                                                    APIConnection.likeplayerComment(managerUser.token,playerProfile.player.id,id)
                                                    APIConnection.getPlayerComment(managerUser.token, playerProfile.player.id)
                                                }
//                                                APIConnection.likeplayerComment(managerUser.token,playerProfile.player.id,id)
//                                                APIConnection.getPlayerComment(managerUser.token,playerProfile.player.id)
                                            }
                                            onDoubleClicked: {

                                            }
                                        }
                                    }
                                }
                            }

                            Component.onCompleted: {
                                comment_rect.height = comment_rect.height + height + 10
                                //+ newsElementText.height + 10
                            }
                        }
                    }

                    ListView {
                        id: listview
                        anchors.fill: parent
                        model: listmodel
                        anchors.topMargin: 10
                        boundsBehavior: Flickable.DragAndOvershootBounds
                        opacity: 1
                        maximumFlickVelocity: 2500
                        preferredHighlightEnd: 2
                        spacing: 5
                        z: parent.z + 1
                        highlightRangeMode: ListView.NoHighlightRange
                        snapMode: ListView.SnapToItem
                        add: Transition {
                            NumberAnimation {
                                properties: "x,y"
                                from: 100
                                duration: 1000
                            }
                        }
                        addDisplaced: Transition {
                            NumberAnimation {
                                properties: "x,y"
                                duration: 1000
                            }
                        }
                        displaced: Transition {
                            NumberAnimation {
                                properties: "x,y"
                                duration: 1000
                            }
                        }
                        anchors.horizontalCenter: parent.horizontalCenter
                        delegate: contactsDelegate
                        highlightMoveVelocity: 100
                        highlight: Rectangle {
                            color: "blue" /*"lightsteelblue"*/
                            radius: 5
                        }
                        focus: false
                        highlightFollowsCurrentItem: false
                    }
                }
            }
        }
    }
}
