import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0
import com.Game.APIConnection 1.0

Item {
    id: knowledge_survey
    property string titleBar: qsTr("Quiz")

    Rectangle {
        id: rectangle
        anchors.fill: parent
        color: "transparent"

        Rectangle {
            id: kc

            anchors.top: parent.top
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.bottom: confirm_button.top
            anchors.bottomMargin: 5
            border.color:  "#5283bf"
            color: "transparent"
            border.width: 3
            radius: 10

            ScrollView {
                id: knowledge_scroll_view
                anchors.fill: parent
                anchors.margins: 5

                horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
                style: ScrollViewStyle{
                    handle: Rectangle {
                        id: knowledge_scroll_view_handle
                        implicitWidth: 15
                        radius: width/2
                        color: "#55aaff"
                        border.color: "#577fa9"
                        border.width: 2
                    }
                    scrollBarBackground: Rectangle {
                        id: knowledge_scroll_view_background
                        implicitWidth: 15
                        implicitHeight: knowledge_scroll_view.height
                        radius: 7
                        color: "#3b76b1"
                        border.color: "#34537a"
                        border.width: 1
                        //color: "#ffffff"
                    }
                    decrementControl: Rectangle {
                        id: knowledge_scroll_view_dec_control
                        implicitWidth: 15
                        implicitHeight: implicitWidth
                        color: "#34537a"
                        Image
                        {
                            anchors.fill: parent
                            anchors.margins: 1
                            //anchors.margins: 1
                            fillMode: Image.Stretch
                            source: "qrc:/icons/arrow-orange-up.png"
                            opacity: 1
                        }
                    }
                    incrementControl: Rectangle {
                        id: knowledge_scroll_view_inc_control
                        implicitWidth: 15
                        implicitHeight: implicitWidth
                        color: "#34537a"
                        Image
                        {
                            anchors.fill: parent
                            anchors.leftMargin: 1
                            fillMode: Image.Stretch
                            source: "qrc:/icons/arrow-orange-down.png"
                            opacity: 1
                        }
                    }
                }
                visible: (parent.height>30) ? true : false
                ListView {
                    id: listView
                    anchors.fill: parent
                    model: myModel
                    spacing: 20
                    delegate: ColumnLayout {
                        id: dlg
                        property int current_index: -1
                        property int ai: answer_index
                        property bool correct_answer:  ai === dlg.current_index

                        Text {
                            id: question_id
                            font.family: "Comic Sans MS"
                            color: "#ffaa00"
                            font.pointSize: 11
                            text: question
                        }
                        RowLayout {
                            ExclusiveGroup { id: group }
                            anchors.leftMargin: 10
                            spacing: 5
                            CustomRadioButton {
                                id: r1
                                text: option_1
                                exclusiveGroup: group
                                onRadioButtonClick: {
                                    current_index = 1
                                }
                            }
                            CustomRadioButton {
                                id: r2
                                text: option_2
                                exclusiveGroup: group
                                onRadioButtonClick: {
                                    current_index = 2
                                }
                            }
                            CustomRadioButton {
                                id: r3
                                text: option_3
                                exclusiveGroup: group
                                onRadioButtonClick: {
                                    current_index = 3
                                }
                            }
                            CustomRadioButton {
                                id: r4
                                text: option_4
                                exclusiveGroup: group
                                onRadioButtonClick: {
                                    current_index = 4
                                }
                            }
                        }
                    }
                }
            }

            ListModel {
                id: myModel
                // D B A A D
                ListElement {question: qsTr("1 What's Modeste's favorite shirt number?"); option_1: qsTr("8"); option_2: qsTr("9"); option_3: qsTr("37"); option_4: qsTr("27"); answer_index: 4}
                ListElement {question: qsTr("2 How many goals had Ronaldo scored in World Cup final stage?"); option_1: qsTr("12"); option_2: qsTr("15"); option_3: qsTr("16"); option_4: qsTr("17"); answer_index: 2}
                ListElement {question: qsTr("3 What's Cristiano Ronaldo 's first footballer club?"); option_1: "Sporting CP"; option_2: "FC Porto"; option_3: "Manchest United"; option_4: "AC Milan"; answer_index: 1}
                ListElement {question: qsTr("4 What's the birthday of FIFA president Blatter?"); option_1: qsTr("1936"); option_2: qsTr("1938"); option_3: qsTr("1939"); option_4: qsTr("1940"); answer_index: 1}
                ListElement {question: qsTr("5 Who is the most valuable transfe winner in soccer field so far?"); option_1: qsTr("Ronaldo"); option_2: qsTr("Pogba"); option_3: qsTr("Beckham"); option_4: qsTr("Neymar"); answer_index: 4}
            }
        }

        MyButtonNormal {
            id: confirm_button
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            text: qsTr("Confirm")
            onClicked:
            {
                var pass = rectangle.is_pass(listView.contentItem)
                console.log("is pass: " + pass)

                if(pass === true)
                {
                    APIConnection.updateQuizPass(managerUser.token)
                    managerUser.quizPass = true
                    alerts.show(qsTr("Congratulations, you passed the knowledge quiz!"), "green");
                    app_title_bar.popPage()
                    app_title_bar.forwardlist.pop();
                    app_title_bar.setforwordvisibility = false
                }
            }
        }

        MyButtonNormal {
            id: cancel_button
            anchors.right: confirm_button.left
            anchors.rightMargin: 20
            anchors.bottom: parent.bottom
            text: qsTr("Cancel")
            onClicked: { app_title_bar.popPage() }
        }

        Countdown {
            id: count_down
            anchors.bottom: parent.bottom

            anchors.left: parent.left
            anchors.top: confirm_button.top

            onTimeout: {
                //stop the quiz
                var pass = rectangle.is_pass(listView.contentItem)

                if(pass) {
                    APIConnection.updateQuizPass(managerUser.token)
                    managerUser.quizPass = true
                    alerts.show(qsTr("Congratulations, you passed the knowledge quiz!"), "green");
                }
                else {
                    alerts.show(qsTr("Oops, try again to pass the knowledge quiz!"), "red");
                }

                app_title_bar.popPage()
                app_title_bar.forwardlist.pop();
                app_title_bar.setforwordvisibility = false
            }
        }

        function is_pass(contentItem) {

            for(var i = 0; i < contentItem.children.length; i++) {
                var item = contentItem.children[i];
                console.log("is_pass correct_answer: " + item.correct_answer)
                if (item.correct_answer === false) {
                    return false;
                }
            }

            return true;
        }
    }

    function start_count_down() {
        listView.model = 0
        listView.model = myModel
        count_down.start();
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
