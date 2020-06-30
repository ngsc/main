QT += core gui qml quick opengl


greaterThan(QT_MAJOR_VERSION, 4): QT += widgets quick quickwidgets location positioning network

CONFIG += c++11
CONFIG += resources_big

SOURCES += main.cpp \
    mainwindow.cpp \
    apiconnection.cpp \
    teamtactic.cpp \
    teamtacticmodel.cpp \
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
    announcement.cpp \
    announcementmodel.cpp \
    playercomment.cpp \
    playercommentsmodel.cpp \
    bullettext.cpp \
    bullets.cpp \
    historybrief.cpp \
    usercommentsmodel.cpp \
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
    MonitorController.cpp \
    FieldController.cpp \
    PlayerController.cpp \
    monitor/src/rcsslogplayer_cpp/gzfstream.cpp \
    monitor/src/rcsslogplayer_cpp/parser.cpp \
    monitor/src/rcsslogplayer_cpp/types.cpp \
    monitor/src/rcsslogplayer_cpp/util.cpp

RESOURCES += \
    qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
#QML_IMPORT_PATH =

# Default rules for deployment.
#include(deployment.pri)

INCLUDEPATH += $$PWD\monitor\include\rcsslogplayer \
                $$PWD\monitor\include

LIBS += -lwsock32 -lOle32

HEADERS += \
    Constants.h \
    mainwindow.h \
    apiconnection.h \
    teamtactic.h \
    teamtacticmodel.h \
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
    announcement.h \
    announcementmodel.h \
    playercomment.h \
    playercommentsmodel.h \
    bullettext.h \
    bullets.h \
    historybrief.h \
    usercommentsmodel.h \
    monitor/src/rcsslogplayer_cpp/gzfstream.cpp \
    monitor/src/rcsslogplayer_cpp/parser.cpp \
    monitor/src/rcsslogplayer_cpp/types.cpp \
    monitor/src/rcsslogplayer_cpp/util.cpp \
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
    MonitorController.h \
    FieldController.h \
    PlayerController.h


TRANSLATIONS = languages/snarky_English.ts languages/snarky_Japanies.ts languages/snarky_Chinese_Simplified.ts

