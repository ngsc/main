import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
Rectangle
{
    id: page2
    color: "transparent"
    property string titleBar: qsTr("Configuration Page")

    Rectangle
    {
        anchors.fill: parent
        color: "transparent"
        CustomGroupBox
        {
            anchors.left: parent.left
            anchors.top: parent.top
            width: 400
            height: 150
            title_text: qsTr("Game Settings")
            border_color: "#55aaff"
            border_width: 1
            box_content_item:  Rectangle
            {
                anchors.fill: parent
                color: "transparent"
                radius: parent.radius
                clip: true
                Text {
                    id: lang_label
                    text: qsTr("Language")
                    font.family: "Comic Sans MS"
                    color: "#ffffff"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    font.pointSize: 11
                    anchors.leftMargin: 20
                    anchors.topMargin: 20
                }
                CustomComboBox
                {
                    id: lang_combo_box
                    anchors.verticalCenter: lang_label.verticalCenter
                    items_list: ["English", "Chinese Simplified", "Japanies"]
                    anchors.right: parent.right
                    anchors.rightMargin: 40
                    height: lang_label.height+5
                    currentIndex: myGlobalObject.setLang()

                }
                Text
                {
                    id: abuse_label
                    text: qsTr("Abuse Filter")
                    font.family: "Comic Sans MS"
                    color: "#ffffff"
                    anchors.left: parent.left
                    anchors.top: lang_label.bottom
                    font.pointSize: 11
                    anchors.leftMargin: 20
                    anchors.topMargin: 20
                }
                CheckBox
                {
                    id: abuse_check_box
                    anchors.verticalCenter: abuse_label.verticalCenter
                    anchors.left: lang_combo_box.left
                    checked:myGlobalObject.setAbuse_Filter()
                    style: CheckBoxStyle
                    {
                        indicator: Rectangle {
                        height: abuse_label.height
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
                            visible: abuse_check_box.checked? true: false
                        }
                        }
                    }
                }
                Text
                {
                    id: music_switch_label
                    text: qsTr("Music Switch")
                    font.family: "Comic Sans MS"
                    color: "#ffffff"
                    anchors.left: parent.left
                    anchors.top: abuse_label.bottom
                    font.pointSize: 11
                    anchors.leftMargin: 20
                    anchors.topMargin: 20
                }
                CheckBox
                {
                    id: music_switch_check_box
                    anchors.verticalCenter: music_switch_label.verticalCenter
                    anchors.left: lang_combo_box.left
                    checked:myGlobalObject.setMusicSwitch()
                    style: CheckBoxStyle
                    {
                        indicator: Rectangle {
                        height: abuse_label.height
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
                            visible: music_switch_check_box.checked ? true: false
                        }
                        }
                    }
                }
            }
        }
        CustomGroupBox
        {
            id: graphic_settings_box
            anchors.right: parent.right
            anchors.top: parent.top
            width: 400
            height: 150
            title_text: qsTr("Graphics Settings")
            border_color: "#55aaff"
            border_width: 1
            box_content_item:  Rectangle
            {
                anchors.fill: parent
                color: "transparent"
                radius: parent.radius
                clip: true
                Text {
                    id: skin_label
                    text: qsTr("Skin Selector")
                    font.family: "Comic Sans MS"
                    color: "#ffffff"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    font.pointSize: 11
                    anchors.leftMargin: 20
                    anchors.topMargin: 20
                }
                CustomComboBox
                {
                    id: skin_selector_combo_box
                    items_list: ["Ferhan Blue", "Red Devil"]
                    anchors.verticalCenter: skin_label.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 40
                    height: skin_label.height+5
                    currentIndex: myGlobalObject.setSkin()

                }
                Text
                {
                    id: author_label
                    text: qsTr("Authors")
                    font.family: "Comic Sans MS"
                    color: "#ffffff"
                    anchors.left: parent.left
                    anchors.top: skin_label.bottom
                    font.pointSize: 11
                    anchors.leftMargin: 20
                    anchors.topMargin: 20
                }
                Text
                {
                    id: author_text
                    anchors.verticalCenter: author_label.verticalCenter
                    anchors.left: skin_selector_combo_box.left
                    text: qsTr("Ferhan, Darryl, Meena")
                    font.family: "Comic Sans MS"
                    color: "#ffffff"
                    font.pointSize: 11

                }
                Text
                {
                    id: description_label
                    text: qsTr("Description")
                    font.family: "Comic Sans MS"
                    color: "#ffffff"
                    anchors.left: parent.left
                    anchors.top: author_label.bottom
                    font.pointSize: 11
                    anchors.leftMargin: 20
                    anchors.topMargin: 20
                }
                Text
                {
                    id: description_text
                    anchors.verticalCenter: description_label.verticalCenter
                    anchors.left: author_text.left
                    text: setText()//   qsTr("Dark Blue Spirit")
                    font.family: "Comic Sans MS"
                    color: "#ffffff"
                    font.pointSize: 11
                    function setText(){
                        if(skin_selector_combo_box.items_text ===qsTr("Ferhan Blue")){
                            return (qsTr("Dark Blue Spirit"))
                        }else if(skin_selector_combo_box.items_text ===qsTr("Red Devil")){
                            return (qsTr("Alternative skin"))
                        }
                    }
                }
            }
        }
        CustomGroupBox
        {
            id: game_credits_box
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: graphic_settings_box.bottom
            anchors.topMargin: 10
            title_text: qsTr("Game Credits")
            height: 220
            box_content_item: Rectangle{
                    id: credits_inner_rectangle
                    anchors.fill: parent
                    anchors.rightMargin: 10
                    color: "transparent"
                    ScrollView
                    {
                        id: config_scroll_view
                        anchors.fill: parent
                        anchors.margins: 2
                        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
                        style: ScrollViewStyle{
                                    handle: Rectangle {
                                        id: announcement_board_scroll_view_handle
                                        implicitWidth: 15
                                        radius: width/2
                                        color: "#55aaff"
                                        border.color: "#577fa9"
                                        border.width: 2
                                    }
                                    scrollBarBackground: Rectangle {
                                        id: announcement_board_scroll_view_background

                                        implicitWidth: 15
                                        implicitHeight: config_scroll_view.height-(30)+10
                                        radius: width/2
                                        color: "#3b76b1"
                                        border.color: "#34537a"
                                        border.width: 1
                                        //color: "#ffffff"

                                        /*LinearGradient{
                                            anchors.fill: parent
                                            end: Qt.point(15,0)
                                            start: Qt.point(0,0)
                                            gradient:Gradient{
                                                        GradientStop { position: 0.0;  color: "#7c99d0" }
                                                        GradientStop { position: 0.25; color: "#ffffff" }
                                                        GradientStop { position: 0.50; color: "#ffffff" }
                                                        GradientStop { position: 1.0; color: "#7c99d0" }
                                            }
                                        }*/
                                    }
                                    decrementControl: Rectangle {
                                        id: announcement_board_scroll_view_dec_control
                                        implicitWidth: 15
                                        implicitHeight: implicitWidth
                                        color: "transparent"//"#34537a"//"#4081c2"
                                        radius: 5
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
                                        id: announcement_board_scroll_view_inc_control
                                        implicitWidth: 15
                                        implicitHeight: implicitWidth
                                        color: "transparent"//"#34537a"
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
                        Rectangle
                        {
                            width: credits_inner_rectangle.width-10
                            height: 300
                            color: "transparent"
                            opacity: 1
                            radius: game_credits_box.radius
                            Text
                            {
                                id: chestnut_label
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.leftMargin: 20
                                anchors.topMargin: 20
                                height: 30
                                width: 200
                                text: qsTr("Chestnut Studios")
                                font.family: "Comic Sans MS"
                                color: "#ffaa00"
                                font.pointSize: 11
                            }
                            Text
                            {
                                id: chestnut_motto
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.rightMargin: 10
                                anchors.topMargin: 20
                                height: 30
                                width: parent.width-chestnut_label.width-20-10-70
                                text: qsTr("Motto")
                                font.family: "Comic Sans MS"
                                color: "#ffaa00"
                                font.pointSize: 11
                            }
                            Text
                            {
                                id: label2
                                anchors.left: parent.left
                                anchors.top: chestnut_label.bottom
                                anchors.leftMargin: 20
                                anchors.topMargin: 20
                                height: 30
                                width: 200
                                text: qsTr("Meena : Technical Support")
                                font.family: "Comic Sans MS"
                                wrapMode: Text.Wrap
                                color: "#ffffff"
                                font.pointSize: 11
                            }
                            Text
                            {
                                id: text2
                                anchors.right: parent.right
                                anchors.top: chestnut_motto.bottom
                                anchors.rightMargin: 10
                                anchors.topMargin: 20
                                width: parent.width-chestnut_label.width-20-10-70//parent.width-chestnut_label.width-30-20-100
                                text: qsTr("If kisses hearts and flowers is what you know about love. Then you don't know what love really is.")
                                font.family: "Comic Sans MS"
                                wrapMode: Text.Wrap
                                color: "#ffffff"
                                font.pointSize: 11
                            }
                            Text
                            {
                                id: label3
                                anchors.left: parent.left
                                anchors.top: label2.bottom
                                anchors.leftMargin: 20
                                anchors.topMargin: 20
                                height: 30
                                width: 200
                                text: qsTr("Yazan Wasfi & Xiao Cong Hsu : Programming")
                                font.family: "Comic Sans MS"
                                wrapMode: Text.Wrap
                                color: "#ffffff"
                                font.pointSize: 11
                            }
                            Text
                            {
                                id: text3
                                anchors.right: parent.right
                                anchors.top: text2.bottom
                                anchors.rightMargin: 10
                                anchors.topMargin: 20
                                width: parent.width-label3.width-20-10-70//parent.width-chestnut_label.width-30-20-100
                                text: qsTr("Every French Soldier carries a marshal's baton in his Knapsack")
                                font.family: "Comic Sans MS"
                                wrapMode: Text.Wrap
                                color: "#ffffff"
                                font.pointSize: 11
                            }Text
                            {
                                id: label4
                                anchors.left: parent.left
                                anchors.top: label3.bottom
                                anchors.leftMargin: 20
                                anchors.topMargin: 20
                                height: 30
                                width: 200
                                text: qsTr("Darryl Lo : Chairman")
                                font.family: "Comic Sans MS"
                                wrapMode: Text.Wrap
                                color: "#ffffff"
                                font.pointSize: 11
                            }
                            Text
                            {
                                id: text4
                                anchors.right: parent.right
                                anchors.top: text3.bottom
                                anchors.rightMargin: 10
                                anchors.topMargin: 20
                                width: parent.width-label4.width-20-10-70//parent.width-chestnut_label.width-30-20-100
                                text: qsTr("Love and Piece!")
                                font.family: "Comic Sans MS"
                                wrapMode: Text.Wrap
                                color: "#ffffff"
                                font.pointSize: 11
                            }
                            Text
                            {
                                id: label5
                                anchors.left: parent.left
                                anchors.top: label4.bottom
                                anchors.leftMargin: 20
                                anchors.topMargin: 20
                                height: 30
                                width: 200
                                text: qsTr("Louis Yao : Market Supervisor")
                                font.family: "Comic Sans MS"
                                wrapMode: Text.Wrap
                                color: "#ffffff"
                                font.pointSize: 11
                            }
                            Text
                            {
                                id: text5
                                anchors.right: parent.right
                                anchors.top: text4.bottom
                                anchors.rightMargin: 10
                                anchors.topMargin: 20
                                width: parent.width-label5.width-20-10-70//parent.width-chestnut_label.width-30-20-100
                                text: qsTr("Never go south driving the chariot north!")
                                font.family: "Comic Sans MS"
                                wrapMode: Text.Wrap
                                color: "#ffffff"
                                font.pointSize: 11
                            }
                        }
                    }
            }
        }
        MyButtonNormal
        {
            id: confirm_button
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            text: qsTr("Confirm")
            onClicked:
            {
                app_title_bar.popPage();
                myGlobalObject.getConfig(lang_combo_box.currentIndex,skin_selector_combo_box.currentIndex,
                                         abuse_check_box.checkedState,music_switch_check_box.checkedState)
            }
        }
        MyButtonNormal
        {
            id: cancel_button
            anchors.right: confirm_button.left
            anchors.rightMargin: 20
            anchors.bottom: parent.bottom
            text: qsTr("Cancel")
            onClicked: { app_title_bar.popPage() }
        }
    }
}
