#include "invitation.h"

Invitation::Invitation(QObject *parent) : QObject(parent)
{

}

int Invitation::id() const
{
    return m_id;
}

void Invitation::setId(int id)
{
    m_id = id;
}

QString Invitation::homeClubName() const
{
    return m_homeClubName;
}

void Invitation::setHomeClubName(const QString &homeClubName)
{
    m_homeClubName = homeClubName;
}

QString Invitation::awayClubName() const
{
    return m_awayClubName;
}

void Invitation::setAwayClubName(const QString &awayClubName)
{
    m_awayClubName = awayClubName;
}

int Invitation::homeClubId() const
{
    return m_homeClubId;
}

void Invitation::setHomeClubId(int homeClubId)
{
    m_homeClubId = homeClubId;
}

int Invitation::awayClubId() const
{
    return m_awayClubId;
}

void Invitation::setAwayClubId(int awayClubId)
{
    m_awayClubId = awayClubId;
}

QDateTime Invitation::date() const
{
    return m_date;
}

void Invitation::setDate(const QDateTime &date)
{
    m_date = date;
}

bool Invitation::active() const
{
    return m_active;
}

void Invitation::setActive(bool active)
{
    m_active = active;
    emit activeChanged(active);
}

int Invitation::homeUserId() const
{
    return m_homeUserId;
}

void Invitation::setHomeUserId(int homeUserId)
{
    m_homeUserId = homeUserId;
}

int Invitation::awayUserId() const
{
    return m_awayUserId;
}

void Invitation::setAwayUserId(int awayUserId)
{
    m_awayUserId = awayUserId;
}
