import QtQuick 2.0

Rectangle{


    color: backgroundColor
    width : 300
    height: 60
    border.color: "green"
//    anchors.leftMargin: 5

    property string imageSource : ""
    property string newsText: ""
    property bool imageVisible: false
    property string textColor: "black"
    property string backgroundColor: "transparent"

    function setImageSource(name){
        imageSource = ":/icons/" + name + ".png"
    }

    Text {
        id: newsElementText
        height: parent.height
        width: parent.width - newsElementImage.width - 5
        anchors.left: newsElementImage.right
        text: qsTr(newsText)
    }

    Image {
        id: newsElementImage
        height: parent.height
        width: 80
        anchors.left: parent.left
        source: imageSource
        visible: true//imageVisible
    }
}
