import QtQuick 2.4
import QtGraphicalEffects 1.0
import Constants 1.0

Item {
    id: app_title_bar
    width: Constants.titleBarWidth
    height: Constants.titleBarHeight

//    property alias firstTeamColor: firstTeamScoreFigure.teamColor
    //property alias firstTeamName: firstTeamScoreFigure.teamName
    property alias firstTeamScore: firstTeamScoreFigure.score
    //property alias firstScoreVisible: firstTeamScoreFigure.visible

//    property alias secondTeamColor: secondTeamScoreFigure.color
    //property alias secondTeamName: secondTeamScoreFigure.teamName
    property alias secondTeamScore: secondTeamScoreFigure.score
    //property alias secondScoreVisible: secondTeamScoreFigure.visible

    property var forwardlist:[]
    property var forwardTitleProperties: []
    property var backwardTitleProperties: []
    property var forwardInside

    property bool setforwordvisibility :false
    property bool setportrailVisible: false

    property string title: qsTr("Signin")
    property string selectedportrail  : ""//"qrc:/images/portrait/"+managerUser.userPortrait+".jpg"
    property string selectedplayer: ""
    property string selectedclubportrait  : ""
    property string selectednation  : ""
    property string selectedclubname: ""
    property int selectedclubid: 0
    property bool showselectedclubname: false
    readonly property string defaultTextColor: Constants.menuTextColor
    readonly property string defaultBackgroundColor: Constants.menuBackgroundColor
    property string textColor: defaultTextColor
    property string backgroundColor: defaultBackgroundColor

    property int titleFontSize: Constants.defaultTitleFontSize
    property int clubFontSize: Constants.defaultClubFontSize

    function printObject(o) {
      var out = '----------------------------------\n';
      for (var p in o) {
        out += '\t' + p + ': ' + o[p] + '\n';
      }
      out += '----------------------------------\n';
      console.log(out);
    }

    function reset() {
        setportrailVisible = false
        showselectedclubname = false
        title = ""
//        selectedportrail  = ""
        selectedplayer= ""
        selectedclubportrait  = ""
        selectednation  = ""
        selectedclubname = ""
        selectedclubid = 0

        textColor = defaultTextColor
        backgroundColor = defaultBackgroundColor

        titleFontSize = Constants.defaultTitleFontSize
        clubFontSize = Constants.defaultClubFontSize
    }

    function pushProperties(list) {

        var obj = {};
        obj.title = app_title_bar.title;
        obj.selectedportrail = app_title_bar.selectedportrail;
        obj.selectedplayer = app_title_bar.selectedplayer;
        obj.selectedclubportrait = app_title_bar.selectedclubportrait;
        obj.selectednation = app_title_bar.selectednation;
        obj.selectedclubname = app_title_bar.selectedclubname;
        obj.selectedclubid = app_title_bar.selectedclubid;
        obj.textColor = app_title_bar.textColor;
        obj.backgroundColor = app_title_bar.backgroundColor;
        obj.setportrailVisible = app_title_bar.setportrailVisible;
        obj.showselectedclubname = app_title_bar.showselectedclubname;
        obj.titleFontSize = app_title_bar.titleFontSize
        obj.clubFontSize = app_title_bar.clubFontSize

        console.log("add properties to array:");
        printObject(obj)
        list.push(obj);
    }

    function popProperties(list) {
        if(list.length < 1)
            return;

        var obj = list.pop();
        //console.log("pop properties from array (remaining " + list.length + ")");

        printObject(obj);
        app_title_bar.title = obj.title;
        app_title_bar.selectedportrail = obj.selectedportrail;
        app_title_bar.selectedplayer = obj.selectedplayer;
        app_title_bar.selectedclubportrait = obj.selectedclubportrait;
        app_title_bar.selectednation = obj.selectednation;
        app_title_bar.selectedclubname = obj.selectedclubname;
        app_title_bar.selectedclubid = obj.selectedclubid;
        app_title_bar.textColor = obj.textColor === null || obj.textColor === "" ? defaultTextColor : obj.textColor;
        app_title_bar.backgroundColor = obj.backgroundColor === null || obj.backgroundColor === "" ? defaultBackgroundColor : obj.backgroundColor;
        app_title_bar.setportrailVisible = obj.setportrailVisible;
        app_title_bar.showselectedclubname = obj.showselectedclubname;
        app_title_bar.titleFontSize = obj.titleFontSize
        app_title_bar.clubFontSize = obj.clubFontSize
    }

    function pushPage(){
        forwardInside = forwardlist.pop()
        if(forwardlist.length>0){
            setforwordvisibility = true
        }else{
            setforwordvisibility = false
        }
        stackView.push(forwardInside)
        popProperties(forwardTitleProperties)
        pushProperties(backwardTitleProperties)
        //reset()
        //app_title_bar.title = forwardInside.titleBar
    }

    function popPage() {
        if(stackView.depth<=forwardlist.length){
            forwardlist.pop()
        }
        if(stackView.depth>1) {
            forwardlist.push(stackView.__currentItem)
            pushProperties(forwardTitleProperties)

            stackView.pop()

            reset();
            popProperties(backwardTitleProperties)
            //title =  stackView.__currentItem.titleBar
        }

        if(forwardlist.length>0){
            setforwordvisibility = true
        }
        else{
            setforwordvisibility = false
        }
    }

    Rectangle
    {
        id: rectangle
        anchors.fill: parent
        radius: Constants.menuRectRadius
        opacity: 1.0

        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.lighter(backgroundColor)}
            GradientStop { position: 1.0; color: backgroundColor}
        }

        MouseArea{cursorShape: Qt.PointingHandCursor}
        TeamScoreRectangle
        {
            id: firstTeamScoreFigure
            z: 1
            anchors.left: parent.left
            width: parent.width / 2
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            teamColor: monitorControl.leftClub ? monitorControl.leftClub.background1Value : null
            teamName: monitorControl.leftClub ? monitorControl.leftClub.name : null
//            score: monitorControl.leftClub ? monitor.leftScore : null
            visible: monitorControl.leftClub ? true : false
        }
        TeamScoreRectangle
        {
            z: 1
            id: secondTeamScoreFigure
            anchors.right: parent.right
            width: parent.width / 2
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            teamColor: monitorControl.rightClub ? monitorControl.rightClub.background1Value: null
            teamName: monitorControl.rightClub ? monitorControl.rightClub.name : null
//            score: monitor.rightClub ? monitor.rightScore : null
            visible: monitorControl.rightClub ? true : false
        }

        Text
        {
            id: title_text
            anchors.centerIn: parent
            property int vco: 0
            color: textColor
            font.family: Constants.primaryFont ? Constants.primaryFont.name: null
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.verticalCenterOffset: vco
            text: qsTr(title)
            font.pointSize: titleFontSize
            font.letterSpacing: 1
            layer.enabled: true
            layer.effect: DropShadow {
                verticalOffset: 2
                color: "#80000000"
                radius: 1
                samples: 3
            }
        }
        Text {
            id: club_text
            text: qsTr(app_title_bar.selectedclubname)
            anchors.horizontalCenter: title_text.horizontalCenter
            font.family: "VAGRounded BT"//"Kristen ITC"
            font.pointSize: clubFontSize
            anchors.bottom: parent.bottom
            color: "yellow"
            anchors.bottomMargin: 2
            visible: showselectedclubname || setportrailVisible
            onVisibleChanged: {
                if(visible)
                    title_text.vco = -15
                else
                    title_text.vco = 0
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    //go to league page.
                    if(stackView.__currentItem === leaguePage) {
                        leaguePage.flipLeague()
                    }
                    else {
                        leaguePage.loadLeagueClubs(app_title_bar.selectedclubid)
                        leaguePage.loadLeagueClubs(app_title_bar.selectedclubid)
                        callinsidepage2(leaguePage)
                     }
                }
            }
        }
        Image
        {
            id : forward
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 30
            height: parent.height/2
            width: height
            visible: false/*setforwordvisibility && stackView.__currentItem !== signinPage && stackView.__currentItem !== signupPage*/
            fillMode: Image.Stretch
            source: "qrc:/icons/arrow-sharp-forward.png"
            MouseArea
            {
                anchors.fill: parent
                onClicked: {
                    pushPage();
                }
            }
        }

        Rectangle{
            id : club
            anchors.right: forward.left
            anchors.rightMargin: 20
            visible: setportrailVisible
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin : 20
            height: 2*parent.height/3
            width: height
            radius: height/2

            Image{
                anchors.fill: parent
                height: 2*parent.height/3
                width: height
                source: selectedclubportrait
                fillMode: Image.PreserveAspectCrop
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: mask3
                }
            }
            Rectangle {
                id: mask3
                width: height
                height: 2*parent.height/3
                radius: height
                visible: false
            }
        }

        Rectangle{
            id : nation
            anchors.right: club.left
            anchors.rightMargin: 20
            visible: setportrailVisible
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin : 20
            height: 2*parent.height/3
            width: height
            radius: height/2

            Image{
                anchors.fill: parent
                height: 2*parent.height/3
                width: height
                source: selectednation
                fillMode: Image.PreserveAspectCrop
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: mask1
                }
            }
            Rectangle {
                id: mask1
                width: height
                height: 2*parent.height/3
                radius: height
                visible: false
            }
        }

        Rectangle{
            id : portrail
            anchors.left: leftbutton.right
            anchors.leftMargin : 20
            height: 2*parent.height/3
            width: height
            radius: height/2
            visible: setportrailVisible
            anchors.verticalCenter: parent.verticalCenter
            Image{
                anchors.fill: parent
                height: 2*parent.height/3
                width: height
                source: selectedplayer
                fillMode: Image.PreserveAspectCrop
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: mask2
                }
            }
            Rectangle {
                id: mask2
                width: height
                height: 2*parent.height/3
                radius: height
                visible: false
            }
        }

        Image
        {
            id : leftbutton
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 30
            height: parent.height/2
            width: height
            fillMode: Image.Stretch
            visible: false/*stackView.depth>1 && stackView.__currentItem !== signinPage && stackView.__currentItem !== signupPage ? true : false*/
            source: "qrc:/icons/arrow-sharp-back.png"
            MouseArea
            {
                anchors.fill: parent
                onClicked: {
                    popPage()
                }
            }
        }
    }
}
