import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0
import com.Game.APIConnection 1.0
Item {
    id: signup

    property string titleBar: qsTr("Signing up")
    property string email: signup_field_email.text
    property string username: signup_field_username.text
    property string password: signup_field_password.text
    property string confirmPassword: signup_field_password_confirm.text
    property string error_text: ""

    function validateEmail(email) {
      var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      return re.test(email);
    }


    function validateValues() {
        console.log("email : " + email);
        console.log("username : " + username);
        console.log("password : " + password);
        console.log("confirmPassword : " + confirmPassword);

        if(!validateEmail(email.trim())) {
            console.log("email : " + email);
            signup_error_rect.visible = true;
            error_text = qsTr("Please insert a valid email");

            signup_email_inner_rect.border.color = "red";
            delayTimer(1000, function(){
                signup_email_inner_rect.border.color ="#fdc807";
            })
            return false;
        }

        if(username.trim().length == 0 ) //|| !username.match(""))
        {
            signup_error_rect.visible = true;
            error_text = qsTr("Please insert a valid username");
            return false;
        }

        if(password.trim().length == 0) {
            signup_error_rect.visible = true;
            error_text = qsTr("Please insert a password");
            return false;
        }

        if(password.trim() !== confirmPassword.trim()) {
            signup_error_rect.visible = true;
            error_text = qsTr("Passwords does not match");
            return false;
        }

        signup_error_rect.visible = false;
        error_text = "";

        enable_buttons(false);
        app.busyIndicator.running = true;
        APIConnection.signUp(email.trim(), username.trim(), password.trim())
    }

    function clear_error() {
        signup_error_rect.visible = false;
        error_text = "";
    }

    function show_error(msg, color) {
        app.busyIndicator.running = false;
        enable_buttons(true);
        console.log("show_error(" + msg  + ")");
        signup_error_rect.visible = true;
        error_text = msg;
        signup_error_inner_rect.border.color = color;
    }

    function enable_buttons(enable) {
        signup_button.enabled = enable;
        cancel_button.enabled = enable;
    }


    Rectangle {
        id:  signup_rect
        anchors.fill: parent
        color: "transparent"

        Rectangle
        {
            id: signup_email_rect
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            width: 600
            height: 40
            color: "transparent"
            radius: width/2
            visible: signupPage
            MouseArea{cursorShape: Qt.PointingHandCursor}
            Rectangle
            {
                id: signup_email_inner_rect
                border.color: "#fdc807"
                border.width: 3
                anchors.fill: parent
                color: "#34537a"
                opacity: 0.7
                radius: parent.radius
            }
            TextField
            {
                id: signup_field_email
                placeholderText: qsTr("Email")
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

                onTextChanged: {
                   clear_error()
                }
            }
        }

        Rectangle
        {
            id: signup_username_rect
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: signup_email_rect.bottom
            anchors.topMargin: 10
            width: 600
            height: 40
            color: "transparent"
            radius: width/2
            visible: signupPage
            MouseArea{cursorShape: Qt.PointingHandCursor}
            Rectangle
            {
                id: signup_username_inner_rect
                border.color: "#fdc807"
                border.width: 3
                anchors.fill: parent
                color: "#34537a"
                opacity: 0.7
                radius: parent.radius
            }
            TextField
            {
                id: signup_field_username
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

                onTextChanged: {
                   clear_error()
                }

            }
        }

        Rectangle
        {
            id: signup_password_rect
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: signup_username_rect.bottom
            anchors.topMargin: 10
            width: 600
            height: 40
            color: "transparent"
            radius: width/2
            visible: signupPage
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
                id: signup_field_password
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
                    placeholderTextColor: "grey"
                    passwordCharacter: "*"
                    background: Rectangle{
                        color: "transparent"
                    }
                }

                onTextChanged: {
                   clear_error()
                }
            }
        }

        Rectangle
        {
            id: signup_password_confirm_rect
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: signup_password_rect.bottom
            anchors.topMargin: 10
            width: 600
            height: 40
            color: "transparent"
            radius: width/2
            visible: signupPage
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
                id: signup_field_password_confirm
                placeholderText: qsTr("Confirm Password")
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
            }
        }

        Row {
            id: signup_buttons_row
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: signup_password_confirm_rect.bottom
            anchors.topMargin: 40
            spacing: 30

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
                        validateValues(email, username, password, confirmPassword);
                    }
                }

            }

            ButtonMainPage
            {
                id: cancel_button
                anchors.verticalCenter: parent.verticalCenter
                button_text: qsTr("Cancel")
                MouseArea
                {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton
                    onPressed: {parent.state="clicked"}
                    onReleased: {parent.state="unclicked"}
                    onClicked: { app_title_bar.popPage() }
                }
            }
        }

        //error message
        Rectangle
        {
            id: signup_error_rect
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: signup_buttons_row.bottom
            anchors.topMargin: 10
            width: 600
            height: 40
            color: "transparent"
            radius: width/2
            visible: false
            MouseArea{cursorShape: Qt.PointingHandCursor}
            Rectangle
            {
                id: signup_error_inner_rect
                border.color: "red"
                border.width: 3
                anchors.fill: parent
                color: "#34537a"
                opacity: 0.7
                radius: parent.radius
            }
            TextField
            {
                id: signup_error
                readOnly: true
                text: error_text
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

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
