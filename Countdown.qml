import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    id: count_down
    signal timeout
    property int defaultSeconds: 30
    property int seconds: defaultSeconds
    property color background_color: "#1b4caf"

    height: 50
    width: 100

    function pad(n, width, z) {
            z = z || '0';
            n = n + '';
            return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
    }

    Rectangle {
        id: count_down_inner_rect
        anchors.fill: parent

        color: background_color
        radius: width/2

        Text {
            id: time_text
            anchors.centerIn: parent
            color: "#ffffff"
            font.pointSize: 12
            font.family: "Comic Sans MS"
            text: qsTr(count_down.pad(Math.max(0,Math.floor(seconds/60)),2) + ":" + pad(Math.max(0,seconds% 60),2))
        }
    }

    Timer {
        id: innerTimer
        repeat: true
        interval: 1000
        onTriggered: {
            count_down.seconds--;
            if (count_down.seconds == 0) {
                running = false;
                count_down.timeout()
            }

            if(count_down.seconds <10) {
                count_down_inner_rect.color = "red"
                time_text.color = "white"
            }
        }
    }

    Behavior on opacity {
        PropertyAnimation { duration: 200 }
    }

    function start() {
        seconds = defaultSeconds
        opacity = 1;
        count_down_inner_rect.color = background_color
        innerTimer.start();
    }

    function stop() {
        opacity = 0;
        innerTimer.stop();
    }
}
