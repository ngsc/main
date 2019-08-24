#include "notification.h"

Notification::Notification(QObject *parent) : QObject(parent)
{

}

Notification::Notification(QObject *parent, int id, QDate date, int status, int oci, QString ocn, int bci, QString bcn) : QObject (parent),
    m_id(id), m_date(date), m_status(status), m_ownerClubId(oci), m_ownerClubName(ocn), m_biddingClubId(bci), m_biddingClubName(bcn)
{
}

int Notification::id() const
{
    return m_id;
}

void Notification::setId(int id)
{
    m_id = id;
}

QDate Notification::date() const
{
    return m_date;
}

void Notification::setDate(const QDate &date)
{
    m_date = date;
}

int Notification::status() const
{
    return m_status;
}

void Notification::setStatus(int status)
{
    m_status = status;
    emit statusChanged(status);
}

int Notification::ownerClubId() const
{
    return m_ownerClubId;
}

void Notification::setOwnerClubId(int ownerClubId)
{
    m_ownerClubId = ownerClubId;
}

QString Notification::ownerClubName() const
{
    return m_ownerClubName;
}

void Notification::setOwnerClubName(const QString &ownerClubName)
{
    m_ownerClubName = ownerClubName;
}

int Notification::biddingClubId() const
{
    return m_biddingClubId;
}

void Notification::setBiddingClubId(int biddingClubId)
{
    m_biddingClubId = biddingClubId;
}

QString Notification::biddingClubName() const
{
    return m_biddingClubName;
}

void Notification::setBiddingClubName(const QString &biddingClubName)
{
    m_biddingClubName = biddingClubName;
}

QString Notification::title() const
{
    return m_title;
}

void Notification::setTitle(const QString &title)
{
    m_title = title;
}

QString Notification::message() const
{
    return m_message;
}

void Notification::setMessage(const QString &message)
{
    m_message = message;
}
