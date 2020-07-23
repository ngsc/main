import QtQuick 2.0
import Constants 1.0

Rectangle
{
    implicitWidth: 15
    implicitHeight: implicitWidth
    Image
    {
        anchors.fill: parent
        anchors.margins: 1
        fillMode: Image.Stretch
        source: Constants.scrollBarUpIconPath
        opacity: 1
    }
}
