/*
** Added by Ahmed Soliman
** For further information use the contact form at AhmedSoliman_1234@hotmail.com.
*/
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import com.Game.APIConnection 1.0
import com.Game.User 1.0

Rectangle
{
    id: managerProfile
    color: "transparent"
    property string titleBar: qsTr("Manager Profile")

    property UserCommentsModel usercommentmodel: UserCommentsModel{
        id:usercommentmodel
    }

    function setUser() {
        console.log(managerUser.clubId)

        app_title_bar.selectedplayer = "qrc:/images/portrait/" + managerUser.userPortrait + ".jpg"
        app_title_bar.selectedclubportrait = "qrc:/images/clubs/normal/" + managerUser.clubId + ".png"
        app_title_bar.title = managerUser.firstName + " " + managerUser.lastName//titleBar
        app_title_bar.titleFontSize = 20
        app_title_bar.setportrailVisible = true
        //        app_title_bar.backgroundColor = managerUser.club.background1Value !== "" ? managerUser.club.background1Value : app_title_bar.defaultBackgroundColor;
        //        app_title_bar.textColor = managerUser.club.background1Value !== "" ? managerUser.club.foreground1Value : app_title_bar.defaultTextColor;
        app_title_bar.selectedclubid = managerUser.clubId
        app_title_bar.selectedclubname = managerUser.clubName

        //set the  values
        overviewlistModel.clear()
        overviewlistModel.append({"pname": "Name", "pvalue" : app.user.firstName + " " + app.user.lastName})//player.age.toString()})
        overviewlistModel.append({"pname": "Nick Name", "pvalue" : app.user.nickName})//Qt.formatDateTime(player.dob, "yyyy-MM-dd")})
        overviewlistModel.append({"pname": "City", "pvalue" : app.user.city})//Qt.formatDateTime(player.dob, "yyyy-MM-dd")})
        overviewlistModel.append({"pname": "Club Name", "pvalue" : app.user.clubName})//Qt.formatDateTime(player.dob, "yyyy-MM-dd")})
        overviewlistModel.append({"pname": "favFormation", "pvalue" : app.user.favFormation})
        //        overviewModel.append({"pname": "Position", "pvalue" : player.position})
        //        overviewModel.append({"pname": "Club", "pvalue" : player.clubName})
        //        overviewModel.append({"pname": "Based", "pvalue" : player.based})
        //        overviewModel.append({"pname": "Division", "pvalue" : player.division})
        //        overviewModel.append({"pname": "Squad", "pvalue" : player.squad})
        //        //overviewModel.append({"pname": "EU Member", "pvalue" : player.})

        //        contractModel.clear()
        //        contractModel.append({"pname": "Wage", "pvalue" : currencyFormatter.currencyString(player.wage)})
        //        contractModel.append({"pname": "Value", "pvalue" : currencyFormatter.currencyString(player.value)})
        //        contractModel.append({"pname": "Joind Club", "pvalue" : player.joinedClub})
        //        contractModel.append({"pname": "Contract End", "pvalue" : player.contractEnd.toString()})
        //        contractModel.append({"pname": "Leaving on Bosman", "pvalue" : player.leavingOnBosman.toString()})
        //        contractModel.append({"pname": "Minimum Fee", "pvalue" : player.minimumFee.toString()})
        //        contractModel.append({"pname": "Relegation Fee", "pvalue" : player.relegationFee.toString()})
        //        contractModel.append({"pname": "Non Promotion Fee", "pvalue" : player.nonPromotionFee.toString()})
        //        contractModel.append({"pname": "Squad Status", "pvalue" : player.squadStatus.toString()})
        //        contractModel.append({"pname": "Transfer Status", "pvalue" : player.transferStatus.toString()})
        //        //contractModel.append({"pname": "", "pvalue" : player})

        //        emotionModel.clear()
        //        emotionModel.append({"pname": "Happiness Level", "pvalue" : player.happinessLevel.toString()})

        //        injuryModel.clear()
        //        //injuryModel.append({"pname": "Happiness Level", "pvalue" : player.inj})

        //        app_title_bar.backgroundColor = managerUser.club.background1Value
        //        app_title_bar.textColor = managerUser.club.foreground1Value
        //        app_title_bar.showselectedclubname = true

        //        playerActions.setPlayer(player);
    }

    // clean completion text
    function cleanCompletion(txt){
        // group text
        var spl = txt.split("\n\n")
        var completion = spl.join("");  // Join lines

        // remove incomplete sentences
        const i = completion.lastIndexOf(".");
        if (i === -1) return completion;

        return completion.substring(0, i+1);
    }

    // accepts prompt and prints completion on application when executed at button click
    function getCompletion(prompt) {
        // change this to false if prefix is not required
        var includePrefix = true;
        // change prefix if required
        var prefix = "You are an AI Model trained on the data of Xu Jiayin's Life. You have to respond in the third person always. You have to respond specifically to the question asked in a single paragraph.\n"

        // Enter credentials
//        var apiKey = "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"; // enter api key
//        var modelId = "davinci:ft-personal:trail-prototype-2023-04-18-12-48-20"; // enter model id
//        var orgKey = "org-cArMaSVnooAmLlKvGoB2denr"; // enter organisation key

        var apiKey = "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"; // enter api key
        var modelId = "davinci:ft-lilithfactor:test-d777-300-1-2023-04-24-11-51-35"; // enter model id
        var orgKey = "org-cArMaSVnooAmLlKvGoB2denr"; // enter organisation key

        // Enter paremeters for model
        var temperature = 0.8; // between 0-1
        var frequency_penalty = 0.8; // between 0-2
        var presence_penalty = 0.8; // between 0-2
        var max_tokens = 80;
        var stop_sequence = "###" || "";

        // do not edit
        var apiUrl = "https://api.openai.com/v1/completions";

        if (includePrefix)
            prompt = prefix+prompt

        // create new Http request object
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                // if openai returns 200 OK status
                if (xhr.status === 200) {
                    var response = JSON.parse(xhr.responseText);
                    if (response.choices && response.choices.length > 0) {
                        var completion = response.choices[0].text;
                        completion = cleanCompletion(completion);
                        console.log("Prompt: ", prompt, "\nCompletion: ", completion)
                        pushMessage(completion)
                    } else {
                        console.error("No completion choices were returned.");
                    }
                } else {
                    console.error("Request failed with status:", xhr.status);
                }
            }
        }
        // making a post request
        xhr.open("POST", apiUrl, true);
        xhr.setRequestHeader("Content-Type", "application/json");
        // add apikey header
        xhr.setRequestHeader("Authorization", "Bearer " + apiKey);
        // add organisation key header
        xhr.setRequestHeader("OpenAI-Organization", orgKey);

        // declaring model parameters
        var data = {
            "model": modelId,
            "prompt": prompt + " ->",
            "max_tokens": max_tokens,
            "n": 1,
            "temperature": temperature,
            "presence_penalty": presence_penalty,
            "frequency_penalty": frequency_penalty,
            "stop": stop_sequence
        };
        xhr.send(JSON.stringify(data));
    }

    // adds message to chatbox
    function pushMessage(message) {
        if (message.trim() !== "") {
            chatModel.append({message: message});
//            talk_tab.flickable.contentY = Math.max(0, talk_tab.flickable.contentHeight - talk_tab.flickable.height);
        }
    }

    ListModel {
        id: overviewlistModel
    }
    ListModel {
        id: relationcontactlistModel
    }
    ListModel {
        id: achivementlistModel
    }
    ListModel {
        id: bSlistModel
    }
    ListModel{
        id : recordlistModel
    }

    ListModel {
        id: chatModel
    }

    Rectangle{
        id: detailes
        anchors.left: parent.left
        anchors.top : parent.top
        anchors.bottomMargin: 10
        width: 2*parent.width/3-10
        height: parent.height/2-10
        border.color: "gray"
        color: "transparent"

        Rectangle{
            id:portraitrect
            width: parent.width/3-20
            anchors.left: parent.left
            height:parent.height
            color: "gray"
            //            Text {
            //                id :portraittext
            //                anchors.horizontalCenter: parent.horizontalCenter
            //                anchors.verticalCenter: parent.verticalCenter
            //                font.pointSize: 9
            //                text: qsTr("Large Portrait")
            //                color:"black"
            //            }
            Image{
                anchors.fill: parent
                height: 2*parent.height/3
                width: height
                source: app_title_bar.selectedplayer
                fillMode: Image.PreserveAspectCrop
                layer.enabled: true
                //                layer.effect: OpacityMask {
                //                    maskSource: mask1
                //                }
            }
        }
        Rectangle{
            id:knowlegerect
            width: parent.width/3-20
            anchors.horizontalCenter: parent.horizontalCenter
            height:parent.height
            color: "gray"
            Rectangle{
                id :knowlegerect1
                anchors.top: parent.top
                width: parent.width
                height: parent.height/4
                border.color: "black"
                color: "gray"
                Rectangle{
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"
                    color: "gray"
                }
                Rectangle{
                    anchors.right: parent.right
                    width: parent.width-20
                    height: parent.height
                    border.color: "black"
                    color: "gray"
                    Text {
                        id :knowlegetext
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 9
                        text: qsTr("Knowlege")
                        color:"black"
                    }
                }

            }
            Rectangle{
                id :tacticrect
                anchors.top: knowlegerect1.bottom
                width: parent.width
                height: parent.height/4
                border.color: "black"
                Rectangle{
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"

                }
                Rectangle{
                    anchors.right: parent.right
                    width: parent.width-20
                    height: parent.height
                    border.color: "black"
                    Text {
                        id :tactictext
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 9
                        text: qsTr("Tactic")
                        color:"black"
                    }
                }

            }
            Rectangle{
                id :discplinerect
                anchors.top: tacticrect.bottom
                width: parent.width
                height: parent.height/4
                border.color: "black"
                Rectangle{
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"

                }
                Rectangle{
                    anchors.right: parent.right
                    width: parent.width-20
                    height: parent.height
                    border.color: "black"
                    Text {
                        id :discplinetext
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 9
                        text: qsTr("Discpline")
                        color:"black"
                    }
                }

            }
            Rectangle{
                id :youthrect
                anchors.top: discplinerect.bottom
                width: parent.width
                height: parent.height/4
                border.color: "black"
                Rectangle{
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"

                }
                Rectangle{
                    anchors.right: parent.right
                    width: parent.width-20
                    height: parent.height
                    border.color: "black"
                    Text {
                        id :youthtext
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 9
                        text: qsTr("Youth Dev")
                        color:"black"
                    }
                }

            }
        }
        Rectangle{
            id:determinationrect
            width: parent.width/3-20
            anchors.right: parent.right
            height:parent.height
            color: "gray"
            Rectangle{
                id :determinationrect1
                anchors.top: parent.top
                width: parent.width
                height: parent.height/4
                border.color: "black"
                color: "gray"
                Rectangle{
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"
                    color: "gray"
                }
                Rectangle{
                    anchors.right: parent.right
                    width: parent.width-20
                    height: parent.height
                    border.color: "black"
                    color: "gray"
                    Text {
                        id :determinationtext
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 9
                        text: qsTr("Determination")
                        color:"black"
                    }
                }

            }
            Rectangle{
                id :ambitionrect
                anchors.top: determinationrect1.bottom
                width: parent.width
                height: parent.height/4
                border.color: "black"
                Rectangle{
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"

                }
                Rectangle{
                    anchors.right: parent.right
                    width: parent.width-20
                    height: parent.height
                    border.color: "black"
                    Text {
                        id :ambitiontext
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 9
                        text: qsTr("Ambition")
                        color:"black"
                    }
                }

            }
            Rectangle{
                id :adaptabilityrect
                anchors.top: ambitionrect.bottom
                width: parent.width
                height: parent.height/4
                border.color: "black"
                Rectangle{
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"

                }
                Rectangle{
                    anchors.right: parent.right
                    width: parent.width-20
                    height: parent.height
                    border.color: "black"
                    Text {
                        id :adaptabilitytext
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 9
                        text: qsTr("Adaptability")
                        color:"black"
                    }
                }

            }
            Rectangle{
                id :pointsrect
                anchors.top: adaptabilityrect.bottom
                width: parent.width
                height: parent.height/4
                border.color: "black"
                Rectangle{
                    anchors.left: parent.left
                    width: 20
                    height: parent.height
                    border.color: "black"

                }
                Rectangle{
                    anchors.right: parent.right
                    width: parent.width-20
                    height: parent.height
                    border.color: "black"
                    Text {
                        id :pointstext
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 9
                        text: qsTr("Points")
                        color:"black"
                    }
                }

            }
        }
    }
    //    Rectangle{
    //        id: map
    //        anchors.right: parent.right
    //        anchors.top : parent.top
    //        width: parent.width/3-10
    //        height: parent.height
    //        border.color: "gray"
    //        color: "black"
    //        z:parent.z+1
    //        MouseArea{
    //            anchors.fill: parent
    //            cursorShape: Qt.PointingHandCursor
    //        }
    //    }

    CommentBoard {
        id: map
        anchors.right: parent.right
        anchors.top : parent.top
        width: parent.width/3-10
        height: parent.height
        z:parent.z+1
        isUser: true
        commmentModel:usercommentmodel
        //        border.color: "gray"
        //        color: "black"
    }

    Rectangle {
        id: talk_Area
        width: 2*parent.width/3-10
        height: 30
        anchors.bottom: parent.bottom
        color: "transparent"
        border.color: "gray"
//        anchors.bottomMargin: 40
        //            width: 600
        //            height: 60
        //            color: "transparent"
        radius: width / 2
        //            visible: stackView.__currentItem !== signinPage && stackView.__currentItem !== signupPage
        MouseArea {
            cursorShape: Qt.PointingHandCursor
        }

        Rectangle {
            border.color: "#fdc807"
            border.width: 3
            anchors.fill: parent
            color: "#34537a"
            opacity: 0.7
            radius: parent.radius
        }

        TextField {
            id: talk_field_text
            anchors.left: parent.left
            anchors.top: parent.top
            activeFocusOnPress: true
            width: parent.width - 35
            font.family: Constants.primaryFont ? Constants.primaryFont.name: null
            font.pointSize: 12
            focus: true
            style: TextFieldStyle {
                textColor: "#ffffff"
                background: Rectangle {
                    color: "transparent"
                }
            }

            placeholderText: "Type your message..."
            Keys.onReturnPressed: {
                if (event.modifiers & Qt.ShiftModifier) {
                    messageInput.insert(event.key);
                } else {
                    pushMessage(text);
                    getCompletion(text)
                    text = "";
                }
                event.accepted = true;
            }
        }

        Keys.onPressed: {

        }

        Image {
            id: send_icon
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height - 15
            width: height
            fillMode: Image.Stretch
            source: "qrc:/icons/arrow-blue.png"

            property int fontIndex: (Math.random() * 95) % 5

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onClicked: {
                    pushMessage(talk_field_text.text);
                    getCompletion(talk_field_text.text)
                    talk_field_text.text = "";
                }
            }
        }
    }

    Rectangle{
        id: overveiw
        anchors.left: parent.left
//        anchors.bottom : parent.bottom
        anchors.bottom : talk_Area.top
        width: 2*parent.width/3-10
        height: parent.height/2-10 - 15
        border.color: "gray"
        color: "transparent"
        TabView {
            id: infoTabView
            anchors.fill: parent
            Tab {
                title: qsTr("OverView")
                PlayerAttTableView {
                    id: overviewTableModel
                    listmodel: overviewlistModel
                }
                //                Rectangle {
                //                    color : "#6a6a8f"
                //                    ViewRectList{
                //                        id: overViewlist
                //                        anchors.left: parent.left
                //                        backgroungcolor : "#6a6a8f"
                //                        textcolor: "white"
                //                        width: parent.width+20
                //                        height: parent.height
                //                        anchors.topMargin: 5
                //                        listmodel :overViewcontactModel
                //                        ListModel {
                //                            id :overViewcontactModel
                //                            ListElement {name: qsTr("Age")}
                //                            ListElement {name: qsTr("City of birth")}
                //                            ListElement {name: qsTr("Wages")}
                //                            ListElement {name: qsTr("Expires")}
                //                            ListElement {name: qsTr("Hoppy")}

                //                        }
                //                    }
                //                }
            }
            Tab {
                title: qsTr("Relation")
                PlayerAttTableView {
                    id: relationcontactModel
                    listmodel: relationcontactlistModel
                }
                //                Rectangle {
                //                    color : "#6a6a8f"
                //                    ViewRectList{
                //                        id: relationlist
                //                        anchors.left: parent.left
                //                        width: parent.width+20
                //                        backgroungcolor : "#6a6a8f"
                //                        textcolor: "white"
                //                        height: parent.height
                //                        anchors.topMargin: 5
                //                        listmodel :relationcontactModel
                //                        ListModel {
                //                            id :relationcontactModel
                //                            ListElement {name: qsTr("Fav club")}
                //                            ListElement {name: qsTr("Hated club")}
                //                            ListElement {name: qsTr("Fav Footballer")}
                //                            ListElement {name: qsTr("Dislike Footballer")}
                //                            ListElement {name: qsTr("Fav Manager")}

                //                        }
                //                    }

                //                }
            }
            Tab {
                title: qsTr("Achivement")
                PlayerAttTableView {
                    id: achivementcontactModel
                    listmodel: achivementlistModel
                }/*
                Rectangle {
                    color : "#6a6a8f"
                    ViewRectList{
                        id: achivementlist
                        anchors.left: parent.left
                        width: parent.width+20
                        backgroungcolor : "#6a6a8f"
                        textcolor: "white"
                        height: parent.height
                        anchors.topMargin: 5
                        listmodel :achivementcontactModel
                        ListModel {
                            id :achivementcontactModel
                            ListElement {name: qsTr("Ero Championship 2016")}

                        }
                    }

                }*/
            }
            Tab {
                title: qsTr("B/S")
                PlayerAttTableView {
                    id: bScontactModel
                    listmodel: bSlistModel
                }
                //                Rectangle { color : "#6a6a8f" }
            }
            Tab {
                title: qsTr("Record")
                PlayerAttTableView {
                    id: recordcontactModel
                    listmodel: recordlistModel
                }
            }

            Tab {
                id: talk_tab
                title: qsTr("Talk")
                Flickable {
                    id: flickable
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    width: 200; height: 300
                    contentHeight: chatColumn.height
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds
                    anchors.margins: 20
                    Column {
                        id: chatColumn
                        width: parent.width
                        spacing: 5
                        Repeater {
                            model: chatModel
                            delegate: chatDelegate
                        }
                    }
                }
            }
        }
    }

    Component {
        id: chatDelegate

        Rectangle {
            width: 2*parent.width/3-10
            height: messageText.height + 10
            color: "lightblue"

            Text {
                id: messageText
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 20
                text: model.message
                wrapMode: Text.Wrap
                font.pixelSize: 15
            }
        }
    }

    Connections {
        target: APIConnection
        onGetUserCommentFinished:{
            //playerCommentBoard.playerAnnoncementRect.setcommentRectHeight()
            map.annoncementRect.setcommentRectHeight()
            usercommentmodel.setuserComment(usercomment)
        }

//        onGetUsersFinished :{

//            managerProfile.setUser(u)
//        }
    }
}
