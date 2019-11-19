#include "historybrief.h"
#include <QDebug>


UserHistory::UserHistory(QObject *parent): QObject (parent)
{

}

int UserHistory::userId() const
{
    return m_userId;
}

void UserHistory::setUserId(int userId)
{
    m_userId = userId;
}

int UserHistory::userIndex() const
{
    return m_userIndex;
}

void UserHistory::setUserIndex(int userIndex)
{
    m_userIndex = userIndex;
}

QString UserHistory::username() const
{
    return m_username;
}

void UserHistory::setUsername(const QString &username)
{
    m_username = username;
}

int UserHistory::clubId() const
{
    return m_clubId;
}

void UserHistory::setClubId(int clubId)
{
    m_clubId = clubId;
}

QString UserHistory::clubName() const
{
    return m_clubName;
}

void UserHistory::setClubName(const QString &clubName)
{
    m_clubName = clubName;
}

bool UserHistory::online() const
{
    return m_online;
}

void UserHistory::setOnline(bool online)
{
    if(online != m_online)
    {
        m_online = online;
        emit onlineChanged(online);
    }
}

bool UserHistory::isVisible() const
{
    return m_IsVisible;
}

void UserHistory::setVisible(bool check)
{
    m_IsVisible = check;
}

QString UserHistory::firstName() const
{
    return m_firstName;
}

void UserHistory::setFirstName(const QString &firstName)
{
    m_firstName = firstName;
}

QString UserHistory::lastName() const
{
    return m_lastName;
}

void UserHistory::setLastName(const QString &lastName)
{
    m_lastName = lastName;
}

HistoryBrief::HistoryBrief(QObject *parent)
    : QAbstractListModel(parent)
//    , m_count(0)
{

}

int HistoryBrief::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    // return this->count();
    return m_users.size();
}

QVariant HistoryBrief::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_users.size())
        return QVariant();

    auto& user = m_users.at(index.row());

    switch (role)
    {
    case HistoryIndex:
        return QVariant(user->userIndex());
    case IdRole:
        return QVariant(user->userId ());
    case UserNameRole:
        return QVariant(user->username());
    case ClubNameRole:
        return QVariant(user->clubName());
    case FirstNameRole:
        return QVariant(user->firstName());
    case LastNameRole:
        return QVariant(user->lastName());
    case OnlineRole :
        return QVariant(user->online());
    case IsVisible :
        return QVariant(user->isVisible());
    }
    return QVariant();
}

bool HistoryBrief::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_users.size())
        return false;

    auto& user = m_users.at(index.row());
    switch(role)
    {
    case IdRole:
        user->setUserId(value.toString().toInt ());
        break;
    case UserNameRole:
        user->setUsername(value.toString());
        break;
    case ClubNameRole:
        user->setClubName(value.toString());
        break;
    case FirstNameRole:
        user->setFirstName(value.toString());
        break;
    case LastNameRole:
        user->setLastName(value.toString());
        break;
    case OnlineRole:
        user->setOnline(value.toBool());
        break;
    case IsVisible :
        user->setVisible(value.toBool());
    }

    emit dataChanged(index, index, { role } );
    return true;
}

QHash<int, QByteArray> HistoryBrief::roleNames() const
{
    return {
        {HistoryIndex, "historyIndex"},
        {IdRole, "id"},
        {UserNameRole, "userName"},
        {ClubNameRole, "clubName"},
        {FirstNameRole, "firstName"},
        {LastNameRole,"lastName"},
        {OnlineRole, "onLine"},
        {IsVisible, "isVisible"},
    };
}

int HistoryBrief::count() const
{
    return m_count;
}

void HistoryBrief::setCount(int count)
{
    m_count = count;
}

QList<UserHistory *> HistoryBrief::userHistory() const
{
    return m_users;
}

void HistoryBrief::setUserHistory(QList<UserHistory *> userHistory, QString currentUsername)
{
    beginResetModel();
    clear();
    beginInsertRows(QModelIndex(), 0, 0);
    qDebug()<<userHistory.count();
    for(int i = 0 ; i < userHistory.count () ; i++){
        if(userHistory.at(i)->username()==currentUsername){
            continue;
        }
        auto user = this->userHistory (userHistory.at (i)->userId());
        if(user){
            if(user->online()!=userHistory.at(i)->online()){
                userHistory.at (i)->setUserIndex(m_users.count());
                userHistory.at (i)->setParent(this);
                userHistory.at(i)->setVisible(false);
            }else {
                userHistory.at(i)->setVisible(true);
            }
        }else{
            m_users.append(userHistory.at (i));
            userHistory.at (i)->setUserIndex(m_users.count());
            userHistory.at (i)->setParent(this);
            userHistory.at(i)->setVisible(false);
        }
    }
    qDebug()<<rowCount();
    qDebug()<<m_users.count();
    endInsertRows();
    endResetModel();
    setCount(m_users.count());
}

void HistoryBrief::clear()
{
    if(m_users.isEmpty())
        return;

    beginRemoveRows(QModelIndex(), 0, m_users.count()-1);
    m_users.clear();
    endRemoveRows();
}

UserHistory *HistoryBrief::userHistory(int id)
{
    auto itr = std::find_if(m_users.begin(), m_users.end(), [=](const UserHistory* user) {
        return user->userId() == id;
    });

    if(itr != m_users.end())
        return *itr;
    return nullptr;
}

UserHistory *HistoryBrief::at(int index)
{
    if(index <0 || index > m_users.size())
        return nullptr;
    return m_users.at(index);
}
