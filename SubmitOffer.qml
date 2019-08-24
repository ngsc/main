import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import com.Game.Player 1.0
import com.Game.APIConnection 1.0

Rectangle {
    id: root
    color: "transparent"
    property string titleBar: qsTr("Submit Offer to %1").arg(player.name)

    property Player player : Player{ id: tmpPlayer }
    property int index: 0
    property bool activeIndex: true

    ListModel {
        id: itemsList
        ListElement {
            fee: "$0"
        }
    }

    function setPlayer(p) {
        player = p
        app_title_bar.title = titleBar
        app_title_bar.titleFontSize = 25
        app_title_bar.textColor = player.background1Value !== "" ? player.foreground1Value : app_title_bar.defaultTextColor;
        app_title_bar.selectedclubid = player.clubId        //app_title_bar.selectedplayer = "file:///" + applicationPath + "images/players/" + player.id + ".png"
        app_title_bar.setportrailVisible = false
        fillFeeList()
        //        console.log("Manager club: " + managerUser.club + ", player club: " + player.clubId)
    }

    function fillFeeList(){
        index = 0 ;
        if(playerProfile.player.value > 0){
            for(var i = playerProfile.player.value/10 ; i < playerProfile.player.value*10 ; i+=playerProfile.player.value/100){
                if(activeIndex){
                    index++;
                }
                if(i === playerProfile.player.value ){
                    activeIndex = false
                }
                itemsList.append({"fee" :currencyFormatter.currencyString(i)})
            }
        }else{
            for(var i = 1000000 ; i < 10000000 ; i+=100000){
                itemsList.append({"fee" :currencyFormatter.currencyString(i)})
            }
        }

        //        for(var i = 100000 ; i < 1000000 ; i+=10000){
        //            if(activeIndex){
        //                index++;
        //            }
        //            if((i < playerProfile.player.value && playerProfile.player.value < i+10000)||
        //                    (0 < playerProfile.player.value && i === 100000)){
        //                itemsList.append({"fee" : currencyFormatter.currencyString(playerProfile.player.value)})
        //                activeIndex = false;
        //            }
        //            itemsList.append({"fee" :currencyFormatter.currencyString(i)})
        //        }
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
            height: 100
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
                    text: qsTr("%1 is currently  valued at %2").arg(player.name ).arg(currencyFormatter.currencyString(player.value))
                    font.family: "Comic Sans MS"
                    color: "#ffffff"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    font.pointSize: 11
                    anchors.leftMargin: 20
                    anchors.topMargin: 10
                }
                Text {
                    id: txt2
                    text: qsTr("Club remaining budget is %1").arg(currencyFormatter.currencyString(managerUser.club.trnBudgetR))
                    font.family: "Comic Sans MS"
                    color: "#ffffff"
                    anchors.left: txt1.left
                    anchors.top: txt1.bottom
                    font.pointSize: 11
                    anchors.topMargin: 10
                }
            }
        }

        CustomGroupBox {
            id: basic_offer_group_box
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: transfer_value_gorup_box.bottom
            anchors.topMargin: 1
            height: 160//offer_combo_box.currentIndex === 0 ? 220 : 285
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
                    id: offer_combo_box
                    anchors.verticalCenter: offer_label.verticalCenter
                    items_list: [qsTr("Transfer"), qsTr("Loan")]
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width/2 - 40
                    height: offer_label.height+5
                    width: parent.width/4
                    currentIndex: 0
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
                        font.family: "Comic Sans MS"
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
                        items_list: itemsList// [currencyFormatter.currencyString("9000000"),
                        //                            currencyFormatter.currencyString("9250000"),
                        //                            currencyFormatter.currencyString("9500000"),
                        //                            currencyFormatter.currencyString("9750000"),
                        //                            currencyFormatter.currencyString("10000000")]
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width/2 - 40
                        height: transfer_fees_label.height+5
                        width: parent.width/4
                        currentIndex: index
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
                        font.family: "Comic Sans MS"
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
                        font.family: "Comic Sans MS"
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
                        font.family: "Comic Sans MS"
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
                        font.family: "Comic Sans MS"
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
                        items_list: [qsTr("0%"), qsTr("20%"), qsTr("50%"), qsTr("80%"), qsTr("100%")]
                        anchors.left: loan_future_fees_combo_box.left
                        height: loan_wages_label.height+5
                        width: parent.width/4
                        currentIndex: 0
                    }

                    Text
                    {
                        id: loan_future_fees_label
                        text: qsTr("Future Fees")
                        font.family: "Comic Sans MS"
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
            text: qsTr("Submit")
            onClicked: { confirm.visible = true }
        }
        MyButtonNormal
        {
            id: cancel_button
            anchors.top: confirm_button.top
            anchors.right: confirm_button.left
            anchors.rightMargin: 5
            text: qsTr("Cancel")
            onClicked: { app_title_bar.popPage() }
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
            visible: offer_combo_box.currentIndex === 1
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
                    checked: false
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
                    font.family: "Comic Sans MS"
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
        confirm_button_text: qsTr("Make Offer")
        cancel_button_text: qsTr("Cancel")
        title: qsTr("Make Offer")
        property string fees_value : offer_combo_box.currentIndex ===  0 ? transfer_fees_combo_box.displayText : loan_fees_combo_box.displayText
        question: qsTr("Make offer of %1 to %2?").arg(fees_value).arg(player.name)

        onConfirm_clicked: {
            visible = false
            app.busyIndicator.running = true
            if(offer_combo_box.currentIndex === 0) {
                var transfer_params = "action=create_offer&about_player_id=%1&bidding_club_id=%2&owner_club_id=%3&type=Transfer&fee=%4&minimum_fee=%5&token=%6"
                APIConnection.createOffer(transfer_params.arg(player.id).arg(managerUser.clubId).arg(player.clubId)
                                          .arg(currencyFormatter.currencyValue(transfer_fees_combo_box.displayText)).arg(player.minimumFee)
                                          .arg(managerUser.token));
            }
            else if(offer_combo_box.currentIndex === 1) {
                var loan_params = "action=create_offer&about_player_id=%1&bidding_club_id=%2&owner_club_id=%3&type=Loan&fee=%4&token=%5&minimum_fee=%6&duration=%7&wages=%8&futureFee=%9&canPlayInCup=%10&canPlayAgainst=%11&canBeRecalled=%12";
                APIConnection.createOffer(loan_params.arg(player.id).arg(managerUser.clubId).arg(player.clubId).
                                          arg(currencyFormatter.currencyValue(loan_fees_combo_box.displayText)).arg(managerUser.token).arg(player.minimumFee).
                                          arg(loan_duration_combo_box.displayText).arg(loan_wages_combo_box.displayText.replace("%", "")).
                                          arg(currencyFormatter.currencyValue(loan_future_fees_combo_box.displayText)).
                                          arg(recall_check_box.checked ? "1" : "0").arg("0").arg("0"));
            }
        }

        onCancel_clicked:  {
            //console.log("close confirm....")
            visible = false
        }
    }

    Connections {
        target: APIConnection

        onSubmitOfferFinished: {
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

        onGetTransferOfferFinished : {
            //(offer_id, owner_club_id, bidding_club_id, player_id, fees, minimum_fee);
            app.busyIndicator.running = false
            if(owner_club_id !== player.clubId) {
                alert(qsTr("This player does not belong to the club"), "red");
                return;
            }
            transfer_fees_combo_box.displayText = currencyFormatter.currencyString(fees);
        }

        onGetLoanOfferFinished : {
            app.busyIndicator.running = false
            if(owner_club_id !== player.clubId) {
                alert(qsTr("This player does not belong to the club"), "red");
                return;
            }
            loan_fees_combo_box.displayText = currencyFormatter.currencyString(fees);
        }
    }
}
