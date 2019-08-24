import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import com.Game.Player 1.0
import com.Game.APIConnection 1.0
import com.Game.News 1.0

Rectangle {
    id: root
    color: "transparent"
    property string titleBar: qsTr("Submit Contract to %1").arg(player.name)

    property Player player : Player{ id: tmpPlayer }
    property News news
    property int offer_id: 0


    function setPlayer(p) {
        player = p
        app_title_bar.title = titleBar
        app_title_bar.titleFontSize = 25
        app_title_bar.textColor = player.background1Value !== "" ? player.foreground1Value : app_title_bar.defaultTextColor;
        app_title_bar.selectedclubid = player.clubId        //app_title_bar.selectedplayer = "file:///" + applicationPath + "images/players/" + player.id + ".png"
        app_title_bar.setportrailVisible = false
        console.log("Manager club: " + managerUser.club + ", player club: " + player.clubId)
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"

        CustomGroupBox {
            id: transfer_value_gorup_box
            anchors.left: parent.left
            anchors.top: parent.top
            //width: 400
            anchors.right: parent.right
            height: 70
            title_text: qsTr("Contract requirments")
            border_color: "#55aaff"
            border_width: 1
            box_content_item: Rectangle
            {
                anchors.fill: parent
                color: "transparent"
                radius: parent.radius
                clip: true
                Text {
                    id: txt1
                    text: qsTr("%1 is requesting %2 per week").arg(player.name).arg(currencyFormatter.currencyString(player.value))
                    font.family: "Comic Sans MS"
                    color: "#ffffff"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    font.pointSize: 11
                    anchors.leftMargin: 20
                    anchors.topMargin: 10
                }
            }
        }

        CustomGroupBox {
            id: basic_offer_group_box
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: transfer_value_gorup_box.bottom
            anchors.topMargin: 20
            height: 200
            title_text: qsTr("Offer")
            border_color: "#55aaff"
            border_width: 1

            box_content_item:  Rectangle
            {
                anchors.fill: parent
                color: "transparent"
                radius: parent.radius
                clip: true
                Text {
                    id: squad_status_label
                    text: qsTr("Squad Status")
                    font.family: "Comic Sans MS"
                    color: "#ffffff"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    font.pointSize: 11
                    anchors.leftMargin: 20
                    anchors.topMargin: 10
                }
                CustomComboBox
                {
                    id: squad_status_combo_box
                    anchors.verticalCenter: squad_status_label.verticalCenter
                    items_list: [qsTr("Key Player"), qsTr("First Team"), qsTr("Relocation"), qsTr("Backup"), qsTr(""), qsTr("Hot Prospect"), qsTr("Youngster")]
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width/2 - 40
                    height: squad_status_label.height
                    width: parent.width/4
                    currentIndex: 0
                }

                Text
                {
                    id: wage_label
                    text: qsTr("Wage")
                    font.family: "Comic Sans MS"
                    color: "#ffffff"
                    anchors.left: parent.left
                    anchors.top: squad_status_label.bottom
                    font.pointSize: 11
                    anchors.leftMargin: 20
                    anchors.topMargin: 10
                }

                MyButtonNormal {
                    id: decrease_wage
                    anchors.verticalCenter: wage_label.verticalCenter
                    anchors.right: wage_combo_box.left
                    anchors.rightMargin: 5
                    height: wage_combo_box.height
                    width: height
                    text: "-"
                    onClicked:
                    {
                        wage_combo_box.displayText = currencyFormatter.currencyString(currencyFormatter.currencyValue(wage_combo_box.displayText) - 100);
                    }
                }
                CustomComboBox
                {
                    id: wage_combo_box
                    anchors.verticalCenter: wage_label.verticalCenter
                    items_list: [currencyFormatter.currencyString(player.wage)]
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width/2 - 40
                    height: wage_label.height
                    width: parent.width/4
                    currentIndex: 0
                }
                MyButtonNormal {
                    id: increase_wage
                    anchors.verticalCenter: wage_label.verticalCenter
                    anchors.left: wage_combo_box.right
                    anchors.leftMargin: 5
                    height: wage_combo_box.height
                    width: height
                    text: "+"
                    onClicked:
                    {
                        wage_combo_box.displayText = currencyFormatter.currencyString(currencyFormatter.currencyValue(wage_combo_box.displayText) + 100);
                    }
                }

                Text
                {
                    id: contract_length_label
                    text: qsTr("Contract Length")
                    font.family: "Comic Sans MS"
                    color: "#ffffff"
                    anchors.left: parent.left
                    anchors.top: wage_label.bottom
                    font.pointSize: 11
                    anchors.leftMargin: 20
                    anchors.topMargin: 10
                }
                CustomComboBox
                {
                    id: contract_lenght_combo_box
                    anchors.verticalCenter: contract_length_label.verticalCenter
                    items_list: [qsTr("One Year"), qsTr("Two Years"), qsTr("Three Years"), qsTr("Four Years"), qsTr("Five Years")]
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width/2 - 40
                    height: contract_length_label.height
                    width: parent.width/4
                    currentIndex: 0
                }

                Text
                {
                    id: signing_fee_label
                    text: qsTr("Signing on Fee")
                    font.family: "Comic Sans MS"
                    color: "#ffffff"
                    anchors.left: parent.left
                    anchors.top: contract_length_label.bottom
                    font.pointSize: 11
                    anchors.leftMargin: 20
                    anchors.topMargin: 10
                }
                MyButtonNormal {
                    id: decrease_signing_fee
                    anchors.verticalCenter: signing_fee_label.verticalCenter
                    anchors.right: signing_fee_combo_box.left
                    anchors.rightMargin: 5
                    height: signing_fee_combo_box.height
                    width: height
                    text: "-"
                    onClicked:
                    {
                        signing_fee_combo_box.displayText = currencyFormatter.currencyString(currencyFormatter.currencyValue(signing_fee_combo_box.displayText) - 1000);
                    }
                }
                CustomComboBox
                {
                    id: signing_fee_combo_box
                    anchors.verticalCenter: signing_fee_label.verticalCenter
                    items_list: [currencyFormatter.currencyString(player.wage)]
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width/2 - 40
                    height: signing_fee_label.height
                    width: parent.width/4
                    currentIndex: 0
                }
                MyButtonNormal {
                    id: increase_signing_fee
                    anchors.verticalCenter: signing_fee_label.verticalCenter
                    anchors.left: signing_fee_combo_box.right
                    anchors.leftMargin: 5

                    height: signing_fee_combo_box.height
                    width: height
                    text: "+"
                    onClicked:
                    {
                        signing_fee_combo_box.displayText = currencyFormatter.currencyString(currencyFormatter.currencyValue(signing_fee_combo_box.displayText) + 1000);
                    }
                }
            }
        }

        MyButtonNormal
        {
            id: confirm_button
            anchors.right: parent.right
            anchors.top: basic_offer_group_box.bottom
            anchors.topMargin: 20
            anchors.rightMargin: 10
            text: qsTr("Confirm Offer")
            onClicked: { confirm.visible = true }
            width: 120
        }
        MyButtonNormal
        {
            id: cancel_button
            anchors.top: confirm_button.top
            anchors.right: confirm_button.left
            anchors.rightMargin: 20
            text: qsTr("Withdraw Offer")
            onClicked: { app_title_bar.popPage() }
            width: confirm_button.width
        }

        CustomGroupBox {
            id: comments_gorup_box
            anchors.left: parent.left
            anchors.top: confirm_button.bottom
            anchors.topMargin: 30
            //width: 400
            anchors.right: parent.right
            height: 80
            title_text: qsTr("Comments")
            border_color: "#55aaff"
            border_width: 1
            box_content_item: Rectangle
            {
                anchors.fill: parent
                color: "transparent"
                radius: parent.radius
                clip: true
                Text {
                    id: txt3
                    text: qsTr("Overall valued is %1").arg(currencyFormatter.currencyString(player.value))
                    font.family: "Comic Sans MS"
                    color: "#ffffff"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    font.pointSize: 11
                    anchors.leftMargin: 20
                    anchors.topMargin: 5
                }
                Text {
                    id: txt4
                    text: qsTr("Player has minimum fee release clause of %1").arg(currencyFormatter.currencyString(player.minimumFee))
                    font.family: "Comic Sans MS"
                    color: "#ffffff"
                    anchors.left: txt3.left
                    anchors.top: txt3.bottom
                    font.pointSize: 11
                    anchors.topMargin: 5

                    property bool showHint: false
                    Rectangle{
                        id: knowledgehint
                        x:mouse.mouseX
                        y:mouse.mouseY
                        radius: 10
                        implicitWidth: hinttext.width+2
                        height: hinttext.height+2
                        visible: false
                        color: "#DAF7A6"
                        Text {
                            id: hinttext
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            padding: 5
                            font.pointSize: 9
                            text: qsTr("If the fees reach the minimum fees, the offer must be accepted.")
                            color:"gray"
                        }
                    }

                    MouseArea {
                        id: mouse
                        anchors.fill: parent
                        hoverEnabled:true
                        onHoveredChanged: {
                            if(parent.showHint === false){
                                knowledgehint.visible = true
                                parent.showHint = true
                            }else{
                                knowledgehint.visible = false
                                parent.showHint = false
                            }

                        }
                    }
                }
            }
        }
    }

    ConfirmationBox {
        id: confirm
        anchors.centerIn: parent
        confirm_button_text: qsTr("Confirm Contract")
        cancel_button_text: qsTr("Cancel")
        title: qsTr("Confirm Contract")
        question: qsTr("Confirm Contract of %1 to %2?").arg(wage_combo_box.displayText).arg(player.name)

        onConfirm_clicked: {
            visible = false
            //send offer to server
            app.busyIndicator.running = true

//http://173.208.200.82/?action=create_transfer_offer_contract&token=Z2s1NDU0NTQ1ZnNkZlVFc2Rmc2JEc2RoXzI3XzE1NTI1ODQ1MTY=&offer_id=92&
//squad_status=Rotation&job=Player&wage=10000&contract_type=Full%20Time&contract_length=3&signing_on_fee=5000000

            var params = "action=create_transfer_offer_contract&token=%1&offer_id=%2&squad_status=%3&job=Player&wage=%4&contract_type=%5&contract_length=%6&signing_on_fee=%7"
            APIConnection.createOfferContract(params.arg(managerUser.token)
                                              .arg(root.offer_id)
                                              .arg(squad_status_combo_box.currenText)
                                              .arg(currencyFormatter.currencyValue(wage_combo_box.displayText))
                                              .arg("Full%20Time")
                                              .arg(contract_lenght_combo_box.currentIndex+1)
                                              .arg(currencyFormatter.currencyValue(signing_fee_combo_box.displayText)));
        }

        onCancel_clicked:  {
            visible = false
        }
    }

    Connections {
        target: APIConnection

        onSubmitTransferOfferFinished: {
            app.busyIndicator.running = false
            if(player.id !== player_id) {
                alerts.show(qsTr("Wrong player id returned..."), "red");
            }
            else {
                alerts.show(message, "green");
                root.player.offerId = offer_id;
                app_title_bar.popPage();
            }
        }

        onGetTransferOfferWithPlayerDetailsFinished : {
            //    (int offer_id, int player_id, QString player_name, int oci, QString ocn, int bci, QString bcn, int fee, int minimum_fee);
            app.busyIndicator.running = false
            root.offer_id = offer_id;
            root.player = player;

            titleBar = qsTr("Offer Contract to %1").arg(player.name)
            app_title_bar.title = titleBar
        }
    }
}
