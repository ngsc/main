#include "teamtactic.h"

TeamTactic::TeamTactic( QObject *parent )
    : QObject( parent )
{
}

void TeamTactic::setSelected( bool selected )
{
    m_selected = selected;
    Q_EMIT selectedChanged();
}

bool TeamTactic::getSelected()
{
    return m_selected;
}

void TeamTactic::setType(int type)
{
    m_tacticType = type;
    Q_EMIT typeChanged();
}

int TeamTactic::getType()
{
    return m_tacticType;
}

void TeamTactic::setName( QString name )
{
    m_tacticName = name;
    Q_EMIT nameChanged();
}
QString TeamTactic::getName()
{
    return m_tacticName;
}
