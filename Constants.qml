pragma Singleton
import QtQuick 2.0

Item{

    // Main Window main.qml
    readonly property int appWidth: 1466
    readonly property int appHeight: 780
    readonly property int panelButtonWidth: 180
    readonly property int panelWidth: panelButtonWidth * 5 + 10 //910

    //Title Bar
    readonly property int titleBarWidth: panelWidth  // 910
    readonly property int titleBarHeight: 80

    //scroll Bar colors
    readonly property string scrollBarHandleColor: "#b4b4b4"
    readonly property string scrollBarHandleColorBorder: "#999999"
    readonly property string scrollBarBackgroundColor: "#d9d9d9"
    readonly property string scrollBarBackgroundColorBorder: "#999999"
    readonly property string scrollBarDownIconPath: "qrc:/icons/arrow-cm4-white-gray-down.png"
    readonly property string scrollBarUpIconPath: "qrc:/icons/arrow-cm4-white-gray-up.png"

    readonly property string backgroundColor: "#3b76b1"
    readonly property string backgroundBorderColor: "#34537a"

    // MyNormal button
    readonly property string menuButtonColor: "#989898"
    readonly property string menuButtonTextColor: "#e6e6e6"

    // Combobox colors
    readonly property string comboboxButtonColor: "#989898"
    readonly property string comboboxButtonTextColor: "#e6e6e6"
    readonly property string comboboxButtonHoveredTextColor: "#f7e90e"

    // Checkbox color constants
    readonly property string checkboxColor: "#f0f5f0"
    readonly property string checkboxColorDisabled: "#8f908f"
    readonly property string checkboxColorHovered: "#cad0db"

    //background colors
    readonly property string menuBackgroundColor: "#122c68"
    readonly property string menuTextColor : "#009edf"
    readonly property string buttonMarginColor: "#fdc807"
    readonly property string backgroundLayerAlphaColor: "#2F4F4F"
    readonly property int menuRectRadius: 20

    readonly property FontLoader primaryFont: FontLoader {
        source: "qrc:/fonts/TT1212M_.TTF"
        }

    readonly property FontLoader secondaryFont: FontLoader {
        source: "qrc:/fonts/tt0756m_.ttf"
        }
}
