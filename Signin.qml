import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0
import com.Game.APIConnection 1.0

Item {
    id: signin

    property string titleBar: qsTr("Signing In")
    property string username: signin_field_username.text
    property string password: signin_field_password.text
    property string error_text: ""


    function validateValues() {
        console.log("username : " + username);
        console.log("password : " + password);

        if(username.trim().length == 0 ) //|| !username.match(""))
        {
            signin_error_rect.visible = true;
            error_text = qsTr("Please insert a valid username");
            return false;
        }

        if(password.trim().length == 0) {
            signin_error_rect.visible = true;
            error_text = qsTr("Please insert a password");
            return false;
        }

        signin_error_rect.visible = false;
        error_text = "";

        enable_buttons(false);
        app.busyIndicator.running = true;
        APIConnection.signIn(username.trim(), password.trim())
    }

    function clear_error() {
        signin_error_rect.visible = false;
        error_text = "";
    }

    function show_error(msg, color) {
        app.busyIndicator.running = false;
        enable_buttons(true);
        console.log("show_error(" + msg  + ")");
        signin_error_rect.visible = true;
        error_text = msg;
        signin_error_inner_rect.border.color = color;
    }

    function enable_buttons(enable) {
        signin_button.enabled = enable;
        signup_button.enabled = enable;
        exit_button.enabled = enable;
    }

    Rectangle {
        id:  signin_rect
        anchors.fill: parent
        color: "transparent"

        Rectangle
        {
            id: signin_username_rect
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            width: 600
            height: 40
            color: "transparent"
            radius: width/2
            visible: signinPage
            MouseArea{cursorShape: Qt.PointingHandCursor}
            Rectangle
            {
                border.color: "#fdc807"
                border.width: 3
                anchors.fill: parent
                color: "#34537a"
                opacity: 0.7
                radius: parent.radius
            }
            TextField
            {
                id: signin_field_username
                placeholderText: qsTr("Username")
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: parent.width-35
                font.family: "Comic Sans MS"
                font.pointSize: 12
                style: TextFieldStyle{
                    textColor: "#ffffff"
                    placeholderTextColor: "#ffffff"
                    background: Rectangle{
                        color: "transparent"
                    }
                }
                text: "yazwas@yahoo.com"
            }
        }

        Rectangle
        {
            id: signin_password_rect
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: signin_username_rect.bottom
            anchors.topMargin: 10
            width: 600
            height: 40
            color: "transparent"
            radius: width/2
            visible: signinPage
            MouseArea{cursorShape: Qt.PointingHandCursor}
            Rectangle
            {
                border.color: "#fdc807"
                border.width: 3
                anchors.fill: parent
                color: "#34537a"
                opacity: 0.7
                radius: parent.radius
            }
            TextField
            {
                id: signin_field_password
                placeholderText: qsTr("Password")
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: parent.width-35
                font.family: "Comic Sans MS"
                font.pointSize: 12
                echoMode: TextField.Password
                style: TextFieldStyle{
                    textColor: "#ffffff"
                    placeholderTextColor: "#ffffff"
                    passwordCharacter: "*"
                    background: Rectangle{
                        color: "transparent"
                    }
                }
                text: "12345678"
            }
        }

        Row {
            id: signin_buttons_row
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: signin_password_rect.bottom
            anchors.topMargin: 140
            spacing: 30

            ButtonMainPage
            {
                id: signin_button
                anchors.verticalCenter: parent.verticalCenter
                button_text: qsTr("Signin")
                MouseArea
                {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton
                    onPressed: {parent.state="clicked"}
                    onReleased: {parent.state="unclicked"}
                    onClicked: {
                        signin_error_rect.visible = false;
                        error_text = "";
                        enable_buttons(false);
                        APIConnection.signIn(username, password);
                        app.busyIndicator.running = true;
                    }
                }

            }

            ButtonMainPage
            {
                id: signup_button
                anchors.verticalCenter: parent.verticalCenter
                button_text: qsTr("Signup")
                MouseArea
                {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton
                    onPressed: {parent.state="clicked"}
                    onReleased: {parent.state="unclicked"}
                    onClicked: {
                        callinsidepage2(signupPage)
                    }
                }
            }

            ButtonMainPage
            {
                id: exit_button
                anchors.verticalCenter: parent.verticalCenter
                button_text: qsTr("Exit")
                MouseArea
                {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton
                    onPressed: {
                        parent.state="clicked"
                        confirmingbox.visible = true
                    }
                    onReleased: {parent.state="unclicked"}
                }
            }
        }

        //error message
        Rectangle
        {
            id: signin_error_rect
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: signin_buttons_row.bottom
            anchors.topMargin: 10
            width: 600
            height: 40
            color: "transparent"
            radius: width/2
            visible: false
            MouseArea{cursorShape: Qt.PointingHandCursor}
            Rectangle
            {
                id: signin_error_inner_rect
                border.color: "red"
                border.width: 3
                anchors.fill: parent
                color: "#34537a"
                opacity: 0.7
                radius: parent.radius
            }
            TextField
            {
                id: signin_error
                readOnly: true
                text: qsTr(error_text)
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: parent.width-35
                font.family: "Comic Sans MS"
                font.pointSize: 12
                style: TextFieldStyle{
                    textColor: "#ffffff"
                    placeholderTextColor: "#ffffff"
                    background: Rectangle{
                        color: "transparent"
                    }
                }
            }
        }
    }
}
