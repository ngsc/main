QT += core gui qml quick


greaterThan(QT_MAJOR_VERSION, 4): QT += widgets quick quickwidgets location positioning network

CONFIG += c++11

SOURCES += main.cpp \
    mainwindow.cpp \
    apiconnection.cpp \
    user.cpp \
    tournament.cpp \
    player.cpp \
    club.cpp \
    playermodel.cpp \
    clubmodel.cpp \
    tournamentmodel.cpp \
    sortfilterproxymodel.cpp \
    searchingpoolmodel.cpp \
    currencyformatter.cpp \
    notification.cpp \
    notificationmodel.cpp \
    match.cpp \
    matchmodel.cpp \
    simpleusermodel.cpp \
    invitation.cpp \
    invitationmodel.cpp \
    newsmodel.cpp \
    news.cpp \
    monitor/src/rcsslogplayer_cpp/gzfstream.cpp \
    monitor/src/rcsslogplayer_cpp/parser.cpp \
    monitor/src/rcsslogplayer_cpp/types.cpp \
    monitor/src/rcsslogplayer_cpp/util.cpp \
    monitor/src/angle_deg.cpp \
    monitor/src/ball_painter.cpp \
    monitor/src/circle_2d.cpp \
    monitor/src/config_dialog.cpp \
    monitor/src/disp_holder.cpp \
    monitor/src/draw_info_painter.cpp \
    monitor/src/field_canvas.cpp \
    monitor/src/field_painter.cpp \
    monitor/src/line_2d.cpp \
    monitor/src/log_player.cpp \
    monitor/src/main_window.cpp \
    monitor/src/monitor_client.cpp \
    monitor/src/monitor_main.cpp \
    monitor/src/options.cpp \
    monitor/src/player_painter.cpp \
    monitor/src/player_type_dialog.cpp \
    monitor/src/score_board_painter.cpp \
    monitor/src/team_graphic.cpp \
    monitor/src/team_graphic_painter.cpp \
    monitor/src/vector_2d.cpp \
    PlayerController.cpp \
    FieldController.cpp \
    MonitorController.cpp

RESOURCES += \
    qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
#QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

INCLUDEPATH += $$PWD\monitor\include\rcsslogplayer \
                $$PWD\monitor\include \
                $$PWD\icons

HEADERS += \
    mainwindow.h \
    apiconnection.h \
    user.h \
    tournament.h \
    player.h \
    club.h \
    playermodel.h \
    clubmodel.h \
    tournamentmodel.h \
    sortfilterproxymodel.h \
    searchingpoolmodel.h \
    currencyformatter.h \
    notification.h \
    notificationmodel.h \
    match.h \
    matchmodel.h \
    simpleusermodel.h \
    invitation.h \
    invitationmodel.h \
    newsmodel.h \
    news.h \
    monitor/include/rcsslogplayer/gzfstream.h \
    monitor/include/rcsslogplayer/handler.h \
    monitor/include/rcsslogplayer/parser.h \
    monitor/include/rcsslogplayer/types.h \
    monitor/include/rcsslogplayer/util.h \
    monitor/include/angle_deg.h \
    monitor/include/ball_painter.h \
    monitor/include/circle_2d.h \
    monitor/include/config_dialog.h \
    monitor/include/disp_holder.h \
    monitor/include/draw_info_painter.h \
    monitor/include/field_canvas.h \
    monitor/include/field_painter.h \
    monitor/include/line_2d.h \
    monitor/include/log_player.h \
    monitor/include/main_window.h \
    monitor/include/monitor_client.h \
    monitor/include/mouse_state.h \
    monitor/include/options.h \
    monitor/include/painter_interface.h \
    monitor/include/player_painter.h \
    monitor/include/player_type_dialog.h \
    monitor/include/scoped_ptr.hpp \
    monitor/include/score_board_painter.h \
    monitor/include/team_graphic.h \
    monitor/include/team_graphic_painter.h \
    monitor/include/vector_2d.h \
    PlayerController.h \
    FieldController.h \
    MonitorController.h


TRANSLATIONS = languages/snarky_en.ts languages/snarky_jp.ts languages/snarky_zh.ts
