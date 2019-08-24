#include "simpleusermodel.h"
#include <QDebug>
SimpleUser::SimpleUser(QObject *parent) : QObject (parent)
{

}

int SimpleUser::userId() const
{
    return m_userId;
}

void SimpleUser::setUserId(int userId)
{
    m_userId = userId;
}

QString SimpleUser::username() const
{
    return m_username;
}

void SimpleUser::setUsername(const QString &username)
{
    m_username = username;
}

int SimpleUser::clubId() const
{
    return m_clubId;
}

void SimpleUser::setClubId(int clubId)
{
    m_clubId = clubId;
}

QString SimpleUser::clubName() const
{
    return m_clubName;
}

void SimpleUser::setClubName(const QString &clubName)
{
    m_clubName = clubName;
}

bool SimpleUser::online() const
{
    return m_online;
}

void SimpleUser::setOnline(bool online)
{
    if(online != m_online)
    {
        m_online = online;
        emit onlineChanged(online);
    }
}

QString SimpleUser::firstName() const
{
    return m_firstName;
}

void SimpleUser::setFirstName(const QString &firstName)
{
    m_firstName = firstName;
}

QString SimpleUser::lastName() const
{
    return m_lastName;
}

void SimpleUser::setLastName(const QString &lastName)
{
    m_lastName = lastName;
}


SimpleUserModel::SimpleUserModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int SimpleUserModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return m_users.size();
}

QVariant SimpleUserModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_users.size())
        return QVariant();

    const auto& user = m_users.at(index.row());

    switch (role)
    {
    case UserIdRole:
        return QVariant(user->userId());
    case UserNameRole:
        return QVariant(user->username());
    case UserFirstNameRole:
        return QVariant(user->firstName());
    case UserLastNameRole:
        return QVariant(user->lastName());
    case ClubIdRole:
        return QVariant(user->clubId());
    case ClubNameRole:
        return QVariant(user->clubName());
    case OnlineRole:
        return QVariant(user->online());
    }
    return QVariant();
}

QHash<int, QByteArray> SimpleUserModel::roleNames() const
{
    return {
        {UserIdRole, "userId"},
        {UserNameRole, "username"},
        {UserFirstNameRole, "firstName"},
        {UserLastNameRole, "lastName"},
        {ClubIdRole, "clubId"},
        {ClubNameRole, "clubName"},
        {OnlineRole, "online"}
    };
}

void SimpleUserModel::setUsers(QList<SimpleUser *> users, QString currentUsername)
{
//    qDebug() << "match users: " << users.count();
    if(users.isEmpty())
        return;

    beginResetModel();

    clear();
    beginInsertRows(QModelIndex(), 0, 0);
    for(auto& u: users) {
        if(u->username() == currentUsername)
            continue;
        m_users.append(u);
    }

    for(auto& u : m_users)
        u->setParent(this);
    endInsertRows();

    endResetModel();
}

void SimpleUserModel::clear()
{
    if(m_users.isEmpty())
        return;

    beginRemoveRows(QModelIndex(), 0, m_users.count()-1);
    qDeleteAll(m_users.begin(), m_users.end());
    m_users.clear();
    endRemoveRows();
}

