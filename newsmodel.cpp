#include "newsmodel.h"
#include <QDebug>
#include <QtQml>

NewsModel::NewsModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int NewsModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_news.size();
}

QVariant NewsModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_news.size())
        return QVariant();

    auto news = m_news.at(index.row());

    switch(role)
    {
    case IdRole:
        return QVariant(news->id());
    case BriefRole:
        return QVariant(news->brief());
    case MessageRole:
        return QVariant(news->message());
    case OfferIdRole:
        return QVariant(news->offerId());
    case OwnerClubIdRole:
        return QVariant(news->ownerClubId());
    case BiddingClubIdRole:
        return QVariant(news->biddingClubId());
    case ReadRole:
        return QVariant(news->read());
    case ActiveRole:
        return QVariant(news->active());
    case RoleRole:
        return QVariant::fromValue(news->role());
    case StageRole:
        return QVariant::fromValue(news->stage());
    case DateTimeRole:
        return QVariant(news->dateTime().toString("yyy-MM-dd hh:mm:ss"));
    }
    return QVariant();
}

bool NewsModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if(!index.isValid())
        return false;

    auto& news = m_news.at(index.row());
    switch(role)
    {
    case ReadRole:
        news->setRead(value.toBool());
        break;
    }

    emit dataChanged(index, index, {role});
    return true;
}

QHash<int, QByteArray> NewsModel::roleNames() const
{
    return {
        {IdRole, "id"},
        {BriefRole, "brief"},
        {MessageRole, "message"},
        {OfferIdRole, "offerId"},
        {OwnerClubIdRole, "ownerClubId"},
        {BiddingClubIdRole, "biddingClubId"},
        {ReadRole, "read"},
        {ActiveRole, "active"},
        {RoleRole, "role"},
        {StageRole, "stage"},
        {DateTimeRole, "dateTime"}
    };
}

QJSValue NewsModel::get(int idx) const
{
    QJSEngine *engine = qmlEngine(this);
    QJSValue value = engine->newObject();
    if (idx >= 0 && idx < m_news.size()) {
        QHash<int, QByteArray> roles = roleNames();
        QHashIterator<int, QByteArray> it(roles);
        while (it.hasNext()) {
            it.next();
            value.setProperty(QString::fromUtf8(it.value()), data(index(idx, 0), it.key()).toString());
        }
    }
    return value;
}

QList<News *> NewsModel::news() const
{
    return m_news;
}

void NewsModel::setNews(const QList<News *> news)
{
    qDebug() << "News: " << news.size();
    beginResetModel();
    clear();
    beginInsertRows(QModelIndex(), 0, 0);
    m_news = news;
    for(auto& n: m_news) n->setParent(this);
    endInsertRows();
    endResetModel();
    setCount(m_news.count());
}

void NewsModel::clear()
{
    if(m_news.isEmpty())
        return;

    beginRemoveRows(QModelIndex(), 0, m_news.count()-1);
    m_news.clear();
    endRemoveRows();
}

News *NewsModel::news(int id)
{
    auto itr = std::find_if(m_news.begin(), m_news.end(), [=](const News* news) {
        return news->id() == id;
    });

    if(itr != m_news.end())
        return *itr;
    return nullptr;
}

News *NewsModel::at(int index)
{
    if(index <0 || index > m_news.size())
        return nullptr;
    return m_news.at(index);
}

bool NewsModel::containsUnread()
{
    auto itr = std::find_if(m_news.begin(), m_news.end(), [=](const News* news) {
        return news->read() == false;
    });
    return (itr != m_news.end());
}

int NewsModel::count() const
{
    return m_count;
}

void NewsModel::setCount(int count)
{
    m_count = count;
    emit countChanged(count);
}
