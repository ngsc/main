import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.0

import com.Game.APIConnection 1.0
import com.Game.Club 1.0
import Constants 1.0

Rectangle {
    id: root
    color: "transparent"

    property string titleBar: qsTr("Select Club")


    property string selectedclub: ""
    property int selectedid: 0

    GridView {
        id: gridView
        anchors.fill: parent
        cellWidth: parent.width/5   // - 20
        cellHeight: height/5
        layoutDirection: GridView.FlowLeftToRight
        verticalLayoutDirection: GridView.TopToBottom

        clip: true

        model:ClubModel {
            id: clubModel
        }

        delegate: Rectangle
        {
            id: rect
            height: gridView.cellHeight - 10
            width: gridView.cellWidth

            color: "transparent"
            property bool hoveredornot : false
            property alias club_id: idtxt.text

            Rectangle {
                id: selectedhint
                x:100
                y:50
                radius: 10
                implicitWidth: selectedhinttext.width+2
                height: selectedhinttext.height+2
                visible: false
                ///anchors.leftMargin: 30
                color: "#DAF7A6"
                Text {
                    id:selectedhinttext
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    //padding: 5
                    font.pointSize: 9
                    text: qsTr("This club is already woned by %1").arg(ownerName);
                    color:"gray"
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor//ownerId === 0 ? Qt.PointingHandCursor : Qt.ArrowCursor
                acceptedButtons: Qt.LeftButton
                onPressed: {
                    //                    if(ownerId !== 0)
                    //                    {
                    //                        return;
                    //                    }

                    root.selectedclub = name_field.text
                    root.selectedid = rect.club_id
                    confirmingbox.visible = true
                }
                onHoveredChanged: {
                    if( rect.hoveredornot === false){
                        rect.hoveredornot = true
                        if(ownerId === 0) {
                            rect.scale = 1.2
                            rect.z = root.z+1;
                        }
                        else {
                            selectedhint.z = root.z+1
                            selectedhint.visible = true
                        }

                    }else{
                        rect.hoveredornot = false
                        if(ownerId === 0) {
                            rect.scale = 1
                            rect.z = root.z-1;
                        }
                        else {
                            selectedhint.z = root.z-1
                            selectedhint.visible = false;
                        }

                    }
                }
            }

            Text {
                id: idtxt
                text: id
                visible: false
            }

            Rectangle {
                id: rec2
                width: parent.height - 10
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"
                Image {
                    id: img
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                    source: "images/clubs/normal/" + club_id + ".png"
                    smooth: true
                }
            }

            Rectangle {
                width: parent.width
                anchors.top: rec2.bottom
                anchors.bottom: parent.bottom
                color: "transparent"
                Text {
                    id: name_field
                    //anchors.horizontalCenter: parent.horizontalCenter
                    anchors.centerIn: parent
                    color: "white"
                    text: qsTr(name)
                    font.pointSize: 10
                    font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
    }

    Connections {
        target: APIConnection

        onGetClubsFinished: {
            app.busyIndicator.running = false
            clubModel.setClubs(clubs);

        }
    }

    function loadLeagueClubs(id) {
        app.busyIndicator.running = true
        APIConnection.getLeagueClubs(managerUser.token, id);
    }


    Rectangle{
        id: confirmingbox
        visible: false
        width: 430
        height: 150
        radius: 15
        x:parent.width/2-width/2
        y:parent.height/2-height/2
        z:parent.z+1
        opacity: 0.95
        border.color: "white"
        color:"#5a4f7e"

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#9087ab" }
            GradientStop { position: 0.50; color: "#493e6a" }
            GradientStop { position: 1.0; color: "#493e6a" }
        }

        ColumnLayout
        {
            anchors.fill: parent
            Text {
                id: confirming
                text: qsTr("Confirming the Team")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.margins: 50
                font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                font.pointSize: 15
                font.bold: true
                color: "white"
            }
            Text {
                id: question
                text: qsTr("Are you sure to take over %1 team?!").arg(root.selectedclub)
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.margins: 50
                font.family: Constants.primaryFont ? Constants.primaryFont.name: null//"Kristen ITC"
                font.pointSize: 15
                font.bold: false
                color: "white"

            }
            RowLayout{
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle{
                    id :cancel
                    width: 170
                    height: 50
                    border.color: "black"
                    radius: 10
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#9087ab" }
                        GradientStop { position: 0.50; color: "#493e6a" }
                        GradientStop { position: 1.0; color: "#493e6a" }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        acceptedButtons: Qt.LeftButton
                        onPressed: {
                            root.selectedclub = ""
                            root.selectedid = 0
                            confirmingbox.visible = false
                        }
                    }

                    Text{
                        text : "cancel"
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        anchors.fill: parent
                        font.family: Constants.primaryFont ? Constants.primaryFont.name: null
                        font.pointSize: 15
                        font.bold: true
                        color: "white"
                    }
                }
                Rectangle{
                    id :continu
                    width: 170
                    height: 50
                    border.color: "black"
                    radius: 10
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#9087ab" }
                        GradientStop { position: 0.50; color: "#493e6a" }
                        GradientStop { position: 1.0; color: "#493e6a" }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        acceptedButtons: Qt.LeftButton
                        onPressed: {
                            confirmingbox.visible = false
                            managerProfileGenerator.selectedClubId = selectedid;
                            managerProfileGenerator.selectedClubName = selectedclub;

                            if(managerUser.userPortrait === ""){
                                managerUser.clubId = selectedid
                                managerUser.clubName = selectedclub

                                //                                APIConnection.updateUser(managerUser);

                                app.callinsidepage2(managerProfileGenerator)

                                app.clubDetailsforManager = false
//                                if(app.takeControl && (managerUser.userPortrait != "")){
//                                    APIConnection.getPublicNews(managerUser.token)
//                                    app.takeControl = false
//                                }

                            }else{


                                managerUser.clubId = selectedid;
                                managerUser.clubName = selectedclub

//                                APIConnection.getPublicNews(managerUser.token)
                                app.takeControl = false

                                app.clubDetailsforManager = false
                                APIConnection.updateUser(managerUser);
                                APIConnection.getClubDetails(managerUser.token, managerUser.clubId);
                                clubPage.loadClubPlayers(managerUser.clubId)
                                APIConnection.getUsers(managerUser.token)
                                APIConnection.getNews(managerUser.token, managerUser.id)
//                                getInvitationsTimer.running = true
                                getNewsTimer.running = true
                                app.callinsidepage2(clubPage)
                                clubPage.titleBar = managerUser.clubName
                            }

                        }
                    }

                    Text{
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        anchors.fill: parent
                        text : qsTr("Continue")
                        font.family: Constants.primaryFont ? Constants.primaryFont.name: null//"Kristen ITC"
                        font.pointSize: 15
                        font.bold: true
                        color: "white"
                    }
                }
            }
        }
    }
}
