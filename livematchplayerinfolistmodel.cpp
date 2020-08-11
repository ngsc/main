#include "livematchplayerinfolistmodel.h"

#include <iostream>

LiveMatchPlayerInfoListModel::LiveMatchPlayerInfoListModel(QObject* parent)
    : QAbstractListModel(parent)
{
    m_count = 0;
}
// Basic functionality:
int LiveMatchPlayerInfoListModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_Players.size();
}

QVariant LiveMatchPlayerInfoListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_Players.size())
        return QVariant();

    auto& liveMatchPlayerInfo = m_Players.at(index.row());
    switch (role)
    {
        case NumberRole:
            return QVariant(liveMatchPlayerInfo->number());
        case PlayerColorRole:
            return QVariant(liveMatchPlayerInfo->playerColor());
        case PlayerPositionRole:
            return QVariant(liveMatchPlayerInfo->playerPosition());
        case BodyAngleRole:
            return QVariant(liveMatchPlayerInfo->bodyAngle());
        case NeckAngleRole:
            return QVariant(liveMatchPlayerInfo->neckAngle());
    }
    return QVariant();
}

QHash<int, QByteArray> LiveMatchPlayerInfoListModel::roleNames() const
{
    return {
        {NumberRole, "number"},
        {PlayerColorRole, "playerColor"},
        {PlayerPositionRole, "playerPosition"},
        {BodyAngleRole, "bodyAngle"},
        {NeckAngleRole, "neckAngle"}
    };
}

int LiveMatchPlayerInfoListModel::count() const
{
    return m_count;
}
void LiveMatchPlayerInfoListModel::setCount(int count)
{
    m_count = count;
}

QList<LiveMatchPlayerInfo *> LiveMatchPlayerInfoListModel::liveMatchPlayerInfo() const
{
    return m_Players;
}
void LiveMatchPlayerInfoListModel::setLiveMatchPlayerInfo(QList<LiveMatchPlayerInfo*> liveMatchPlayers)
{
    beginResetModel();
    clear();
    beginInsertRows(QModelIndex(), 0, liveMatchPlayers.size()-1);
    m_Players = liveMatchPlayers;
    for(auto& p : m_Players) p->setParent(this);
    endInsertRows();
    endResetModel();
    setCount(m_Players.size());

}
void LiveMatchPlayerInfoListModel::clear()
{
    if(m_Players.isEmpty())
        return;

    beginRemoveRows(QModelIndex(), 0, m_Players.count()-1);
    //qDeleteAll(m_Players.begin(), m_Players.end());
    m_Players.clear();
    endRemoveRows();
    setCount(0);
}

void LiveMatchPlayerInfoListModel::modifyItem(LiveMatchPlayerInfo* newValue, int i)
{
    if( newValue && m_Players.count() > i )
    {
        m_Players[i]->setPlayerNumber(newValue->number());
        m_Players[i]->setPlayerColor(newValue->playerColor());
        m_Players[i]->setPlayerPosition(newValue->playerPosition());
        m_Players[i]->setBodyAngle(newValue->bodyAngle());
        m_Players[i]->setNeckAngle(newValue->neckAngle());
        QModelIndex index = this->index(i,0);
        emit dataChanged(index, index);
    }
    else
    {
        if (m_Players.count() <= i)
        {
            std::cerr << "Invalid index for provided: " << i << " ,m_Players.size: " << m_Players.size() << "count: "<< m_count << std::endl;
        }
    }
}

LiveMatchPlayerInfo* LiveMatchPlayerInfoListModel::liveMatchPlayerInfo(int number)
{
    auto itr = std::find_if(m_Players.begin(), m_Players.end(), [=](LiveMatchPlayerInfo* liveMatchPlayerInfo) {
        return (liveMatchPlayerInfo->number() == number);
    });

    if(itr != m_Players.end())
        return *itr;
    return nullptr;
}
LiveMatchPlayerInfo* LiveMatchPlayerInfoListModel::at(int index)
{
    if(index <0 || index > m_Players.size())
        return nullptr;
    return m_Players.at(index);
}
