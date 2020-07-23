/*
** Added by Ahmed Soliman
** For further information use the contact form at AhmedSoliman_1234@hotmail.com.
*/
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
Rectangle
{
    id: root
    color: "transparent"
    property string titleBar: "Anti Opponent Tactic"

    MouseArea{
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
    }

    Rectangle{
        id: mapcontainer
        anchors.left: parent.left
        anchors.top : parent.top
        anchors.leftMargin: 40
        width: parent.width/2-80
        height: parent.height
        color: "transparent"
        z:parent.z+1
        Rectangle{
            id: map
            anchors.right: parent.right
            anchors.top : parent.top
            width: parent.width
            height: parent.height
            color: "green"
            border.width: 4
            border.color: "white"
            property int angle: 0
            property int originX: map.width/2
            property int originY: map.height/2
            smooth: true

            Rectangle{
                id: mapshadow
                anchors.left: parent.left
                anchors.top : parent.top
                width: parent.width
                height: parent.height
                color: "transparent"
                border.color: "white"
                opacity: 0.7
                z:parent.z
                Rectangle{
                    width: 2*mapcontainer.width/5
                    height: 1*mapcontainer.height/8
                    color: "transparent"
                    border.width: 4
                    border.color: "white"
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Rectangle{
                    width: 3*mapcontainer.width/5
                    height: 2*mapcontainer.height/8
                    color: "transparent"
                    border.width: 4
                    border.color: "white"
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Rectangle{
                    width: 2*mapcontainer.width/5
                    height: 1*mapcontainer.height/8
                    color: "transparent"
                    border.width: 4
                    border.color: "white"
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Rectangle{
                    width: 3*mapcontainer.width/5
                    height: 2*mapcontainer.height/8
                    color: "transparent"
                    border.width: 4
                    border.color: "white"
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Rectangle{
                    width: parent.width
                    height: parent.height/2+2
                    color: "transparent"
                    border.width: 4
                    border.color: "white"
                    anchors.top: parent.top
                }
                Rectangle{
                    width: parent.width
                    height: parent.height/2
                    color: "transparent"
                    border.width: 4
                    border.color: "white"
                    anchors.bottom: parent.bottom
                }
                Rectangle{
                    width: 2*parent.width/5
                    height: width
                    radius: width/2
                    color: "transparent"
                    border.width: 4
                    border.color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }

                Rectangle{
                    id: playershadow
                    anchors.left: parent.left
                    anchors.top : parent.top
                    width: parent.width
                    height: parent.height
                    color: "transparent"
                    visible: false
                    opacity: 0.4
                    Rectangle{
                        width: 40
                        height: 40
                        x : 2*parent.width/5+parent.width/10-width/2
                        y : 8*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        width: 40
                        height: 40
                        x : 2*parent.width/5+parent.width/10-width/2
                        y : 7*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        width: 40
                        height: 40
                        x : 2*parent.width/5+parent.width/10-width/2
                        y : 6*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        width: 40
                        height: 40
                        x : 0*parent.width/5+parent.width/10-width/2
                        y : 6*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        width: 40
                        height: 40
                        x : 1*parent.width/5+parent.width/10-width/2
                        y : 6*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        width: 40
                        height: 40
                        x : 3*parent.width/5+parent.width/10-width/2
                        y : 6*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        width: 40
                        height: 40
                        x : 4*parent.width/5+parent.width/10-width/2
                        y : 6*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        width: 40
                        height: 40
                        x : 0*parent.width/5+parent.width/10-width/2
                        y : 5*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        width: 40
                        height: 40
                        x : 1*parent.width/5+parent.width/10-width/2
                        y : 5*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        width: 40
                        height: 40
                        x : 2*parent.width/5+parent.width/10-width/2
                        y : 5*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        width: 40
                        height: 40
                        x : 3*parent.width/5+parent.width/10-width/2
                        y : 5*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        width: 40
                        height: 40
                        x : 4*parent.width/5+parent.width/10-width/2
                        y : 5*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        width: 40
                        height: 40
                        x : 0*parent.width/5+parent.width/10-width/2
                        y : 4*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        width: 40
                        height: 40
                        x : 1*parent.width/5+parent.width/10-width/2
                        y : 4*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        width: 40
                        height: 40
                        x : 2*parent.width/5+parent.width/10-width/2
                        y : 4*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        width: 40
                        height: 40
                        x : 3*parent.width/5+parent.width/10-width/2
                        y : 4*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        width: 40
                        height: 40
                        x : 4*parent.width/5+parent.width/10-width/2
                        y : 4*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        width: 40
                        height: 40
                        x : 0*parent.width/5+parent.width/10-width/2
                        y : 3*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        width: 40
                        height: 40
                        x : 1*parent.width/5+parent.width/10-width/2
                        y : 3*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        width: 40
                        height: 40
                        x : 2*parent.width/5+parent.width/10-width/2
                        y : 3*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        width: 40
                        height: 40
                        x : 3*parent.width/5+parent.width/10-width/2
                        y : 3*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        width: 40
                        height: 40
                        x : 4*parent.width/5+parent.width/10-width/2
                        y : 3*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        width: 40
                        height: 40
                        x : 1*parent.width/5+parent.width/10-width/2
                        y : 2*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        width: 40
                        height: 40
                        x : 2*parent.width/5+parent.width/10-width/2
                        y : 2*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }
                    Rectangle{
                        width: 40
                        height: 40
                        x : 3*parent.width/5+parent.width/10-width/2
                        y : 2*(parent.height/8)-parent.height/16-height/2
                        radius: 20
                        color: "red"
                        border.width: 4
                        border.color: "white"
                    }

                }
            }

            Rectangle{
                id : goal
                width: 40
                height: 40
                radius: 20
                x : 2*parent.width/5+parent.width/10-width/2
                y : 8*(parent.height/8)-parent.height/16-height/2
                color: "black"
                border.width: 4
                border.color: "white"
                z : parent.z+1
                Text {
                    color:"White"
                    font.pointSize: 9
                    text: qsTr("GK")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Rectangle{
                id : circle1
                x : 0*parent.width/5+parent.width/10-width/2
                y : 6*(parent.height/8)-parent.height/16-height/2
                width: 40
                height: 40
                radius: 20
                color: "red"
                border.width: 4
                border.color: "white"
                z : parent.z+1
                Text {
                    color:"White"
                    font.pointSize: 9
                    text: qsTr("FB")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Rectangle{
                id : circle2
                x : 1*parent.width/5+parent.width/10-width/2
                y : 6*(parent.height/8)-parent.height/16-height/2
                width: 40
                height: 40
                radius: 20
                color: "red"
                border.width: 4
                border.color: "white"
                z : parent.z+1
                Text {
                    color:"White"
                    font.pointSize: 9
                    text: qsTr("CD")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Rectangle{
                id : circle3
                x : 1*parent.width/5+parent.width/10-width/2
                y : 2*(parent.height/8)-parent.height/16-height/2
                width: 40
                height: 40
                radius: 20
                color: "red"
                border.width: 4
                border.color: "white"
                z : parent.z+1
                Text {
                    color:"White"
                    font.pointSize: 9
                    text: qsTr("FS")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Rectangle{
                id : circle4
                x : 3*parent.width/5+parent.width/10-width/2
                y : 6*(parent.height/8)-parent.height/16-height/2
                width: 40
                height: 40
                radius: 20
                color: "red"
                border.width: 4
                border.color: "white"
                z : parent.z+1
                Text {
                    color:"White"
                    font.pointSize: 9
                    text: qsTr("CD")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Rectangle{
                id : circle5
                x : 4*parent.width/5+parent.width/10-width/2
                y : 6*(parent.height/8)-parent.height/16-height/2
                width: 40
                height: 40
                radius: 20
                color: "red"
                border.width: 4
                border.color: "white"
                z : parent.z+1
                Text {
                    color:"White"
                    font.pointSize: 9
                    text: qsTr("FB")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Rectangle{
                id : circle6
                x : 0*parent.width/5+parent.width/10-width/2
                y : 4*(parent.height/8)-parent.height/16-height/2
                width: 40
                height: 40
                radius: 20
                color: "red"
                border.width: 4
                border.color: "white"
                z : parent.z+1
                Text {
                    color:"White"
                    font.pointSize: 9
                    text: qsTr("SM")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Rectangle{
                id : circle7
                x : 1*parent.width/5+parent.width/10-width/2
                y : 4*(parent.height/8)-parent.height/16-height/2
                width: 40
                height: 40
                radius: 20
                color: "red"
                border.width: 4
                border.color: "white"
                z : parent.z+1
                Text {
                    color:"White"
                    font.pointSize: 9
                    text: qsTr("MF")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Rectangle{
                id : circle8
                x : 3*parent.width/5+parent.width/10-width/2
                y : 2*(parent.height/8)-parent.height/16-height/2
                width: 40
                height: 40
                radius: 20
                color: "red"
                border.width: 4
                border.color: "white"
                z : parent.z+1
                Text {
                    color:"White"
                    font.pointSize: 9
                    text: qsTr("FS")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Rectangle{
                id : circle9
                x : 3*parent.width/5+parent.width/10-width/2
                y : 4*(parent.height/8)-parent.height/16-height/2
                width: 40
                height: 40
                radius: 20
                color: "red"
                border.width: 4
                border.color: "white"
                z : parent.z+1
                Text {
                    color:"White"
                    font.pointSize: 9
                    text: qsTr("MF")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Rectangle{
                id : circle10
                x : 4*parent.width/5+parent.width/10-width/2
                y : 4*(parent.height/8)-parent.height/16-height/2
                width: 40
                height: 40
                radius: 20
                color: "red"
                border.width: 4
                border.color: "white"
                z : parent.z+1
                Text {
                    color:"White"
                    font.pointSize: 9
                    text: qsTr("SM")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }

            }

            MouseArea{
                id : mouse1
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
            }

        }
    }

    Rectangle{
        id: detailes
        anchors.right: parent.right
        anchors.top : parent.top
        width: parent.width/2-5
        height: parent.height

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#34537a" }
            GradientStop { position: 0.50; color: "#5283bf" }
            GradientStop { position: 1.0; color: "#6dafff" }
        }
        z:parent.z+1
        MouseArea{
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
        }
        Rectangle{
            id : teaminstructionrect
            width: parent.width-20
            height: parent.height
            anchors.left: parent.left
            anchors.top: parent.top
            color: "transparent"
            z:parent.z+1
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
            }
            Rectangle{
                id : teaminstruction
                width: parent.width/2+20
                anchors.left: parent.left
                height: 30
                border.color: "gray"
                color: "light gray"
                z:parent.z+1
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
                Text {
                    id : teaminstructiontext
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.family:Constants.secondaryFont ? Constants.secondaryFont.name: null
                    font.bold: true
                    font.italic: true
                    font.pointSize: 10
                    text: qsTr("Anti-opponent Instruction")

                }
            }
            Column {
                id : opponentInstruction
                anchors.top: teaminstruction.bottom
                spacing: 15
                padding: 20
                CheckBox {
                    text: qsTr("Prevent Passing")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                            parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
                CheckBox {
                    text: qsTr("Prevent Cutting")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                            parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
                CheckBox {
                    text: qsTr("Tight Marking")
                    checked: false
                    onCheckedChanged: {
                        if(checked===true){
                            //TO write your code here
                            console.log("you checked Tight Marking wirte your code here in inside_10 line 399")
                        }
                    }
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                            parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
            }
            Column {

                anchors.top: opponentInstruction.bottom
                anchors.right: parent.right
                spacing: 15
                padding: 20
                CheckBox {
                    text: qsTr("Guangzhou 1")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                            parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
                CheckBox {
                    text: qsTr("Guangzhou 2")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                            parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
                CheckBox {
                    text: qsTr("Guangzhou 3")
                    checked: false
                    z:parent.z+1
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(parent.checked === false){
                            parent.checked = true
                            }else{parent.checked = false}
                        }
                    }
                }
            }
        }
    }
}
