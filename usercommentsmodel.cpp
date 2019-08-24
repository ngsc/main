#include "usercommentsmodel.h"
#include <QDebug>

UserComment::UserComment(QObject *parent)
{

}

void UserComment::setId(int id)
{
    m_id = id;
}

int UserComment::id() const
{
    return m_id;
}

void UserComment::setUserId(int userid)
{
    m_UserId = userid;
}

int UserComment::userId() const
{
    return m_UserId;
}

void UserComment::setmessageRate(int messageRate)
{
    m_messageRate = messageRate;
}

int UserComment::messageRate() const
{
    return m_messageRate;
}

void UserComment::setMessage(const QString &message)
{
    std::string current_locale_text = message.toLocal8Bit().constData();
    std::string result = splitInLines(current_locale_text, 30);
    m_message = QString::fromStdString(result);
}

QString UserComment::message() const
{
    return m_message;
}

QDateTime UserComment::dateTime() const
{
    return m_dateTime;
}

void UserComment::setDateTime(const QDateTime &dateTime)
{
    m_dateTime = dateTime;
}

std::string UserComment::splitInLines(std::string source, std::size_t width)
{
    std::string whitespace = " \t\r";
    std::size_t  currIndex = width - 1;
    std::size_t  sizeToElim;
    while ( currIndex < source.length() )
    {
        currIndex = source.find_last_of(whitespace,currIndex + 1);
        if (currIndex == std::string::npos)
            break;
        currIndex = source.find_last_not_of(whitespace,currIndex);
        if (currIndex == std::string::npos)
            break;
        sizeToElim = source.find_first_not_of(whitespace,currIndex + 1) - currIndex - 1;
        source.replace( currIndex + 1, sizeToElim , "\n");
        currIndex += (width + 1); //due to the recently inserted "\n"
    }
    return source;
}


UserCommentsModel::UserCommentsModel(QObject *parent)
{

}

int UserCommentsModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_UserComment.size ();
}

QVariant UserCommentsModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_UserComment.size())
        return QVariant();

    auto& userComment = m_UserComment.at(index.row());

    switch (role)
    {
    case IdRole:
        return QVariant(userComment->id());
    case UserId:
        return QVariant(userComment->userId());
    case MessageRateRole:
        return QVariant(userComment->messageRate());
    case DateTimeRole:
        return QVariant(userComment->dateTime().toString("yyy-MM-dd hh:mm:ss"));
    case MessageRole:
        return QVariant(userComment->message ());
    }
    return QVariant();
}

bool UserCommentsModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if(index.isValid() || index.row() < 0 || index.row() >= m_UserComment.size())
        return false;

    auto& userComment = m_UserComment.at(index.row());
    switch(role)
    {
    case MessageRateRole:
        userComment->setmessageRate(value.toString().toInt ());
        break;
    case MessageRole:
        userComment->setMessage (value.toString());
        break;
    }

    emit dataChanged(index, index, { role } );
    return true;
}

QHash<int, QByteArray> UserCommentsModel::roleNames() const
{
    return {
        {IdRole, "id"},
        {UserId,"userId"},
        {MessageRateRole, "messageRate"},
        {DateTimeRole, "dateTime"},
        {MessageRole, "message"}
    };
}

int UserCommentsModel::count() const
{
    return m_count;
}

void UserCommentsModel::setCount(int count)
{
    m_count = count;
}

QList<UserComment *> UserCommentsModel::userComment() const
{
    return m_UserComment;
}

void UserCommentsModel::setuserComment(QList<UserComment *> userComment)
{
    beginResetModel();
    clear();
    beginInsertRows(QModelIndex(), 0, 0);

    qDebug()<<userComment.size();
    m_UserComment = userComment;
    for(auto& p : m_UserComment) p->setParent(this);

    endInsertRows();
    endResetModel();
    setCount(m_UserComment.count());
}

void UserCommentsModel::clear()
{
    if(m_UserComment.isEmpty())
        return;

    beginRemoveRows(QModelIndex(), 0, m_UserComment.count()-1);
    m_UserComment.clear();
    endRemoveRows();
}

UserComment *UserCommentsModel::userComment(int id)
{
    auto itr = std::find_if(m_UserComment.begin(), m_UserComment.end(), [=](const UserComment* userComment) {
        return userComment->id() == id;
    });

    if(itr != m_UserComment.end())
        return *itr;
    return nullptr;
}

UserComment *UserCommentsModel::at(int index)
{
    if(index <0 || index > m_UserComment.size())
        return nullptr;
    return m_UserComment.at(index);
}
