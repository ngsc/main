import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0

Item {
    id: announcement_board
    width: 370

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
            font.family: "Comic Sans MS"//"Kristen ITC"
            text: qsTr("Announcement Board")
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

        //anchors.topMargin: 1
        //anchors.right: main_window.right
        //anchors.rightMargin: 5
        //height: announcement_board_is_minim==true ? 0 : parent.height-app_title_bar.height-10+40
        //width: 370
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
            ScrollView
            {
                id: announcement_board_scroll_view
                anchors.rightMargin: 10
                anchors.bottomMargin: 15
                anchors.leftMargin: 10
                anchors.topMargin: 15
                anchors.fill: parent
                anchors.margins: 2
                horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
                style: ScrollViewStyle{
                    handle: Rectangle {
                        id: announcement_board_scroll_view_handle
                        implicitWidth: 15
                        radius: width/2
                        color: "#55aaff"
                        border.color: "#577fa9"
                        border.width: 2
                    }
                    scrollBarBackground: Rectangle {
                        id: announcement_board_scroll_view_background
                        implicitWidth: 15
                        implicitHeight: announcement_board_scroll_view.height-(30)+10
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
                        id: announcement_board_scroll_view_dec_control
                        implicitWidth: 15
                        implicitHeight: implicitWidth
                        color: "#34537a"
                        Image
                        {
                            anchors.fill: parent
                            anchors.margins: 1
                            //anchors.margins: 1
                            fillMode: Image.Stretch
                            source: "qrc:/icons/arrow-orange-up.png"
                            opacity: 1
                        }
                    }
                    incrementControl: Rectangle {
                        id: announcement_board_scroll_view_inc_control
                        implicitWidth: 15
                        implicitHeight: implicitWidth
                        color: "#34537a"
                        Image
                        {
                            anchors.fill: parent
                            anchors.leftMargin: 1
                            fillMode: Image.Stretch
                            source: "qrc:/icons/arrow-orange-down.png"
                            opacity: 1
                        }
                    }
                }
                visible: (parent.height>30) ? true : false
                Rectangle
                {
                    width: 500
                    height: 1000
                    color: "#ffffff"
                    opacity: 0.7
                    radius: comment_window_content.radius
                }
            }
        }
    }
}

/*##^## Designer {
    D{i:0;anchors.rightMargin__AT__NodeInstance:5;anchors.topMargin__AT__NodeInstance:1}
}
 ##^##*/
