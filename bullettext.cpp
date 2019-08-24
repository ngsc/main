#include "bullettext.h"

BulletText::BulletText(QObject *parent) : QObject(parent)
{

}

int BulletText::id() const
{
    return m_id;
}

void BulletText::setId(int id)
{
    m_id = id;
}

int BulletText::userId() const
{
    return m_UserId;
}

void BulletText::setUserId(int userid)
{
    m_UserId = userid;
}

QString BulletText::comment() const
{
    return m_Comment;
}

void BulletText::setComment(QString &comment)
{
    m_Comment = comment;
}

QDateTime BulletText::dateTime() const
{
    return m_DateTime;
}

void BulletText::setDateTime(const QDateTime &dateTime)
{
    m_DateTime = dateTime;
}
