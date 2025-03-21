/*
** Added by Ahmed Soliman
** For further information use the contact form at AhmedSoliman_1234@hotmail.com.
*/
import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Rectangle{
    id : viewRectList
    width: parent.width
    height: parent.height
    color: "transparent"
    border.color: "transparent"
    property var listmodel
    property string backgroungcolor : "light blue"
    property string textcolor : "black"

    signal doubleClicked(int id)

    function getcurrentindex(){
        return listview.currentIndex
    }
    function setcurrentindex(value){
        listview.currentIndex = value
    }



    Rectangle {

        width: parent.width-30; height: parent.height - 40
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top : parent.top
        anchors.topMargin: 10
        color: "transparent"
        border.color: "transparent"
        ScrollView
        {
            id: announcement_board_scroll_view
            anchors.rightMargin: 5
            anchors.right: parent.right
            width: parent.width
            height: parent.height
            anchors.topMargin: 10
            anchors.leftMargin: 10
            anchors.margins: 2
            horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
            style: ScrollViewStyle{
                handle: ScrollBarHandle{}
                scrollBarBackground: ScrollBarBackground {
                    id: announcement_board_scroll_view_background
                    implicitWidth: 15
                    implicitHeight: announcement_board_scroll_view.height-(30)+10
                }
                decrementControl: ScrollBarDecrementControl{}
                incrementControl: ScrollBarIncrementControl{}
            }
            visible: (parent.height>30) ? true : false
            Rectangle
            {
                width : viewRectList.width
                height: 500
                color: backgroungcolor
                opacity: 1
                anchors.topMargin: 10
                border.color: "green"

                Component {
                    id: contactsDelegate
                    Item {
                        width: parent.width; height: 20
                        Column {
                            Text {
                                id: hidden_id
                                text: id
                                visible: false
                            }
                            Text {
                                text: qsTr("  "+name)
                                color: textcolor
                                z : listview.z
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        listview.currentIndex = index
                                        viewRectList.doubleClicked(hidden_id.text)
                                    }
                                    onDoubleClicked: {
                                        viewRectList.doubleClicked(hidden_id.text)
                                    }
                                }
                            }
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
                    highlightMoveVelocity : 50
                    highlight: Rectangle { color:"blue" /*"lightsteelblue"*/; radius: 5 }
                    focus: true
                    highlightFollowsCurrentItem: true

                }
            }
        }
    }
}
