import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0
import com.Game.APIConnection 1.0

Rectangle
{
    id: directSign
    color: "transparent"
    anchors.margins: 20
    property string titleBar: qsTr("Direct Sign")
    property string playerName

    CustomGroupBox {
        id : contractReq
        width: parent.width - 40
        height: parent.height/6
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10
        title_text: qsTr("Contract Requirements")
        border_color: "#55aaff"
        border_width: 1
        box_content_item: Rectangle {
            anchors.fill: parent
            color: "transparent"
            radius: parent.radius
            clip: true
            Text {
                id: contract_label
                text: qsTr(playerName + " is requesting $ per week")
                font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                color: "#ffffff"
                anchors.left: parent.left
                anchors.top: parent.top
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment : Text.AlignVCenter
                font.pointSize: 11
                anchors.leftMargin: 20
                anchors.topMargin: 10
            }
        }
    }

    CustomGroupBox {
        id : offer
        width: parent.width - 40
        height: parent.height/2
        anchors.top: contractReq.bottom
        anchors.left: parent.left
        anchors.margins: 10
        title_text: qsTr("Offer")
        border_color: "#55aaff"
        border_width: 1
        box_content_item: Rectangle {
            anchors.fill: parent
            color: "transparent"
            radius: parent.radius
            clip: true
            Text {
                id: squad_status_label
                text: qsTr("squad status")
                font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                color: "#ffffff"
                anchors.left: parent.left
                anchors.top: parent.top
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment : Text.AlignVCenter
                font.pointSize: 11
                anchors.leftMargin: 20
                anchors.topMargin: 15
            }
            Text {
                id: wage_label
                text: qsTr("wage")
                font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                color: "#ffffff"
                anchors.left: parent.left
                anchors.top: squad_status_label.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment : Text.AlignVCenter
                font.pointSize: 11
                anchors.leftMargin: 20
                anchors.topMargin: 15
            }
            Text {
                id: contract_lenght_label
                text: qsTr("contract lenght")
                font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                color: "#ffffff"
                anchors.left: parent.left
                anchors.top: wage_label.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment : Text.AlignVCenter
                font.pointSize: 11
                anchors.leftMargin: 20
                anchors.topMargin: 15
            }
            Text {
                id: signing_on_fee_label
                text: qsTr("signing on fee")
                font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                color: "#ffffff"
                anchors.left: parent.left
                anchors.top: contract_lenght_label.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment : Text.AlignVCenter
                font.pointSize: 11
                anchors.leftMargin: 20
                anchors.topMargin: 15
            }
        }
    }

    CustomGroupBox {
        id : comment
        width: parent.width - 40
        height: parent.height/6
        anchors.top: offer.bottom
        anchors.left: parent.left
        anchors.margins: 10
        title_text: qsTr("Comments")
        border_color: "#55aaff"
        border_width: 1
        box_content_item: Rectangle {
            anchors.fill: parent
            color: "transparent"
            radius: parent.radius
            clip: true
            Text {
                id: comment_label
                text: qsTr(playerName + "  current wage is $ per week")
                font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                color: "#ffffff"
                anchors.left: parent.left
                anchors.top: parent.top
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment : Text.AlignVCenter
                font.pointSize: 11
                anchors.leftMargin: 20
                anchors.topMargin: 10
            }
        }
    }

    MyButtonNormal
    {
        id: confirm_button
        anchors.right: parent.right
        anchors.top: comment.bottom
        anchors.margins: 10
        width: 150
        text: qsTr("confirm offer")
//        onClicked: { confirm.visible = true }
    }
    MyButtonNormal
    {
        id: withdraw_button
        anchors.top: comment.bottom
        anchors.right: confirm_button.left
        anchors.margins: 10
        width: 150
        text: qsTr("withdraw offer")
//        onClicked: { app_title_bar.popPage() }
    }
}
