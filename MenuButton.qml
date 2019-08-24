import QtQuick 2.4
import QtQuick.Controls 2.0
import com.Game.APIConnection 1.0
import com.Game.Player 1.0

Rectangle{
    id : root
    //text: "Actions"
    color: "transparent"

    property Player player : Player{ id: tmpPlayer

        onOfferIdChanged: {
            console.log("Offer id is: " + offerId)
        }
    }

    function setPlayer(p) {
        player = p

        console.log("Manager club: " + managerUser.clubId + ", player club: " + player.clubId)
    }

    Rectangle {

        color: "light gray"
        border.color: "black"
        anchors.fill: parent

        MouseArea{
            anchors.fill:parent
            hoverEnabled:true
            cursorShape: Qt.PointingHandCursor
        }
        MouseArea {
            id:moustAreaSquad
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onEntered: {
                color = "grey"
            }
            onExited: {
                color = "light gray"
            }
            onClicked: {
                console.log("open menu...");
                menu.open()
            }

        }
    }

    Text{
        id: label1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: 9
        font.family: "Comic Sans MS"
        text: qsTr("Actions")
        anchors.centerIn: parent
    }



    Menu {
        id: menu
        MenuItem {
            id: submitOfferAction
            text: qsTr("Submit offer")
            enabled: player.clubId !== 0 && player.clubId !== managerUser.clubId && player.offerId === 0

            onClicked: {
                app.callinsidepage2(submitOffer)
                submitOffer.setPlayer(player)
            }
        }

        MenuItem {
            id: withdrawOfferAction
            text: qsTr("Withdraw Offer")
            enabled: player.clubId !== managerUser.clubId && player.offerId !== 0
            visible: enabled
            height: visible ? implicitHeight : 0

            onClicked: {
                //withdraw offer
                withdrawofferbox.visible = true
                withdrawofferbox.offerId = player.offerId
            }
        }

        MenuItem {
            id: changeOfferAction
            text: qsTr("Change Offer")
            enabled: player.clubId !== managerUser.clubId && player.offerId !== 0
            visible: enabled
            height: visible ? implicitHeight : 0

            onClicked: {
                //change offer
                app.callinsidepage2(submitOffer)
                submitOffer.setPlayer(player)
                app.busyIndicator.running = true
                APIConnection.getOffer(managerUser.token, player.offerId)
            }
        }

        MenuItem {
            id: viewOffer
            text: qsTr("View Offers")
            enabled: player.clubId !== managerUser.clubId && player.offerId !== 0
            visible: enabled
            height: visible ? implicitHeight : 0
        }
    }


    Connections {
        target: APIConnection

        onWithdrawOfferFinished: {
            app.busyIndicator.running = false
            if(player.id !== player_id) {
                alerts.show("Wrong player id returned...", "red");
            }
            else {
                player.offerId = 0;
                alert(message, "green")
            }
        }
    }
}
