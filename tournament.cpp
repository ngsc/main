#include "tournament.h"

Tournament::Tournament(QObject *parent) : QObject(parent)
{
    m_id = 0;
}

Tournament::Tournament(int id, const QString &name, const QDate &date) : m_id(id), m_name(name), m_startDate(date)
{
}

int Tournament::id() const
{
    return m_id;
}

void Tournament::setId(int id)
{
    m_id = id;
}

QString Tournament::name() const
{
    return m_name;
}

void Tournament::setName(const QString &name)
{
    m_name = name;
}

QDate Tournament::startDate() const
{
    return m_startDate;
}

void Tournament::setStartDate(const QDate &startDate)
{
    m_startDate = startDate;
}
