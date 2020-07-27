import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import com.Game.Player 1.0
import com.Game.APIConnection 1.0
import com.Game.News 1.0
import Constants 1.0

Rectangle {
    id: root
    color: "transparent"

    property string titleBar: qsTr("Offer to %1").arg(player.name)
    property string owner_club_name: ""
    property int owner_club_id: 0
    property string bidding_club_name: ""
    property int bidding_club_id: 0
    property int fee: 0
    property int offer_id: 0
    property string offer_type: "transfer"

    //loan properties
    //int offer_id, Player* player, int oci, QString ocn, int bci, QString bcn, int fee,
    //int future_fee, int wages, QString duration, QString duration_type, bool can_play_in_cup, bool can_play_against, bool can_be_recalled);

    property int future_fee: 0
    property int wages: 0
    property string duration: ""
    property string duration_type: ""
    property bool can_play_in_cup: false
    property bool can_play_against: false
    property bool can_be_recalled: false

    property Player player : Player{ id: tmpPlayer }
    property News news

    Rectangle {
        anchors.fill: parent
        color: "transparent"

        CustomGroupBox {
            id: transfer_value_gorup_box
            anchors.left: parent.left
            anchors.top: parent.top
            //width: 400
            anchors.right: parent.right
            height: 80
            title_text: qsTr("Transfer Value")
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
                    text: qsTr("%1's %2 is currently valued at %3").arg(root.owner_club_name).arg(player.name).arg(currencyFormatter.currencyString(player.value))
                    font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                    color: "#ffffff"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    font.pointSize: 11
                    anchors.leftMargin: 20
                    anchors.topMargin: 5
                }
                Text {
                    id: txt2
                    text: {
                        var club_name = root.owner_club_name
                        if(news.stage !== News.OwnerClubDemandPrice)
                            club_name = root.bidding_club_id;
                        return qsTr("%1 are demanding %2 for %3").arg(club_name).arg(currencyFormatter.currencyString(root.fee)).arg(player.name)
                    }
                    font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                    color: "#ffffff"
                    anchors.left: txt1.left
                    anchors.top: txt1.bottom
                    font.pointSize: 11
                    anchors.topMargin: 2
                }
            }
        }

        CustomGroupBox {
            id: basic_offer_group_box
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: transfer_value_gorup_box.bottom
            anchors.topMargin: 1
            height: offer_combo_box.currentIndex === 0 ? 120 : 185
            title_text: qsTr("Basic Offer")
            border_color: "#55aaff"
            border_width: 1

            box_content_item:  Rectangle
            {
                anchors.fill: parent
                color: "transparent"
                radius: parent.radius
                clip: true
                Text {
                    id: offer_label
                    text: qsTr("Offer Type")
                    font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                    color: "#ffffff"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    font.pointSize: 11
                    anchors.leftMargin: 20
                    anchors.topMargin: 10
                }
                CustomComboBox
                {
                    id: offer_combo_box
                    anchors.verticalCenter: offer_label.verticalCenter
                    items_list: [qsTr("Transfer"), qsTr("Loan")]
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width/2 - 40
                    height: offer_label.height+5
                    width: parent.width/4
                    currentIndex: news.offerType === News.Transfer ? 0 : 1
                    enabled: false
                }
                Rectangle {
                    id: transfer_details_rectangle
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: offer_combo_box.bottom
                    anchors.bottom: parent.bottom
                    color: "transparent"
                    visible: offer_combo_box.currentIndex === 0
                    Text
                    {
                        id: transfer_fees_label
                        text: qsTr("Fees")
                        font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                        color: "#ffffff"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        font.pointSize: 11
                        anchors.leftMargin: 20
                        anchors.topMargin: 10
                    }
                    MyButtonNormal {
                        id: transfer_decrease_fees
                        anchors.verticalCenter: transfer_fees_label.verticalCenter
                        anchors.right: transfer_fees_combo_box.left
                        anchors.rightMargin: 5
                        height: transfer_fees_combo_box.height
                        width: height
                        text: "-"
                        z: parent.z + 1
                        onClicked:
                        {
                            transfer_fees_combo_box.displayText = currencyFormatter.currencyString(currencyFormatter.currencyValue(transfer_fees_combo_box.displayText) - 250000);
                        }
                    }
                    CustomComboBox
                    {
                        id: transfer_fees_combo_box
                        anchors.verticalCenter: transfer_fees_label.verticalCenter
                        items_list: [currencyFormatter.currencyString("9000000"),
                            currencyFormatter.currencyString("9250000"),
                            currencyFormatter.currencyString("9500000"),
                            currencyFormatter.currencyString("9750000"),
                            currencyFormatter.currencyString("10000000")]
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width/2 - 40
                        height: transfer_fees_label.height+5
                        width: parent.width/4
                        currentIndex: 0
                    }
                    MyButtonNormal {
                        id: transfer_increase_fees
                        anchors.verticalCenter: transfer_fees_label.verticalCenter
                        anchors.left: transfer_fees_combo_box.right
                        anchors.leftMargin: 5
                        height: transfer_fees_combo_box.height
                        width: height
                        text: "+"
                        onClicked:
                        {
                            transfer_fees_combo_box.displayText = currencyFormatter.currencyString(currencyFormatter.currencyValue(transfer_fees_combo_box.displayText) + 250000);
                        }
                    }

                    Text
                    {
                        id: transfer_flexibility_label
                        text: qsTr("Flexibility")
                        font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                        color: "#ffffff"
                        anchors.left: parent.left
                        anchors.top: transfer_fees_label.bottom
                        font.pointSize: 11
                        anchors.leftMargin: 20
                        anchors.topMargin: 10
                    }
                    CustomComboBox
                    {
                        id: flexibility_combo_box
                        anchors.verticalCenter: transfer_flexibility_label.verticalCenter
                        items_list: [qsTr("Allow Negotiation"), qsTr("Non Negotiable")]
                        anchors.left: transfer_fees_combo_box.left
                        height: transfer_flexibility_label.height+5
                        anchors.verticalCenterOffset: 3
                        anchors.leftMargin: 1
                        width: parent.width/4
                        currentIndex: 0
                    }
                }   //transfer_details_rectangle
                ////////////////////////////////////////////////////////////
                Rectangle {
                    id: loan_details_rectangle
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: offer_combo_box.bottom
                    anchors.bottom: parent.bottom
                    color: "transparent"
                    visible: offer_combo_box.currentIndex === 1

                    Text
                    {
                        id: loan_fees_label
                        text: qsTr("Fees")
                        font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                        color: "#ffffff"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        font.pointSize: 11
                        anchors.leftMargin: 20
                        anchors.topMargin: 10
                    }

                    MyButtonNormal {
                        id: loan_decrease_fees
                        anchors.verticalCenter: loan_fees_label.verticalCenter
                        anchors.right: loan_fees_combo_box.left
                        anchors.rightMargin: 5
                        height: loan_fees_combo_box.height
                        width: height
                        text: "-"
                        onClicked:
                        {
                            loan_fees_combo_box.displayText = currencyFormatter.currencyString(currencyFormatter.currencyValue(loan_fees_combo_box.displayText) - 25000);
                        }
                    }
                    CustomComboBox
                    {
                        id: loan_fees_combo_box
                        anchors.verticalCenter: loan_fees_label.verticalCenter
                        items_list: [currencyFormatter.currencyString(player.value/10)]
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width/2 - 40
                        height: loan_fees_label.height+5
                        width: parent.width/4
                        currentIndex: 0
                    }
                    MyButtonNormal {
                        id: loan_increase_fees
                        anchors.verticalCenter: loan_fees_label.verticalCenter
                        anchors.left: loan_fees_combo_box.right
                        anchors.leftMargin: 5
                        height: loan_fees_combo_box.height
                        width: height
                        text: "+"
                        onClicked:
                        {
                            loan_fees_combo_box.displayText = currencyFormatter.currencyString(currencyFormatter.currencyValue(loan_fees_combo_box.displayText) + 25000);
                        }
                    }

                    Text
                    {
                        id: loan_duration_label
                        text: qsTr("Duration")
                        font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                        color: "#ffffff"
                        anchors.left: parent.left
                        anchors.top: loan_fees_label.bottom
                        font.pointSize: 11
                        anchors.leftMargin: 20
                        anchors.topMargin: 10
                    }
                    CustomComboBox
                    {
                        id: loan_duration_combo_box
                        anchors.verticalCenter: loan_duration_label.verticalCenter
                        items_list: [qsTr("End of Season"), qsTr("One Month"), qsTr("Three Months")]
                        anchors.left: loan_fees_combo_box.left
                        height: loan_duration_label.height+5
                        width: parent.width/4
                        currentIndex: 0
                    }

                    Text
                    {
                        id: loan_wages_label
                        text: qsTr("Wages")
                        font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                        color: "#ffffff"
                        anchors.left: parent.left
                        anchors.top: loan_duration_label.bottom
                        font.pointSize: 11
                        anchors.leftMargin: 20
                        anchors.topMargin: 10
                    }
                    CustomComboBox
                    {
                        id: loan_wages_combo_box
                        anchors.verticalCenter: loan_wages_label.verticalCenter
                        items_list: [qsTr("0%"), qsTr("20%"), qsTr("50%"), qsTr("80%")]
                        anchors.left: loan_future_fees_combo_box.left
                        height: loan_wages_label.height+5
                        width: parent.width/4
                        currentIndex: 0
                    }

                    Text
                    {
                        id: loan_future_fees_label
                        text: qsTr("Future Fees")
                        font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                        color: "#ffffff"
                        anchors.left: parent.left
                        anchors.top: loan_wages_label.bottom
                        font.pointSize: 11
                        anchors.leftMargin: 20
                        anchors.topMargin: 10
                    }

                    MyButtonNormal {
                        id: loan_future_decrease_fees
                        anchors.verticalCenter: loan_future_fees_label.verticalCenter
                        anchors.right: loan_future_fees_combo_box.left
                        anchors.rightMargin: 5
                        height: loan_future_fees_combo_box.height
                        width: height
                        text: "-"
                        radius: 0
                        onClicked:
                        {
                            loan_future_fees_combo_box.displayText = currencyFormatter.currencyString(currencyFormatter.currencyValue(loan_future_fees_combo_box.displayText) - 250000);
                        }
                    }
                    CustomComboBox
                    {
                        id: loan_future_fees_combo_box
                        anchors.verticalCenter: loan_future_fees_label.verticalCenter
                        items_list: [currencyFormatter.currencyString(player.value)]
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width/2 - 40
                        height: loan_future_fees_label.height+5
                        width: parent.width/4
                        currentIndex: 0
                    }
                    MyButtonNormal {
                        id: loan_future_increase_fees
                        anchors.verticalCenter: loan_future_fees_label.verticalCenter
                        anchors.left: loan_future_fees_combo_box.right
                        anchors.leftMargin: 5
                        height: loan_future_fees_combo_box.height
                        width: height
                        text: "+"
                        radius: 0
                        onClicked:
                        {
                            loan_future_fees_combo_box.displayText = currencyFormatter.currencyString(currencyFormatter.currencyValue(loan_future_fees_combo_box.displayText) + 250000);
                        }
                    }
                }   //loan_details_rectangle
            }

        }

        MyButtonNormal
        {
            id: confirm_button
            anchors.right: parent.right
            anchors.bottom: comments_gorup_box.top
            anchors.bottomMargin: 5
            anchors.rightMargin: 5
            width: 130
            text: news.stage === News.OwnerClubDemandPrice ? qsTr("Accept Demand") : qsTr("Accept Proposal")
            enabled: !negotiate_button.visible
            onClicked: { confirm.visible = true }
        }

        MyButtonNormal
        {
            id: negotiate_button
            anchors.top: confirm_button.top
            anchors.right: parent.right
            width: confirm_button.width + 5 + 5
            text: news.stage === News.OwnerClubDemandPrice ? qsTr("Make New Proposal") : qsTr("Negotiate  Proposal")
            visible: {
                if(news.offerType === News.Transfer)
                    return transfer_fees_combo_box.displayText !== currencyFormatter.currencyString(root.fee);
                else if(news.offerType === News.Loan)
                    return loan_fees_combo_box.displayText !== currencyFormatter.currencyString(root.fee);
            }
            onClicked: { negotiate.visible = true }
        }

        MyButtonNormal
        {
            id: cancel_button
            anchors.top: confirm_button.top
            anchors.right: confirm_button.left
            anchors.rightMargin: 5
            text: qsTr("Reject")
            onClicked: { reject.visible = true }
        }

        MyButtonNormal
        {
            id: restore_button
            anchors.top: confirm_button.top
            anchors.right: parent.right
            anchors.rightMargin: 5 + confirm_button.width + 5
            text: qsTr("Restore")
            visible: negotiate_button.visible
            onClicked: {
                if(news.offerType === News.Transfer)
                    transfer_fees_combo_box.displayText = currencyFormatter.currencyString(root.fee);
                else if(news.offerType === News.Loan) {
                    loan_fees_combo_box.displayText = currencyFormatter.currencyString(root.fee);
                    loan_future_fees_combo_box.displayText = currencyFormatter.currencyString(root.future_fee)
                    loan_wages_combo_box.displayText = root.wages + "%"
                    loan_duration_combo_box.displayText = root.duration
                }
            }
        }

        CustomGroupBox {
            id: loan_option_gorup_box
            anchors.top: basic_offer_group_box.bottom
            anchors.topMargin: 1
            anchors.left: parent.left
            anchors.bottom: comments_gorup_box.top
            anchors.bottomMargin: 5
            anchors.right: cancel_button.left
            height: 80
            title_text: qsTr("Loan Option")
            border_color: "#55aaff"
            border_width: 1
            visible: news.offerType === News.Loan
            box_content_item: Rectangle
            {
                anchors.fill: parent
                color: "transparent"
                radius: parent.radius
                clip: true
                CheckBox
                {
                    id: recall_check_box
                    anchors.verticalCenter: recall_label.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    checked: root.can_be_recalled
                    style: CheckBoxStyle
                    {
                        indicator: Rectangle {
                            height: recall_label.height
                            width: height
                            radius: 3
                            color: "#3b76b1"
                            border.color: control.activeFocus ? "#ffffff" : "gray"
                            border.width: 1
                            Image
                            {
                                anchors.fill: parent
                                fillMode: Image.Stretch
                                source: "qrc:/icons/check-white.png"
                                visible: recall_check_box.checked? true: false
                            }
                        }
                    }
                }

                Text
                {
                    id: recall_label
                    text: qsTr("Can be recalled")
                    font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                    color: "#ffffff"
                    anchors.left: recall_check_box.right
                    anchors.top: parent.top
                    font.pointSize: 11
                    anchors.rightMargin: 2
                    anchors.topMargin: 20
                }
            }
        }

        CustomGroupBox {
            id: comments_gorup_box
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            //width: 400
            anchors.right: parent.right
            height: 75
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
                    font.family: Constants.primaryFont ? Constants.primaryFont.name: null
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
                    font.family: Constants.primaryFont ? Constants.primaryFont.name: null
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
                        z: parent.z+1
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

    //cancle and send buttons
    ConfirmationBox {
        id: confirm
        anchors.centerIn: parent
        confirm_button_text: qsTr(confirm_button.text)
        cancel_button_text: qsTr("Cancel")
        title: confirm_button.text
        question: qsTr("%1 of %2 to %3?").arg(confirm.title).arg(news.offerType === News.Transfer ? transfer_fees_combo_box.displayText: loan_fees_combo_box.displayText).arg(player.name)

        onConfirm_clicked: {
            visible = false
            app.busyIndicator.running = true

            if((news.stage === News.OfferCreated) || (news.stage === News.BidingClubMakeNewBid) || (news.stage === News.OwnerClubDemandPrice)) {
                APIConnection.acceptOffer(managerUser.token, offer_id, "None");
                app_title_bar.popPage();
            }
        }

        onCancel_clicked:  {
            visible = false
        }
    }

    ConfirmationBox {
        id: reject
        anchors.centerIn: parent
        confirm_button_text: qsTr("Reject Offer")
        cancel_button_text: qsTr("Cancel")
        title: qsTr("Reject Offer")
        question: qsTr("Reject offer from %1 for %2?").arg(root.bidding_club_name).arg(player.name)

        onConfirm_clicked: {
            visible = false
            app.busyIndicator.running = true
            APIConnection.rejectOffer(managerUser.token, offer_id, "None");
            app_title_bar.popPage();
        }

        onCancel_clicked:  {
            visible = false
        }
    }

    ConfirmationBox {
        id: negotiate
        anchors.centerIn: parent
        confirm_button_text: qsTr("Negotiate Offer")
        cancel_button_text: qsTr("Cancel")
        title: qsTr("Negotiate Offer")
        question: qsTr("Negotiate offer of %1 to %2?").arg(news.offerType === News.Transfer ? transfer_fees_combo_box.displayText: loan_fees_combo_box.displayText).arg(player.name)

        onConfirm_clicked: {
            visible = false
            app.busyIndicator.running = true

            if(news.stage === News.OfferCreated)    //send negotiate offer only the first time
                APIConnection.negotiateOffer(managerUser.token, offer_id);

            if(news.offerType === News.Transfer) {
                var params = "action=change_transfer_details&token=%1&offer_id=%2&fee=%3&minimum_fee=%4"
                var fees = currencyFormatter.currencyValue(transfer_fees_combo_box.displayText);
                APIConnection.changeOffer(params.arg(managerUser.token).arg(offer_id).arg(fees).arg(player.minimumFee));
            }
            else if(news.offerType === News.Loan) {
                var params = "action=change_loan_details&token=%1&offer_id=%2&minimum_fee=%3&fee=%4&duration=%5&wages=%6&futureFee=%7&canPlayInCup=0&canPlayAgainst=0&canBeRecalled=%8"
                var duration = loan_duration_combo_box.displayText;
                var wages = loan_wages_combo_box.displayText.replace("%", "");
                var fees = currencyFormatter.currencyValue(transfer_loan_combo_box.displayText);
                var future_fee = currencyFormatter.currencyValue(loan_future_fees_combo_box.displayText)
                var recall = recall_check_box.checked ? "1" : "0"

                APIConnection.changeOffer(params.arg(managerUser.token).arg(offer_id).arg(player.minimumFee).arg(fees).
                                          arg(duration).arg(wages).arg(future_fee).arg(recall));
            }

            app_title_bar.popPage();
        }

        onCancel_clicked:  {
            visible = false
        }
    }

    Connections {
        target: APIConnection

        onGetTransferOfferWithPlayerDetailsFinished : {
            //    (int offer_id, int player_id, QString player_name, int oci, QString ocn, int bci, QString bcn, int fee, int minimum_fee);
            app.busyIndicator.running = false
            root.offer_id = offer_id;
            root.player = player;
            root.owner_club_id = oci;
            root.owner_club_name = ocn;
            root.bidding_club_id = bci;
            root.bidding_club_name = bcn;
            root.fee = fee;
            //root.minimum_fee = minimum_fee;

            titleBar = qsTr("View transfer offer for %1").arg(player.name)
            app_title_bar.title = titleBar
            transfer_fees_combo_box.displayText = currencyFormatter.currencyString(root.fee);
        }

        onGetLoanOfferWithPlayerDetailsFinished: {
            //int offer_id, Player* player, int oci, QString ocn, int bci, QString bcn, int fee,
            //int future_fee, int wages, QString duration, QString duration_type, bool can_play_in_cup, bool can_play_against, bool can_be_recalled);

            app.busyIndicator.running = false
            root.offer_id = offer_id;
            root.player = player;
            root.owner_club_id = oci;
            root.owner_club_name = ocn;
            root.bidding_club_id = bci;
            root.bidding_club_name = bcn;
            root.fee = fee;
            root.future_fee = future_fee
            root.wages = wages;
            root.duration = duration
            root.duration_type = duration_type
            root.can_be_recalled = can_be_recalled
            root.can_play_against = can_play_against
            root.can_play_in_cup = can_play_in_cup

            titleBar = qsTr("View loan offer for %1").arg(player.name)
            app_title_bar.title = titleBar
            loan_fees_combo_box.displayText = currencyFormatter.currencyString(root.fee);
            loan_future_fees_combo_box.displayText = currencyFormatter.currencyString(root.future_fee);
            loan_wages_combo_box.displayText = root.wages + "%"
            loan_duration_combo_box.displayText = root.duration
        }

    }
}
