// -*-c++-*-

/*!
  \file main_window.cpp
  \brief main application window class Source File.
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

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include "monitor_client.h"
#include "options.h"
#include "MonitorController.h"
#include <string>
#include <iostream>
#include <fstream>
#include <cstring>
#include <cstdio>
#include "field_canvas.h"
#include "config_dialog.h"
#include "constants.h"
#include "qprocess.h"
#include "simplecrypt.h"
#include "qfile.h"
#include "apiconnection.h"
#include "club.h"
#include "livematchplayerinfo.h"
#include "livematchplayerinfolistmodel.h"

#include<sstream>
#include<iomanip>
#include <QPoint>

#include "icons\rcss.xpm"

static int tactic_mask = 0;
static rcss::rcg::Side M_side = rcss::rcg::LEFT;
inline
MonitorControl::Param::Param( const rcss::rcg::PlayerT & player,
                              const rcss::rcg::BallT & ball,
                              const rcss::rcg::ServerParamT & sparam,
                              const rcss::rcg::PlayerTypeT & ptype )
    : x_( Options::instance().screenX( player.x_ ) )
    , y_( Options::instance().screenY( player.y_ ) )
    , body_radius_( Options::instance().scale( ptype.player_size_ ) )
    , kick_radius_( Options::instance().scale( ptype.player_size_ + ptype.kickable_margin_ + sparam.ball_size_ ) )
      //, have_full_effort_( std::fabs( player.effort_ - ptype.effort_max_ ) < 1.0e-3 )
    , player_( player )
    , ball_( ball )
    , player_type_( ptype )
{

    if ( body_radius_ < 1 ) body_radius_ = 1;
    if ( kick_radius_ < 5 ) kick_radius_ = 5;

    draw_radius_ =  ( Options::instance().playerSize() >= 0.01
                      ? Options::instance().scale( Options::instance().playerSize() )
                      : kick_radius_ );
}

MonitorControl::MonitorControl()
    : M_monitor_client( nullptr )
    , M_config_dialog( static_cast< ConfigDialog * >( 0 ) )
    , M_field_canvas( static_cast< FieldCanvas * >( 0 ) )
    , m_background_process(new QProcess( this ) )
    , M_left_club( nullptr )
    , M_right_club( nullptr )
    , M_ball_position(QPointF(-1,-1))
    , m_Connected( false )
{
    m_LeftLiveMatchPlayerInfoModel = new LiveMatchPlayerInfoListModel(this);
    m_RightLiveMatchPlayerInfoModel = new LiveMatchPlayerInfoListModel(this);
}

/*-------------------------------------------------------------------*/
/*!

 */
MonitorControl::~MonitorControl()
{
    // dummy code
    delete M_monitor_client;
    delete M_field_canvas;
}

/*-------------------------------------------------------------------*/
/*!

 */
void
MonitorControl::init()
{
    M_field_canvas = new FieldCanvas( M_disp_holder );
	createConfigDialog();
	if ( Options::instance().connect() )
    {
        connectMonitor();
    }
}

LiveMatchPlayerInfoListModel* MonitorControl::getLeftLiveMatchPlayerInfoModel()
{
    return m_LeftLiveMatchPlayerInfoModel;
}

LiveMatchPlayerInfoListModel* MonitorControl::getRightLiveMatchPlayerInfoModel()
{
    return m_RightLiveMatchPlayerInfoModel;
}


void MonitorControl::startMatchServerCmd(QString token, int homeClubId, int awayClubId )
{
    using namespace ClientConstants;

    SimpleCrypt crypto(key); //some random number
    QFile file( "polo" );
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return;
    QString encrypted = file.readLine();

    QString decrypted = crypto.decryptToString(encrypted);

    // TODO: start server with different parameters;
    QString startServerCmd = "./startserver.sh 0 " + QString::number(homeClubId) + " " + QString::number(awayClubId) + " 0 0";
    QString cmd = "plink -ssh -no-antispoof " + user + "@" + serverHost +  " -pw " + decrypted + " \"pkill matchserver ; cd " + matchServerSrcPath + " ; "  + startServerCmd + "\"";
    m_background_process->start( cmd );

    connect(
        APIConnection::getInstance(), &APIConnection::getClubDetailsFinished,
        [this, homeClubId, awayClubId](Club *club)
            {
                if( club->id() == homeClubId )
                {
                    M_left_club = club;
                    emit leftClubChanged();
                }
                if( club->id() == awayClubId )
                {
                    M_right_club = club;
                    emit rightClubChanged();
                }
            }
    );
    APIConnection::getInstance()->getClubDetails(token, awayClubId);
    APIConnection::getInstance()->getClubDetails(token, homeClubId);

}

Club* MonitorControl::getLeftClub()
{
    return M_left_club;
}

Club* MonitorControl::getRightClub()
{
    return M_right_club;
}

void
MonitorControl::resetMatchData()
{
    M_ball_position = QPointF(-1,-1);
    emit ballPositionChanged();
    M_left_score = "";
    emit leftScoreChanged();
    M_right_score = "";
    emit rightClubChanged();
    m_LeftList.clear();
    m_RightList.clear();
    m_LeftLiveMatchPlayerInfoModel->clear();
    m_RightLiveMatchPlayerInfoModel->clear();
}

void
MonitorControl::setConnected(bool connected)
{
    if( m_Connected != connected)
    {
        m_Connected = connected;
        emit connectedChanged();
    }
}

void
MonitorControl::connectMonitorTo( const char * hostname )
{
	// std::ofstream os("C:/Users/Martun/Desktop/monitor_log.txt", std::ofstream::out | std::ofstream::app);
    if ( std::strlen( hostname ) == 0 )
    {
        std::cerr << "Empty host name. Connection failed." << std::endl;
        // os << "Empty host name. Connection failed." << std::endl;
        return;
    }
    std::cerr << "MonitorControl::connectMonitorTo before disconnectMonitor" << std::endl;
    disconnectMonitor();

    std::cerr << "Connect to [" << hostname << "] ..." << std::endl;
    // os << "Connect to [" << hostname << "] ..." << std::endl;

    M_monitor_client = new MonitorClient( this,
                                          M_disp_holder,
                                          hostname,
                                          Options::instance().serverPort(),
                                          Options::instance().clientVersion() );
    connect(
        M_monitor_client, &MonitorClient::tcpFullMessageReceived,
        [this]()
        {
            reloadLiveMatchInfo();
        }
    );
    connect(
        M_monitor_client, &MonitorClient::connectedChanged,
        [this]()
        {
            setConnected( M_monitor_client->getConnected() );
        }
    );
    // os << "Connected!" << std::endl;

    // reset all data
    M_disp_holder.clear();

    
    Options::instance().setServerHost( hostname );
    Options::instance().setMonitorClientMode( true );
    Options::instance().setBufferRecoverMode( true );

    //     M_set_live_mode_act->setEnabled( true );
	
	// sent when TCP connnected callback called in monitor_client.cpp
    // M_monitor_client->sendDispInit();
}

bool 
MonitorControl::isConnected() const
{
    if(M_monitor_client)
        return M_monitor_client->isConnected();
    else return false;
} 

void
MonitorControl::connectMonitor()
{
    std::cerr << "MonitorControl::connectMonitor() ..." << std::endl;
    connectMonitorTo();
}
/*-------------------------------------------------------------------*/
/*!

 */
void 
MonitorControl::monitorStart()
{
    std::cerr << "MonitorControl::monitorStart() ..." << std::endl;
    connectMonitor();
}
/*-------------------------------------------------------------------*/
/*!

 */
void 
MonitorControl::reloadLiveMatchInfo()
{
    if(!isConnected())
    {
        //monitorStart();
        return;
    }
    // if(!M_field_canvas)
    // {
    //     M_field_canvas = new FieldCanvas( M_disp_holder );
    // }
    // // std::ofstream os("C:/Users/Martun/Desktop/monitor_log.txt", std::ofstream::out | std::ofstream::app);
    // // os << "File: " << __FILE__ << ":" << __LINE__ << "\n";

    // M_field_canvas->show();
    

    DispConstPtr disp = M_disp_holder.currentDisp();

    if ( ! disp )
    {
        return;
    }
    const rcss::rcg::BallT & ball = disp->show_.ball_;
    M_ball_position = QPointF(Options::instance().screenX(ball.x_),
                                    Options::instance().screenY(ball.y_));
    emit ballPositionChanged();
    for ( int i = 0; i < rcss::rcg::MAX_PLAYER*2; ++i )
    {
        //drawAll( painter, disp->show_.player_[i], ball );
        const Options & opt = Options::instance();
        const Param param( disp->show_.player_[i],
                       ball,
                       M_disp_holder.serverParam(),
                       M_disp_holder.playerType( disp->show_.player_[i].type_ ) );
        int unum = disp->show_.player_[i].unum_;
        LiveMatchPlayerInfo* playerInfo = new LiveMatchPlayerInfo(this);
        playerInfo->setPlayerNumber( unum );
        playerInfo->setPlayerPosition(QPoint(param.x_, param.y_));
        playerInfo->setBodyAngle((int)param.player_.body_);
        playerInfo->setNeckAngle((int)param.player_.neck_);
        if(i >= 0 && i < rcss::rcg::MAX_PLAYER )
        {
            if (M_left_club)
            {
                playerInfo->setPlayerColor(M_left_club->background1Value());
            }
            if(m_LeftLiveMatchPlayerInfoModel && m_LeftLiveMatchPlayerInfoModel->count() == 0)
            {
                m_LeftList.push_back(playerInfo);
            }
            else
            {
               m_LeftLiveMatchPlayerInfoModel->modifyItem( playerInfo, i);
               playerInfo->setParent(nullptr);
               delete playerInfo;
            }

        }
        else if( i >= rcss::rcg::MAX_PLAYER && i < rcss::rcg::MAX_PLAYER * 2 )
        {
            if(M_right_club)
            {
                playerInfo->setPlayerColor(M_right_club->background1Value());
            }
            if(m_RightLiveMatchPlayerInfoModel && m_RightLiveMatchPlayerInfoModel->count() == 0)
            {
                m_RightList.push_back(playerInfo);
            }
            else
            {
                m_RightLiveMatchPlayerInfoModel->modifyItem( playerInfo, i - 11 );
                playerInfo->setParent(nullptr);
                delete playerInfo;
            }
        }
    }
    if( m_LeftLiveMatchPlayerInfoModel->count() == 0 )
    {
        m_LeftLiveMatchPlayerInfoModel->setLiveMatchPlayerInfo(m_LeftList);
    }
    if( m_RightLiveMatchPlayerInfoModel->count() == 0 )
    {
        m_RightLiveMatchPlayerInfoModel->setLiveMatchPlayerInfo(m_RightList);
    }

    M_pitchInfo = extractPitchInfo();
    emit pitchInfoChanged();
    M_foulCardInfo = extractFoulCardInfo();
    emit foulCardInfoChanged();
    M_left_score = QVariant(disp->team_[0].score_).toString();
    emit leftScoreChanged();
    M_right_score = QVariant(disp->team_[1].score_).toString();
    emit rightScoreChanged();
    setConnected(true);
    emit liveMatchDataChanged();
}
/*-------------------------------------------------------------------*/
/*!

 */
void
MonitorControl::connectMonitorTo()
{
    std::cerr << "MonitorControl::connectMonitorTo() ..." << std::endl;
    connectMonitorTo(ClientConstants::serverHost.toUtf8().constData());
}

/*-------------------------------------------------------------------*/
/*!

 */
void
MonitorControl::disconnectMonitor()
{
    if ( M_monitor_client )
    {
        std::cerr << "disconnectMonitor ..." << std::endl;
        resetMatchData();
        M_monitor_client->disconnect();

        delete M_monitor_client;
        M_monitor_client = static_cast< MonitorClient * >( 0 );

        //
        // quit application if auto_quit_mode is on
        //
        
    }

    Options::instance().setMonitorClientMode( false );
    Options::instance().setBufferRecoverMode( false );

    //     M_set_live_mode_act->setEnabled( false );
}

/*-------------------------------------------------------------------*/
/*!

 */
void
MonitorControl::reconnectMonitor()
{
    if ( M_monitor_client )
    {
        disconnectMonitor();
        std::cerr << "Trying to reconnect ..." << std::endl;
    }
    else
    {
        connectMonitor();
    }
}

void
MonitorControl::updateBufferingLabel()
{
    static int s_last_value = -1;

    int current_index = M_disp_holder.currentIndex() == DispHolder::INVALID_INDEX
        ? 0
        : M_disp_holder.currentIndex();
    
    int current_cache = M_disp_holder.dispCont().size() - current_index;
    current_cache = std::max( 0, current_cache - 1 );
    if ( s_last_value != current_cache )
    {
        s_last_value = current_cache;
    }
}

QColor
MonitorControl::getPLayerColor(const MonitorControl::Param & param)
{

    // std::ofstream os("C:/Users/Martun/Desktop/monitor_log_player_color.txt", std::ofstream::out | std::ofstream::app);
    const Options & opt = Options::instance();


    switch ( param.player_.side_ ) {
    case 'l':
        // os << "l";
        if ( param.player_.isGoalie() )
        {
            // os << "g";
            return Options::LEFT_GOALIE_COLOR;
        }
        else
        {
            // os << "ng";
            return Options::LEFT_TEAM_COLOR;
        }
        // os << "\n";

        break;
    case 'r':
        // os << "r";
        if ( param.player_.isGoalie() )
        {
            // os << "g";
            return Options::RIGHT_GOALIE_COLOR;
        }
        else
        {
            // os << "ng";        
            return Options::RIGHT_TEAM_COLOR;
        }
        // os << "\n";
        break;
    default:
        break;
    }


    //decide status color
    if ( ! param.player_.isAlive() )
    {
        return Qt::black;
    }
    if ( param.player_.isKicking() )
    {
        // os << "kick";
        return Options::KICK_COLOR;
    }
    if ( param.player_.isCollidedPlayer() )
    {
        // os << "playerCollide";
        return Options::PLAYER_COLLIDE_COLOR;
    }
}

void
MonitorControl::createConfigDialog()
{
    if ( M_config_dialog )
    {
        return;
    }

    M_config_dialog = new ConfigDialog( nullptr, M_disp_holder );

    M_config_dialog->hide();
}


QString
MonitorControl::extractPitchInfo()
{
    static const std::string s_playmode_strings[] = PLAYMODE_STRINGS;

    const Options & opt = Options::instance();

    if ( ! opt.showScoreBoard() )
    {
        return NULL;
    }

    DispConstPtr disp = M_disp_holder.currentDisp();

    if ( ! disp )
    {
        return NULL;
    }

    const int current_time = disp->show_.time_;

    const rcss::rcg::TeamT & team_l = disp->team_[0];
    const rcss::rcg::TeamT & team_r = disp->team_[1];

    const rcss::rcg::PlayMode pmode = disp->pmode_;

    const std::vector< std::pair< int, rcss::rcg::PlayMode > > & pen_scores_l = M_disp_holder.penaltyScoresLeft();
    const std::vector< std::pair< int, rcss::rcg::PlayMode > > & pen_scores_r = M_disp_holder.penaltyScoresRight();

    bool show_pen_score = true;

    if ( pen_scores_l.empty()
         && pen_scores_r.empty() )
    {
        show_pen_score = false;
    }
    else if ( ( ! pen_scores_l.empty()
                && current_time < pen_scores_l.front().first )
              && ( ! pen_scores_r.empty()
                   && current_time < pen_scores_r.front().first )
              && pmode != rcss::rcg::PM_PenaltySetup_Left
              && pmode != rcss::rcg::PM_PenaltySetup_Right
              && pmode != rcss::rcg::PM_PenaltyReady_Left
              && pmode != rcss::rcg::PM_PenaltyReady_Right
              && pmode != rcss::rcg::PM_PenaltyTaken_Left
              && pmode != rcss::rcg::PM_PenaltyTaken_Right )
    {
        show_pen_score = false;
    }


    QString main_buf;
    /*%-10s*/
    std::ostringstream s_current_time;
    s_current_time << std::setw(2) << std::setfill('0') << current_time / 600 
                    << ":" << std::setw(2) << ((current_time % 600) / 10);
    std::ofstream os ("time.txt");
    os << s_current_time.str() << "\n";
    
    if ( ! show_pen_score )
    {
        main_buf.sprintf( " %10s %d:%d %2s %6s %10s ",
                          ( team_l.name_.empty() || team_l.name_ == "null" )
                          ? ""
                          : team_l.name_.c_str(),
                          team_l.score_,
                          team_r.score_,
                          ( team_r.name_.empty() || team_r.name_ == "null" )
                          ? ""
                          : team_r.name_.c_str(),
                          //s_playmode_strings[pmode].c_str(),
                          s_current_time.str().c_str(),
                          disp->commentary_.c_str() );
    }
    else
    {
        std::string left_penalty; left_penalty.reserve( 10 );
        std::string right_penalty; right_penalty.reserve( 10 );

        for ( std::vector< std::pair< int, rcss::rcg::PlayMode > >::const_iterator it = pen_scores_l.begin();
              it != pen_scores_l.end();
              ++it )
        {
            if ( it->first > current_time ) break;

            if ( it->second == rcss::rcg::PM_PenaltyScore_Left
                 || it->second == rcss::rcg::PM_PenaltyScore_Right )
            {
                left_penalty += 'o';
            }
            else if ( it->second == rcss::rcg::PM_PenaltyMiss_Left
                      || it->second == rcss::rcg::PM_PenaltyMiss_Right )
            {
                left_penalty += 'x';
            }
        }

        for ( std::vector< std::pair< int, rcss::rcg::PlayMode > >::const_iterator it = pen_scores_r.begin();
              it != pen_scores_r.end();
              ++it )
        {
            if ( it->first > current_time ) break;

            if ( it->second == rcss::rcg::PM_PenaltyScore_Left
                 || it->second == rcss::rcg::PM_PenaltyScore_Right )
            {
                right_penalty += 'o';
            }
            else if ( it->second == rcss::rcg::PM_PenaltyMiss_Left
                      || it->second == rcss::rcg::PM_PenaltyMiss_Right )
            {
                right_penalty += 'x';
            }
        }

        main_buf.sprintf( " %10s %d:%d |%-5s:%-5s| %-10s %19s %6d",
                          ( team_l.name_.empty() || team_l.name_ == "null" )
                          ? ""
                          : team_l.name_.c_str(),
                          team_l.score_, team_r.score_,
                          left_penalty.c_str(),
                          right_penalty.c_str(),
                          ( team_r.name_.empty() || team_r.name_ == "null" )
                          ? ""
                          : team_r.name_.c_str(),
                          s_playmode_strings[pmode].c_str(),
                          current_time );
    }

    return main_buf;
}
void 
MonitorControl::sendPlayerMove(int player_id, double x, double y, int ang) {
	std::cout << "Moving " << player_id << "\n";
	M_monitor_client->sendMove(M_side, player_id, x, y, ang);	
}

void 
MonitorControl::sendPlayerSubstitute(int player1_id, int player2_id) {
	DispConstPtr disp = M_disp_holder.currentDisp();
	if (!disp)
	{
		return;
	}
	M_monitor_client->sencChangePlayerType(disp->team_[M_side == rcss::rcg::RIGHT].name_, player1_id, player2_id);
}

QString
MonitorControl::getLeftScore() {
    return M_left_score;
}


QString
MonitorControl::getRightScore() {
    return M_right_score;
}

QPointF
MonitorControl::getBallPosition(){
    return M_ball_position;
}

QString
MonitorControl::getPitchInfo()
{
    return M_pitchInfo;
}

QString
MonitorControl::getFoulCardInfo()
{
    return M_foulCardInfo;
}

bool
MonitorControl::getConnected()
{
    return m_Connected;
}

QString
MonitorControl::extractFoulCardInfo() {
	const std::pair<char, std::pair<char, int> > foul_card = M_disp_holder.FoulCard();
	QString foul_card_info;
	std::stringstream foul_card_sstream;
	if (foul_card.first == 'y') {
		foul_card_sstream << "Yellow Card";
	}
	else if (foul_card.first == 'r') {
		foul_card_sstream << "Red Card";
	}
	else {
		return "";
	}
	foul_card_sstream << " issued against ";
	if (foul_card.second.first == 'l') {
		foul_card_sstream << "Left Team";
	}
	else if (foul_card.second.first == 'r') {
		foul_card_sstream << "Right Team";
	}
	else {
		return "";
	}
	std::cout <<"final str: "<< foul_card_sstream.str();
	foul_card_sstream << " Player " << foul_card.second.second;
	foul_card_info.sprintf(foul_card_sstream.str().c_str());
	return foul_card_info;
}

bool
MonitorControl::getMatchParams() {
    //PHP_GET: update and gets all parameters from server - match_id and side (left/right) of team
    int port_no = 6000;
    int match_id = 0;
    //PHP_GET:send value of tactic_mask to server
    //PHP_GET:update values of match_id and "M_side" here, use blocking get call so that function does not return before parameters are initalized
    //match_id = //get from server
    //M_side = //get from server
    //IF cannot get - return false
    port_no = 6000 + (10 * match_id);
    //PHP_GET get tcp port number form server
    Options::instance().setServerPort(54002);
	return true;
}
QString
MonitorControl::getCommentaryLog() {
	DispConstPtr disp = M_disp_holder.currentDisp();
	if (!disp)
	{
		return NULL;
	}
	return QString::fromStdString(disp->commentary_log_);
}

void
MonitorControl::sendTactics(QString teamName)
{
    if( isConnected() )
    {
        M_monitor_client->sendTactic(teamName.toUtf8().data(), tactic_mask);
    }
}
QString MonitorControl::getTeamLeftStats()
{
	DispConstPtr disp = M_disp_holder.currentDisp();
	if (!disp)
	{
		return NULL;
	}
	return QString::fromStdString(disp->statistic_.team_left_stats_);
}
QString MonitorControl::getTeamRightStats()
{
	DispConstPtr disp = M_disp_holder.currentDisp();
	if (!disp)
	{
		return NULL;
	}
	return QString::fromStdString(disp->statistic_.team_right_stats_);
}
QString MonitorControl::getPlayerLeftStats()
{
	DispConstPtr disp = M_disp_holder.currentDisp();
	if (!disp)
	{
		return NULL;
	}
	return QString::fromStdString(disp->statistic_.player_left_stats_);
}
QString MonitorControl::getPlayerRightStats()
{
	DispConstPtr disp = M_disp_holder.currentDisp();
	if (!disp)
	{
		return NULL;
	}
	return QString::fromStdString(disp->statistic_.player_right_stats_);
}
QString MonitorControl::getLeftInterception()
{
	DispConstPtr disp = M_disp_holder.currentDisp();
	if (!disp)
	{
		return NULL;
	}
	return QString::fromStdString(disp->statistic_.left_interception_);
}
QString MonitorControl::getLeftFoul()
{
	DispConstPtr disp = M_disp_holder.currentDisp();
	if (!disp)
	{
		return NULL;
	}
	return QString::fromStdString(disp->statistic_.left_foul_);
}
QString MonitorControl::getLeftTackle()
{
	DispConstPtr disp = M_disp_holder.currentDisp();
	if (!disp)
	{
		return NULL;
	}
	return QString::fromStdString(disp->statistic_.left_tackle_);
}
QString MonitorControl::getLeftGoal()
{
	DispConstPtr disp = M_disp_holder.currentDisp();
	if (!disp)
	{
		return NULL;
	}
	return QString::fromStdString(disp->statistic_.left_goal_);
}
QString MonitorControl::getLeftYellowCard()
{
	DispConstPtr disp = M_disp_holder.currentDisp();
	if (!disp)
	{
		return NULL;
	}
	return QString::fromStdString(disp->statistic_.left_yellow_card_);
}
QString MonitorControl::getLeftRedCard()
{
	DispConstPtr disp = M_disp_holder.currentDisp();
	if (!disp)
	{
		return NULL;
	}
	return QString::fromStdString(disp->statistic_.left_red_card_);
}
QString MonitorControl::getRightInterception()
{
	DispConstPtr disp = M_disp_holder.currentDisp();
	if (!disp)
	{
		return NULL;
	}
	return QString::fromStdString(disp->statistic_.right_interception_);
}
QString MonitorControl::getRightFoul()
{
	DispConstPtr disp = M_disp_holder.currentDisp();
	if (!disp)
	{
		return NULL;
	}
	return QString::fromStdString(disp->statistic_.right_foul_);
}
QString MonitorControl::getRightTackle()
{
	DispConstPtr disp = M_disp_holder.currentDisp();
	if (!disp)
	{
		return NULL;
	}
	return QString::fromStdString(disp->statistic_.right_tackle_);
}
QString MonitorControl::getRightGoal()
{
	DispConstPtr disp = M_disp_holder.currentDisp();
	if (!disp)
	{
		return NULL;
	}
	return QString::fromStdString(disp->statistic_.right_goal_);
}
QString MonitorControl::getRightYellowCard()
{
	DispConstPtr disp = M_disp_holder.currentDisp();
	if (!disp)
	{
		return NULL;
	}
	return QString::fromStdString(disp->statistic_.right_yellow_card_);
}
QString MonitorControl::getRightRedCard()
{
	DispConstPtr disp = M_disp_holder.currentDisp();
	if (!disp)
	{
		return NULL;
	}
	return QString::fromStdString(disp->statistic_.right_red_card_);
}

void MonitorControl::updateTeamTacticMask(int tacticType, bool value )
{
    if ( value )
    {
        tactic_mask |= tacticType;
    }
    else
    {
        tactic_mask &= ~tacticType;
    }
}
