#include "match.h"

Match::Match(QObject *parent) : QObject (parent)
{

}

int Match::id() const
{
    return m_id;
}

void Match::setId(int id)
{
    m_id = id;
}

QString Match::homeClubName() const
{
    return m_homeClubName;
}

void Match::setHomeClubName(const QString &homeClubName)
{
    m_homeClubName = homeClubName;
}

QString Match::awayClubName() const
{
    return m_awayClubName;
}

void Match::setAwayClubName(const QString &awayClubName)
{
    m_awayClubName = awayClubName;
}

int Match::homeClubId() const
{
    return m_homeClubId;
}

void Match::setHomeClubId(int homeClubId)
{
    m_homeClubId = homeClubId;
}

int Match::awayClubId() const
{
    return m_awayClubId;
}

void Match::setAwayClubId(int awayClubId)
{
    m_awayClubId = awayClubId;
}

QDate Match::date() const
{
    return m_date;
}

void Match::setDate(const QDate &date)
{
    m_date = date;
}

QTime Match::time() const
{
    return m_time;
}

void Match::setTime(const QTime &time)
{
    m_time = time;
}

