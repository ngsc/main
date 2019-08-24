#include "tournamentmodel.h"

TournamentModel::TournamentModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int TournamentModel::rowCount(const QModelIndex &parent) const
{
    if (!parent.isValid())
        return 0;
    return m_tournaments.size();
}

QVariant TournamentModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    const auto& tour = m_tournaments.at(index.row());
    switch(role)
    {
    case IdRole:
        return QVariant(tour->id());
    case NameRole:
        return QVariant(tour->name());
    case StartDateRole:
        return QVariant(tour->startDate());
    }
    return QVariant();
}

bool TournamentModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if(!index.isValid())
        return false;

    auto& tour = m_tournaments.at(index.row());
    switch(role)
    {
    case IdRole:
        tour->setId(value.toInt());
        break;
    case NameRole:
        tour->setName(value.toString());
        break;
    case StartDateRole:
        tour->setStartDate(value.toDate());
        break;
    }

    emit dataChanged(index, index, {role});
    return true;
}

QHash<int, QByteArray> TournamentModel::roleNames() const
{
    return {
        {IdRole, "id"},
        {NameRole, "name"},
        {StartDateRole, "startDate"}
    };
}

void TournamentModel::setTournaments(QVector<Tournament *> tournaments)
{
    beginResetModel();

    clear();

    beginInsertRows(QModelIndex(), 0, 0);
    m_tournaments = tournaments;
    endInsertRows();

    endResetModel();
}

void TournamentModel::clear()
{
    if(m_tournaments.isEmpty())
        return;

    beginRemoveRows(QModelIndex(), 0, m_tournaments.count()-1);
    qDeleteAll(m_tournaments.begin(), m_tournaments.end());
    m_tournaments.clear();
    endRemoveRows();
}

