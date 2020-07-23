import QtQuick 2.0
import Constants 1.0

Rectangle
{
    implicitWidth: 15
    implicitHeight: implicitWidth
    //color: "#34537a"
    Image
    {
        anchors.fill: parent
        anchors.leftMargin: 1
        fillMode: Image.Stretch
        source: Constants.scrollBarDownIconPath
        opacity: 1
    }
}
