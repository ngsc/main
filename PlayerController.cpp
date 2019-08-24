#include <PlayerController.h>
#include <options.h>
#include <cstdlib>
#include <fstream>
QVector<PlayerControl::PlayerProperties> PlayerControl::m_players(22);
QVector<double> PlayerControl::m_ball_position;
QColor PlayerControl::m_ball_color;
QString PlayerControl::m_pitch_info;
QString PlayerControl::m_foul_card_info;

QColor PlayerControl::getPlayerColor(int player_id)
{
	//std::ofstream os("C:/Users/Martun/Desktop/monitor_log.txt", std::ofstream::out | std::ofstream::app);
    //os << "File: " << __FILE__ << ":" << __LINE__ << "\n";
    return m_players[player_id].m_color;
}

void PlayerControl::setPlayerColor(int player_id, int team_id, const QColor & color)
{
    //std::ofstream os("C:/Users/Martun/Desktop/monitor_log.txt", std::ofstream::out | std::ofstream::app);
    //os << "File: " << __FILE__ << ":" << __LINE__ << "\n";
    m_players[player_id + team_id*11].m_color = color;
}

QVector<double> PlayerControl::getPlayerPoint(int player_id)
{
    //std::ofstream os("C:/Users/Martun/Desktop/monitor_log.txt", std::ofstream::out | std::ofstream::app);
    //os << "File: " << __FILE__ << ":" << __LINE__ << "\n";
    return m_players[player_id].m_point;
}

void PlayerControl::setPlayerPoint(int player_id, int team_id, double x, double y)
{
    //std::ofstream os("C:/Users/Martun/Desktop/monitor_log.txt", std::ofstream::out | std::ofstream::app);
    //os << "File: " << __FILE__ << ":" << __LINE__ << "\n";
    m_players[player_id + team_id*11].m_point = {x, y};
}

int PlayerControl::getPlayerNeckAngle(int player_id)
{
    //std::ofstream os("C:/Users/Martun/Desktop/monitor_log.txt", std::ofstream::out | std::ofstream::app);
    //os << "File: " << __FILE__ << ":" << __LINE__ << "\n";
    return m_players[player_id].m_neck_angle;
}

void PlayerControl::setPlayerNeckAngle(int player_id, int team_id, int neck_angle)
{
    //std::ofstream os("C:/Users/Martun/Desktop/monitor_log.txt", std::ofstream::out | std::ofstream::app);
    //os << "File: " << __FILE__ << ":" << __LINE__ << "\n";
    m_players[player_id + team_id*11].m_neck_angle = neck_angle;
}

QVector<double> PlayerControl::getBallPoint()
{
    return m_ball_position;
}

void PlayerControl::setBallPoint(double x, double y)
{
    m_ball_position = {x, y};
}

QString PlayerControl::getPitchInfo()
{
    return m_pitch_info;
}

void PlayerControl::setPitchInfo(QString pitch_info)
{
    m_pitch_info = pitch_info;
}

QString PlayerControl::getFoulCardInfo()
{
	return m_foul_card_info;
}

void PlayerControl::setFoulCardInfo(QString foul_card_info)
{
	m_foul_card_info = foul_card_info;
}


