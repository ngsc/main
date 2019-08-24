import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick 2.7
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import com.Game.SortFilterProxyModel 1.0


Item {
    id: announcement_part
    width: 320

    property var listmodel
    property string backgroungcolor : "light blue"
    property string textcolor : "black"

    function setAnnouncementRectHeight(){
        announcement_rect.height = 1
    }

    //    signal doubleClicked(int id)

    //    function getcurrentindex(){
    //        return listview.currentIndex
    //    }
    //    function setcurrentindex(value){
    //        listview.currentIndex = value
    //    }

    //    function addNewStatus(userName){

    //        userSignInStatusList.append({name:userName , index: userSignInStatusList.count + 1})
    //    }
    //    ListModel {
    //        id: userSignInStatusList

    //        ListElement {
    //            name: ""
    //            index: 1
    //        }
    //    }

    Rectangle
    {
        id: comment_window
        anchors.fill: parent

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
                    id : announcement_rect
                    width : announcement_part.width
                    height: 1 //+ contactsDelegate.height
                    color: backgroungcolor
                    radius: 15
                    opacity: 1
                    anchors.topMargin: 10
                    border.color: "green"

                    Component {
                        id: contactsDelegate
                        Item {
                            implicitHeight: newsElementText.height > 70 ? newsElementText.height : 70
                            width: parent.width; //height: 80
                            Column {
                                id : annonucement_column
                                leftPadding: 10
                                rightPadding: 10
                                bottomPadding: 5

                                move: Transition {
                                    NumberAnimation { properties: "x,y"; duration: 1000 }
                                }

                                Rectangle{

                                    color: fontBackground
                                    width : 300
                                    //                                    height: 80
                                    implicitHeight: newsElementText.height > 70 ? newsElementText.height : 70
                                    //                                    anchors.rightMargin: 5
                                    anchors.bottomMargin: 5
                                    //                                    anchors.leftMargin: 5
                                    anchors.topMargin: 5
                                    radius: 15
                                    border.color: "green"
                                    //    anchors.leftMargin: 5

                                    property string imageSource : ""
                                    property string newsText: ""
                                    property bool imageVisible: false
                                    property string textColor: fontColor
                                    //                                    property string backGroundColor:fontBackground//"transparent"

                                    Text {
                                        id: newsElementText
                                        //                                        height: parent.height
                                        //                                        implicitHeight: 80
                                        width: parent.width - newsElementImage.width - 5
                                        anchors.left: newsElementImage.right
                                        verticalAlignment: Text.AlignVCenter;
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.rightMargin: 5
                                        anchors.leftMargin: 5
                                        fontSizeMode: Text.HorizontalFit;
                                        //                                        anchors.bottomMargin: 5
                                        //                                        anchors.topMargin: 5
                                        //                                        font.weight: Font.DemiBold
                                        //                                        minimumPixelSize: 10;
                                        //                                        font.pixelSize: fontSize
                                        minimumPointSize: 10
                                        font.pointSize: fontSize
                                        font.bold: fontStyle === 0 ? false : true
                                        font.italic: fontStyle === 1 ? false : true
                                        color: parent.textColor

                                        font.family: fontDifference
                                        text: qsTr(message)

                                    }

                                    Image {
                                        id: newsElementImage
                                        height: 60
                                        width: 60
                                        anchors.verticalCenter: parent.verticalCenter
                                        //                                        anchors.rightMargin: 5
                                        anchors.bottomMargin: 5
                                        anchors.leftMargin: 5
                                        anchors.topMargin: 5
                                        anchors.left: parent.left
                                        source: "qrc:/icons/" + messageType +".png"
                                        visible: true
                                    }
                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            listview.currentIndex = index
                                            //                                            viewRectList.doubleClicked(hidden_id.text)
                                        }
                                        onDoubleClicked: {
                                            //                                            viewRectList.doubleClicked(hidden_id.text)
                                        }
                                    }

                                }


                            }
                            Component.onCompleted: {
                                announcement_rect.height = announcement_rect.height + height //+ newsElementText.height + 10
                            }
                        }

                    }
                    ListView {
                        id : listview
                        anchors.fill: parent
                        model: listmodel
                        anchors.topMargin: 10
                        boundsBehavior: Flickable.DragAndOvershootBounds
                        opacity: 1
                        maximumFlickVelocity: 2500
                        preferredHighlightEnd: 2
                        spacing: 5
                        z : parent.z+1
                        highlightRangeMode: ListView.NoHighlightRange
                        snapMode: ListView.SnapToItem
                        add: Transition {
                            NumberAnimation { properties: "x,y"; from: 100; duration: 1000 }
                        }
                        addDisplaced: Transition {
                            NumberAnimation { properties: "x,y"; duration: 1000 }
                        }
                        displaced: Transition {
                            NumberAnimation { properties: "x,y"; duration: 1000 }
                        }
                        anchors.horizontalCenter: parent.horizontalCenter
                        delegate: contactsDelegate
                        highlightMoveVelocity : 100
                        highlight: Rectangle { color:"blue" /*"lightsteelblue"*/; radius: 5 }
                        focus: false
                        highlightFollowsCurrentItem: true

                    }
                }
            }
        }
    }
}
