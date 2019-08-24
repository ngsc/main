#include "matchmodel.h"
#include "match.h"

#include <QDebug>

MatchModel::MatchModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int MatchModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return m_matches.size();
}

QVariant MatchModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_matches.size())
        return QVariant();

    auto match = m_matches.at(index.row());
    switch (role) {
    case IdRole:
        return QVariant(match->id());
    case DateRole:
        return QVariant(match->date());
    case TimeRole:
        return QVariant(match->time());
    case HomeClubIdRole:
        return QVariant(match->homeClubId());
    case HomeClubNameRole:
        return QVariant(match->homeClubName());
    case AwayClubIdRole:
        return QVariant(match->awayClubId());
    case AwayClubNameRole:
        return QVariant(match->awayClubName());
    case DateTimeRole:
        return QVariant(match->date().toString("yyyy-MM-dd") + " " + match->time().toString("hh:mm:ss"));
    }
    return QVariant();
}

QHash<int, QByteArray> MatchModel::roleNames() const
{
    return {
        {IdRole, "id"},
        {DateRole, "date"},
        {TimeRole, "time"},
        {HomeClubIdRole, "homeClubId"},
        {HomeClubNameRole, "homeClubName"},
        {AwayClubIdRole, "awayClubId"},
        {AwayClubNameRole, "awayClubName"},
        {DateTimeRole, "dateTime"}
    };
}

void MatchModel::setMatches(QList<Match*> matches)
{
    qDebug() << "matches: " << matches.count();
    beginResetModel();
    clear();
    beginInsertRows(QModelIndex(), 0, 0);
    m_matches = matches;
    for(auto& m: m_matches) m->setParent(this);
    endInsertRows();
    endResetModel();
}

void MatchModel::clear()
{
    if(m_matches.isEmpty())
        return;

    beginRemoveRows(QModelIndex(), 0, m_matches.count()-1);
    m_matches.clear();
    endRemoveRows();
}

QList<Match*> MatchModel::matches()
{
    return m_matches;
}
