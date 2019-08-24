/*
** Added by Ahmed Soliman
** For further information use the contact form at AhmedSoliman_1234@hotmail.com.
*/

import QtQuick 2.6
import QtQuick.Controls 2.1

Item {
    id : customComboBox
    width: 200
    height: 30

    property var items_list
    property string items_text : combobox.currentText.toString()
    property alias currentIndex: combobox.currentIndex
    property alias currenText : combobox.displayText    //combobox.currentText is readonly property.
    property alias displayText: combobox.displayText

    ComboBox {
        id:combobox
        model: items_list
        width: parent.width
        height: 30
        //currentIndex: setcurrentIndex
        opacity: customComboBox.enabled ? 1 : 0.8

        property int newIndex: 0
        Keys.onUpPressed: combobox.decrementCurrentIndex()
        Keys.onDownPressed: combobox.incrementCurrentIndex()

        indicator: Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: 40
            anchors.verticalCenter: parent.verticalCenter
            Image {
                id: name
                anchors.verticalCenter: parent.verticalCenter
                height: 20
                width: height
                fillMode: Image.Stretch
                source: "qrc:/icons/arrow-white-down.png"
            }
        }

        delegate: ItemDelegate {
            id :itemdelegate
            height: 30
            width: combobox.width
            property bool hoveredornot : false
            background: Rectangle {  // selection of an item
                id : delgatebackground
                implicitWidth: 200
                implicitHeight: 30
                height: 30
                radius: 30
                color: (combobox.highlightedIndex === index)?   "lightblue" : "#3b76b1"
                MouseArea
                {
                    id:mouseAreatext
                    anchors.fill:parent
                    hoverEnabled:true
                    onHoveredChanged: {
                        if(hoveredornot){
                            delgatebackground.color = "#3b76b1"
                            textdelegate.color = "white"
                            hoveredornot = false
                        }else{
                            hoveredornot = true
                            delgatebackground.color = "lightblue"
                            textdelegate.color = "black"
                        }
                        combobox.currentIndex = index
                    }
                    onClicked: {
                        combobox.currentIndex = index
                        combobox.displayText = modelData
                        combobox.popup.close()
                    }
                }
            }
            contentItem: Text {
                id : textdelegate
                text: qsTr(modelData)
                color:(combobox.highlightedIndex === index) ?"black" :  "white"
                height: 30
                font: combobox.font
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
            }
            highlighted: combobox.highlightedIndex === index
        }

        contentItem: Text {//ComboBox text
            leftPadding: 10
            height: 30
            rightPadding: combobox.indicator.width + combobox.spacing
            text: qsTr(combobox.displayText)
            font: combobox.font
            color:    "white"
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {//ComboBox background
            id: rect
            implicitWidth: 120
            implicitHeight: 30
            height: 30
            color: customComboBox.enabled ? "#3b76b1" : "#2e598f"
            radius: 30
//            opacity: customComboBox.enabled ? 1 : 0.8
        }

        popup: Popup {
            y: combobox.height
            width: combobox.width
            height: contentHeight
            padding: 0
            spacing: 0
            contentItem: ListView {
                clip: true
                id: listview
                spacing: 0
                height: contentHeight
                model: combobox.popup.visible ? combobox.delegateModel : null
                currentIndex:combobox.highlightedIndex
                ScrollIndicator.vertical: ScrollIndicator { }
            }
            background: Rectangle {
                width: combobox.width
                height : listview.contentHeight
                border.color: "#3b76b1"
                color:  "#3b76b1"
                radius: 10
            }
        }
    }
}
