pragma Singleton
import QtQuick 2.0

Item{
    readonly property string scrollBarHandleColor: "#b4b4b4"
    readonly property string scrollBarHandleColorBorder: "#999999"
    readonly property string scrollBarBackgroundColor: "#d9d9d9"
    readonly property string scrollBarBackgroundColorBorder: "#999999"
    readonly property string scrollBarDownIconPath: "qrc:/icons/arrow-cm4-white-gray-down.png"
    readonly property string scrollBarUpIconPath: "qrc:/icons/arrow-cm4-white-gray-up.png"

    readonly property string backgroundColor: "#3b76b1"
    readonly property string backgroundBorderColor: "#34537a"

    readonly property FontLoader primaryFont: FontLoader {
        source: "qrc:/fonts/TT1212M_.TTF"
        }

    readonly property FontLoader secondaryFont: FontLoader {
        source: "qrc:/fonts/tt0756m_.ttf"
        }
}
