#include "livematchplayerinfo.h"

LiveMatchPlayerInfo::LiveMatchPlayerInfo(QObject *parent) : QObject(parent)
  , m_number(-1)
  , m_player_color("white")
  , m_player_position(QPoint(-1,-1))
  , m_body_angle(-1)
  , m_neck_angle(-1)
{

}

int LiveMatchPlayerInfo::number()
{
    return m_number;
}
void LiveMatchPlayerInfo::setPlayerNumber(int number)
{
    m_number = number;
    emit playerNumberChanged();
}

QString LiveMatchPlayerInfo::playerColor()
{
    return m_player_color;
}

void LiveMatchPlayerInfo::setPlayerColor(const QString& color)
{
    m_player_color = color;
    emit playerColorChanged();
}

QPoint LiveMatchPlayerInfo::playerPosition()
{
    return m_player_position;
}

void LiveMatchPlayerInfo::setPlayerPosition(const QPoint& point)
{
    m_player_position = point;
    emit playerPositionChanged();
}

int LiveMatchPlayerInfo::bodyAngle()
{
    return m_body_angle;
}

void LiveMatchPlayerInfo::setBodyAngle(int aBodyAngle)
{
    m_body_angle = aBodyAngle;
    emit bodyAngleChanged();
}

int LiveMatchPlayerInfo::neckAngle()
{
    return m_neck_angle;
}

void LiveMatchPlayerInfo::setNeckAngle(int aNeckAngle)
{
    m_neck_angle = aNeckAngle;
    emit neckAngleChanged();
}
