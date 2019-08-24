#include "playercommentsmodel.h"
#include <QDebug>

playerCommentsModel::playerCommentsModel(QObject *parent)
{

}

int playerCommentsModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_PlayerComment.size ();
}

QVariant playerCommentsModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_PlayerComment.size())
        return QVariant();

    auto& playerComment = m_PlayerComment.at(index.row());

    switch (role)
    {
    case IdRole:
        return QVariant(playerComment->id());
    case PlayerId:
        return QVariant(playerComment->playerId());
    case MessageRateRole:
        return QVariant(playerComment->messageRate());
    case DateTimeRole:
        return QVariant(playerComment->dateTime().toString("yyy-MM-dd hh:mm:ss"));
    case MessageRole:
        return QVariant(playerComment->message ());
    }
    return QVariant();
}

bool playerCommentsModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if(index.isValid() || index.row() < 0 || index.row() >= m_PlayerComment.size())
        return false;

    auto& playerComment = m_PlayerComment.at(index.row());
    switch(role)
    {
    case MessageRateRole:
        playerComment->setmessageRate(value.toString().toInt ());
        break;
    case MessageRole:
        playerComment->setMessage (value.toString());
        break;
    }

    emit dataChanged(index, index, { role } );
    return true;
}

QHash<int, QByteArray> playerCommentsModel::roleNames() const
{
    return {
        {IdRole, "id"},
        {PlayerId,"playerId"},
        {MessageRateRole, "messageRate"},
        {DateTimeRole, "dateTime"},
        {MessageRole, "message"}
    };
}

int playerCommentsModel::count() const
{
    return m_count;
}

void playerCommentsModel::setCount(int count)
{
    m_count = count;
}

QList<PlayerComment *> playerCommentsModel::playerComment() const
{
    return m_PlayerComment;
}

void playerCommentsModel::setplayerComment(QList<PlayerComment *> playerComment)
{
    beginResetModel();
    clear();
    beginInsertRows(QModelIndex(), 0, 0);

    m_PlayerComment = playerComment;
    for(auto& p : m_PlayerComment) p->setParent(this);

    endInsertRows();
    endResetModel();
    setCount(m_PlayerComment.count());
}

void playerCommentsModel::clear()
{
    if(m_PlayerComment.isEmpty())
        return;

    beginRemoveRows(QModelIndex(), 0, m_PlayerComment.count()-1);
    m_PlayerComment.clear();
    endRemoveRows();
}

PlayerComment *playerCommentsModel::playerComment(int id)
{
    auto itr = std::find_if(m_PlayerComment.begin(), m_PlayerComment.end(), [=](const PlayerComment* playerComment) {
        return playerComment->id() == id;
    });

    if(itr != m_PlayerComment.end())
        return *itr;
    return nullptr;
}

PlayerComment *playerCommentsModel::at(int index)
{
    if(index <0 || index > m_PlayerComment.size())
        return nullptr;
    return m_PlayerComment.at(index);
}
