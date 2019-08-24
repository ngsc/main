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

//        console.log("Manager club: " + managerUser.clubId + ", player club: " + player.clubId)
    }

    Rectangle {

        color: "light gray"
        border.color: "black"
        anchors.fill: parent

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
//        property string status: (player.clubId !== 0 ?  qsTr("\n Bosman") : qsTr("\n free"))
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: 9
        font.family: "Comic Sans MS"
        text: qsTr("Actions")//+ status )
        anchors.centerIn: parent
    }

    Menu {
        id: menu
        width: 150
        MenuItem {
            id: directsign
            text: qsTr("Direct Sign")
            enabled:  player.getPlayertype === "Free Player" || player.getPlayertype === "Bosman"//true //player.clubId !== managerUser.clubId //player.clubId !== 0  && player.offerId === 0&&
            background: directsignbackground//enabled ? "white" : "gray"

            onClicked: {
                directSign.playerName = player.name
                app.callinsidepage2(directSign)

//                app.callinsidepage2(submitOffer)
//                submitOffer.setPlayer(player)
            }
            Rectangle
            {
                id: directsignbackground
                anchors.fill: parent
                border.color: "black"
                color: directsign.enabled ? "light gray" :"white"
            }
        }

        MenuItem {
            id: submitOfferAction
            text: qsTr("Submit offer")
            enabled:  player.clubId !== managerUser.clubId && player.getPlayertype !== "Free Player" && player.offerId === 0//||player.getPlayertype==="Bosman"//
            background: background//enabled ? "white" : "gray"

            onClicked: {
                app.callinsidepage2(submitOffer)
                submitOffer.setPlayer(player)
            }
            Rectangle
            {
                id: background
                anchors.fill: parent
                border.color: "black"
                color: submitOfferAction.enabled ? "light gray" :"white"
            }
        }

        MenuItem {
            id: withdrawOfferAction
            text: qsTr("Withdraw Offer")
            enabled: player.clubId !== managerUser.clubId && player.offerId !== 0 && player.getPlayertype !== "Free Player"
//            visible: enabled
//            height: visible ? implicitHeight : 0
            background: withdrawOfferActionbackground
            onClicked: {
                //withdraw offer
                withdrawofferbox.visible = true
                withdrawofferbox.offerId = player.offerId
            }
            Rectangle
            {
                id: withdrawOfferActionbackground
                anchors.fill: parent
                border.color: "black"
                color: withdrawOfferAction.enabled ? "light gray" :"white"
            }
        }

        MenuItem {
            id: changeOfferAction
            text: qsTr("Change Offer")
            enabled: player.clubId !== managerUser.clubId && player.offerId !== 0 && player.getPlayertype !== "Free Player"
//            visible: enabled
//            height: visible ? implicitHeight : 0
            background: changeOfferActionbackground
            onClicked: {
                //change offer
                app.callinsidepage2(submitOffer)
                submitOffer.setPlayer(player)
                app.busyIndicator.running = true
                APIConnection.getOffer(managerUser.token, player.offerId)
            }
            Rectangle
            {
                id: changeOfferActionbackground
                anchors.fill: parent
                border.color: "black"
                color: changeOfferAction.enabled ? "light gray" :"white"
            }
        }

        MenuItem {
            id: viewOffer
            text: qsTr("View Offers")
            enabled: player.clubId !== managerUser.clubId && player.offerId !== 0 && player.getPlayertype !== "Free Player"
//            visible: enabled
//            height: visible ? implicitHeight : 0
            background:viewOfferbackground
            Rectangle
            {
                id: viewOfferbackground
                anchors.fill: parent
                border.color: "black"
                color: viewOffer.enabled ? "light gray" :"white"
            }
        }

        MenuItem {
            id: offerToClub
            text: qsTr("offer to club")
            enabled: player.clubId === managerUser.clubId //&& player.offerId !== 0 && player.getPlayertype !== "Free Player"
//            visible: enabled
//            height: visible ? implicitHeight : 0
            background:offerToClubbackground
            onClicked: {
                //change offer
                offerToClubPage.fillFeeList()
                app.callinsidepage2(offerToClubPage)
                clubPage.setClub()
//                submitOffer.setPlayer(player)
//                app.busyIndicator.running = true
//                APIConnection.getOffer(managerUser.token, player.offerId)
            }
            Rectangle
            {
                id: offerToClubbackground
                anchors.fill: parent
                border.color: "black"
                color: offerToClub.enabled ? "light gray" :"white"
            }
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
