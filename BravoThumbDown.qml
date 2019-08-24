import QtQuick 2.0
import com.Game.APIConnection 1.0

Rectangle {

    width: 60
    height: 60
    color: "transparent"

    property int likeRateText: 0
    property int dislikeRateText: 0
    property int playerID: 0
    property string playerName: ""
    property string status: ""

    Image {
        id: likeImage
        anchors.left: parent.left
        anchors.top: parent.top
        source: "qrc:/icons/like.png"
        width: 30
        //        scale: 1.3
        height: 30
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor //ownerId === 0 ? Qt.PointingHandCursor : Qt.ArrowCursor
            acceptedButtons: Qt.LeftButton
            onPressed: {
                likeRateText++;
                APIConnection.increasePlayerRate(managerUser.token, playerID)
            }
            onHoveredChanged: {

            }
            onEntered: {
                selectedhint.z = likeImage.z + 1
                status = "increase"
                selectedhint.x = likeImage.x + 32
                selectedhint.y = likeImage.y //+ 15
                selectedhint.visible = true
                parent.scale = 1.2
            }
            onExited: {
                selectedhint.visible = false
                parent.scale = 1
            }
        }
    }
    Image {
        id: dislikeImage
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        source: "qrc:/icons/dislike.png"
        width: 30
        //        scale: 1.3
        height: 30
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor //ownerId === 0 ? Qt.PointingHandCursor : Qt.ArrowCursor
            acceptedButtons: Qt.LeftButton
            onPressed: {
                dislikeRateText++;
                APIConnection.decreasePlayerRate(managerUser.token, playerID)
            }
            onHoveredChanged: {

            }
            onEntered: {
                selectedhint.z = dislikeImage.z + 1
                status = "decrease"
                selectedhint.x = dislikeImage.x + 32
                selectedhint.y = dislikeImage.y //+ 15
                selectedhint.visible = true
                parent.scale = 1.2
            }
            onExited: {
                selectedhint.visible = false
                parent.scale = 1
            }
        }
    }

    Text {
        id: likeText
        anchors.right: parent.right
        anchors.top: parent.top
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: qsTr(likeRateText.toString())
        width: 30
        color: "white"
        height: 30
    }

    Text {
        id: dislikeText
        anchors.right: parent.right
        anchors.top: likeText.bottom
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: qsTr("-"+dislikeRateText.toString())
        width: 30
        color: "white"
        height: 30
    }

    Rectangle {
        id: selectedhint
        radius: 10
        implicitWidth: selectedhinttext.width + 10
        height: selectedhinttext.height + 5
        visible: false
        ///anchors.leftMargin: 30
        color: "#DAF7A6"
        Text {
            id: selectedhinttext
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            //padding: 5
            font.pointSize: 9
            text: qsTr("%1 %2 Rate").arg(status).arg(playerName)
            color: "black"
        }
    }
}
