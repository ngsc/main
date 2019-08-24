#include "searchingpoolmodel.h"
#include <QLocale>
#include <QDebug>

SearchingPoolPlayer::SearchingPoolPlayer(QObject *parent)
    : QObject (parent)
{
}

int SearchingPoolPlayer::id() const
{
    return m_id;
}

void SearchingPoolPlayer::setId(int id)
{
    m_id = id;
}

QString SearchingPoolPlayer::name() const
{
    return m_name;
}

void SearchingPoolPlayer::setName(const QString &name)
{
    m_name = name;
}

int SearchingPoolPlayer::clubId() const
{
    return m_clubId;
}

void SearchingPoolPlayer::setClubId(int clubId)
{
    m_clubId = clubId;
}

QString SearchingPoolPlayer::clubName() const
{
    return m_clubName.isEmpty() ? "N/A" : m_clubName;
}

void SearchingPoolPlayer::setClubName(const QString &clubName)
{
    m_clubName = clubName;
}

int SearchingPoolPlayer::value() const
{
    return m_value;
}

void SearchingPoolPlayer::setValue(int value)
{
    m_value = value;
}

QString SearchingPoolPlayer::based() const
{
    return m_based;
}

void SearchingPoolPlayer::setBased(const QString &based)
{
    m_based = based;
}

int SearchingPoolPlayer::minimumFee() const
{
    return m_minimumFee;
}

void SearchingPoolPlayer::setMinimumFee(int minimumFee)
{
    m_minimumFee = minimumFee;
}

int SearchingPoolPlayer::offerId() const
{
    return m_offerId;
}

void SearchingPoolPlayer::setOfferId(int offerId)
{
    m_offerId = offerId;
}

QString SearchingPoolPlayer::position() const
{
    return m_position;
}

void SearchingPoolPlayer::setPosition(const QString &position)
{
    m_position = position;
}


//====================================================

SearchingPoolModel::SearchingPoolModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int SearchingPoolModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return m_players.size();
}

QVariant SearchingPoolModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_players.size())
        return QVariant();

    const auto& player = m_players.at(index.row());

    switch (role)
    {
    case IdRole:
        return QVariant(player->id());
    case NameRole:
        return QVariant(player->name());
    case ClubIdRole:
        return QVariant(player->clubId());
    case ClubNameRole:
        return QVariant(player->clubName());
    case PositionRole:
        return QVariant(player->position());
    case ValueRole:
        return QVariant(player->value());
        //return QVariant(QLocale(QLocale::AnyLanguage, QLocale::AnyScript, QLocale::EuropeanUnion).toCurrencyString(player->value()));
    case BasedRole:
        return QVariant(player->based());
    case MinimumFeeRole:
        return QVariant(player->minimumFee());
    case OfferId:
        return QVariant(player->offerId());
    }
    return QVariant();
}

QHash<int, QByteArray> SearchingPoolModel::roleNames() const
{
    return {
        {IdRole, "id"},
        {NameRole, "name"},
        {ClubIdRole, "clubId"},
        {ClubNameRole, "clubName"},
        {PositionRole, "position"},
        {ValueRole, "value"},
        {BasedRole, "based"},
        {MinimumFeeRole, "minimumFee"},
        {OfferId, "offerId"}
    };
}

void SearchingPoolModel::setPlayers(QList<SearchingPoolPlayer *> players)
{
    if(players.isEmpty())
        return;

    beginResetModel();

    clear();
    beginInsertRows(QModelIndex(), 0, 0);
    m_players = players;
    for(auto& p : m_players)
        p->setParent(this);
    endInsertRows();

    endResetModel();
}

void SearchingPoolModel::clear()
{
    if(m_players.isEmpty())
        return;

    beginRemoveRows(QModelIndex(), 0, m_players.count()-1);
    qDeleteAll(m_players.begin(), m_players.end());
    m_players.clear();
    endRemoveRows();
}

SearchingPoolPlayer *SearchingPoolModel::player(int id)
{
    for(auto* player: m_players)
    {
        if(player->id() == id)
            return player;
    }
    return nullptr;
}
