#include "notificationmodel.h"

NotificationModel::NotificationModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int NotificationModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return m_notifications.size();
}

QVariant NotificationModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_notifications.size())
        return QVariant();

    const auto& ntf = m_notifications.at(index.row());
    switch(role)
    {
    case IdRole:
        return QVariant(ntf->id());
    case DateRole:
        return QVariant(ntf->date());
    case StatusRole:
        return QVariant(ntf->status());
    case OwnerClubIdRole:
        return QVariant(ntf->ownerClubId());
    case OwnerClubNameRole:
        return QVariant(ntf->ownerClubName());
    case BiddingClubIdRole:
        return QVariant(ntf->biddingClubId());
    case BiddingClubNameRole:
        return QVariant(ntf->biddingClubName());
    }
    return QVariant();
}

QHash<int, QByteArray> NotificationModel::roleNames() const
{
    return {
        {IdRole, "id"},
        {StatusRole, "status"},
        {DateRole, "date"},
        {OwnerClubIdRole, "ownerClubId"},
        {OwnerClubNameRole, "ownerClubName"},
        {BiddingClubIdRole, "biddingClubId"},
        {BiddingClubNameRole, "biddingClubName"}
    };
}

void NotificationModel::setNotifications(QList<Notification *> notifications)
{
    beginResetModel();
    clear();
    beginInsertRows(QModelIndex(), 0, 0);
    m_notifications = notifications;
    for(auto& n: m_notifications) n->setParent(this);
    endInsertRows();
    endResetModel();
}

void NotificationModel::clear()
{
    if(m_notifications.isEmpty())
        return;

    beginRemoveRows(QModelIndex(), 0, m_notifications.count()-1);
    qDeleteAll(m_notifications.begin(), m_notifications.end());
    m_notifications.clear();
    endRemoveRows();
}

QList<Notification *> NotificationModel::notifications()
{
    return m_notifications;
}

