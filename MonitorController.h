// -*-c++-*-

/*!
  \file main_window.h
  \brief main application window class Header File.
*/

/*
 *Copyright:

 Copyright (C) The RoboCup Soccer Server Maintenance Group.
 Hidehisa AKIYAMA

 This code is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; either version 2, or (at your option)
 any later version.

 This code is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this code; see the file COPYING.  If not, write to
 the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.

 *EndCopyright:
 */

/////////////////////////////////////////////////////////////////////

#ifndef RCSSMONITOR_MAIN_WINDOW_H
#define RCSSMONITOR_MAIN_WINDOW_H

#include <QMainWindow>
#include <QString>
#include <QProcess>
#include <QPen>
#include <QBrush>
#include <QFont>
#include <QDialog>
#include <QListWidgetItem>
#include <QPushButton>
#include <QWidget>

#include "disp_holder.h"
#include "player_painter.h"
#include "config_dialog.h"

class ConfigDialog;
class FieldCanvas;
class LogPlayer;
class MonitorClient;
class PlayerTypeDialog;

class MonitorControl : public QObject
{
    Q_OBJECT
private:

    struct Param {
        int x_; //!< screen X coordinates
        int y_; //!< screen Y coordinates
        int body_radius_; //!< pixel body radius
        int kick_radius_; //!< pixel kick area radius
        int draw_radius_; //!< pixel main draw radius.
        //bool have_full_effort_; //!< flag to check effort value
        const rcss::rcg::PlayerT & player_;
        const rcss::rcg::BallT & ball_;
        const rcss::rcg::PlayerTypeT & player_type_;

        Param( const rcss::rcg::PlayerT & player,
               const rcss::rcg::BallT & ball,
               const rcss::rcg::ServerParamT & sparam,
               const rcss::rcg::PlayerTypeT & ptype );
    private:
        //! not used
        Param();
	};

    DispHolder M_disp_holder;

    MonitorClient * M_monitor_client;
    ConfigDialog * M_config_dialog;
    FieldCanvas * M_field_canvas;

public:

    MonitorControl();
    ~MonitorControl();

    void init();
private:

    void connectMonitorTo( const char * hostname );
private slots:


	//bool isConnected() const;
    void connectMonitor(); // connect to the host given by command lien or localhost
    void connectMonitorTo(); // open host input dialog
    void disconnectMonitor();
    void reconnectMonitor();

    void createConfigDialog();
    QColor getPLayerColor(const MonitorControl::Param & param);
    QString getPitchInfo();
	QString getFoulCardInfo();
	void updateBufferingLabel();

public slots:
	bool isConnected() const;
	QString getCommentaryLog();
	QString getLeftScore();
	QString getRightScore();	
	QString getLeftName();
	QString getRightName();
	QString getTeamLeftStats();
	QString getTeamRightStats();
	QString getPlayerLeftStats();
	QString getPlayerRightStats();
	QString getLeftInterception();
	QString getLeftFoul();
	QString getLeftTackle();
	QString getLeftGoal();
	QString getLeftYellowCard();
	QString getLeftRedCard();
	QString getRightInterception();
	QString getRightFoul();
	QString getRightTackle();
	QString getRightGoal();
	QString getRightYellowCard();
	QString getRightRedCard();
	void monitorStart();
    void update();
	bool getMatchParams();
	void sendPlayerMove(int player_id, double x, double y, int ang);
	void sendPlayerSubstitute(int player1_id, int player2_id);
    void sendTactics(QString teamName);
    void updateTeamTacticMask( int tactType, bool value );

signals:
    void tcpFullMessageReceived();
};

#endif
