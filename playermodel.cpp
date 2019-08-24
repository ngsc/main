#include "playermodel.h"

#include <QDebug>

PlayerModel::PlayerModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int PlayerModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_players.size();
}

QVariant PlayerModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_players.size())
        return QVariant();

    const auto& player = m_players.at(index.row());

    switch (role)
    {
    case IdRole:
        return QVariant(player->info().id());
    case NameRole:
        return QVariant(player->info().name());
    case NumberRole:
        return QVariant(player->info().number());
    case ClubIdRole:
        return QVariant(player->info().clubId());
    case NationRole:
        return QVariant(player->info().nation());
    case ProposedPositionRole:
        return QVariant(player->info().proposedPosition());
    case AssignedPositionRole:
        return QVariant(player->info().assignedPosition());
    case AgeRole:
        return QVariant(player->info().age());
    case IntCapsRole:
        return QVariant(player->info().intCaps());
    case IntGoalsRole:
        return QVariant(player->info().intGoals());
    case CurARole:
        return QVariant(player->info().curA());
    case PotARole:
        return QVariant(player->info().potA());
    case ADiffRole:
        return QVariant(player->info().aDiff());
    case BasedRole:
        return QVariant(player->info().based());
    case HomeRepRole:
        return QVariant(player->info().homeRep());
    case CurrentRepRole:
        return QVariant(player->info().currentRep());
    case WorldRepRole:
        return QVariant(player->info().worldRep());
    case DobRole:
        return QVariant(player->info().dob());
    case OfferId:
        return QVariant(player->info().offerId());
    case LikeRate:
        return QVariant(player->info().likeRate());
    case DislikeRate:
        return QVariant(player->info().dislikeRate());
    }
    return QVariant();
}

bool PlayerModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if(index.isValid() || index.row() < 0 || index.row() >= m_players.size())
        return false;

    auto& player = m_players.at(index.row());
    switch(role)
    {
    case NameRole:
        player->info().setName(value.toString());
        break;
    case NumberRole:
        player->info().setNumber(value.toInt());
        break;
    case ClubIdRole:
        player->info().setClubId(value.toInt());
        break;
    case NationRole:
        player->info().setNation(value.toString());
        break;
    case ProposedPositionRole:
        player->info().setProposedPosition(value.toString());
        break;
    case AssignedPositionRole:
        player->info().setAssignedPosition(value.toString());
        break;
    case AgeRole:
        player->info().setAge(value.toInt());
        break;
    case IntCapsRole:
        player->info().setIntCaps(value.toInt());
        break;
    case IntGoalsRole:
        player->info().setIntGoals(value.toInt());
        break;
    case CurARole:
        player->info().setCurA(value.toInt());
        break;
    case PotARole:
        player->info().setPotA(value.toInt());
        break;
    case ADiffRole:
        player->info().setADiff(value.toInt());
        break;
    case BasedRole:
        player->info().setBased(value.toString());
        break;
    case HomeRepRole:
        player->info().setHomeRep(value.toInt());
        break;
    case CurrentRepRole:
        player->info().setCurrentRep(value.toInt());
        break;
    case WorldRepRole:
        player->info().setWorldRep(value.toInt());
        break;
    case DobRole:
        player->info().setDob(value.toDate());
        break;
    case OfferId:
        player->info().setOfferId(value.toInt());
        break;
    case LikeRate:
        player->info().setLikeRate(value.toInt());
        break;
    case DislikeRate:
        player->info().setDislikeRate(value.toInt());
        break;
    }

    emit dataChanged(index, index, { role } );
    return true;
}

QHash<int, QByteArray> PlayerModel::roleNames() const
{
    return {
        {IdRole, "id"},
        {NameRole, "name"},
        {NumberRole, "number"},
        {ClubIdRole, "clubId"},
        {NationRole, "nation"},
        {ProposedPositionRole, "proposedPosition"},
        {AssignedPositionRole, "assignedPosition"},
        {AgeRole, "age"},
        {IntCapsRole, "intCaps"},
        {IntGoalsRole, "intGoals"},
        {CurARole, "curA"},
        {PotARole, "potA"},
        {ADiffRole, "aDiff"},
        {BasedRole, "based"},
        {HomeRepRole, "homeRep"},
        {CurrentRepRole, "currentRep"},
        {WorldRepRole, "worldRep"},
        {DobRole, "dob"},
        {OfferId, "offerId"},
        {LikeRate,"likeRate"},
        {DislikeRate ,"dislikeRate"}
    };
}

void PlayerModel::setPlayers(QList<Player *> players)
{
    qDebug() << "set players ...: " << players.count();
    beginResetModel();

    clear();
    beginInsertRows(QModelIndex(), 0, 0);
    m_players = players;
    for(auto& p : m_players) p->setParent(this);
    endInsertRows();

    endResetModel();
}

QList<Player *> PlayerModel::players()
{
    return m_players;
}

QList<Player *> PlayerModel::playersInFormation()
{
/*
 * The players will be ordered as below
    GK=GoalKeeper
    SW=Sweeper

    D R=Right Defender(Full Back in map)
    D C=Central Defender
    D L=Left Defender(Full Back in map)

    WB R=Right WingBack(Right Defensive Midfielder in map)
    WB L=Left WingBack(left Defensive Midfielder in map)

    DM C=Central Defensive Midfielder(Defensive Midfielder in map)

    M R=Right Midfielder(Side Midfielder in map)
    M C=Central Midfielder(Midfielder in map)
    M L=Left Midfielder(Side Midfielder in map)

    AM R=Right Attacking Midfielder(Attacking Winger in map)
    AM C=Central Attacking Midfielder(Attacking Midfielder in map)
    AM L=Left Attacking Midfielder(Attacking Winger in map)

    ST=Forward
*/
    QList<Player *> p;
    //for(auto* player: m_players)
    {
        auto pend = p.end();
        auto itr = std::find_if(p.begin(), p.end(), [](Player* player){
            return player->info().assignedPosition() == "GK";
        });
        if(itr != pend)
            p.push_back(*itr);

        itr = std::find_if(p.begin(), p.end(), [](Player* player){
            return player->info().assignedPosition() == "SW";
        });
        if(itr != pend) p.push_back(*itr);

    }

    return p;

}

void PlayerModel::clear()
{
    if(m_players.isEmpty())
        return;

    beginRemoveRows(QModelIndex(), 0, m_players.count()-1);
    qDeleteAll(m_players.begin(), m_players.end());
    m_players.clear();
    endRemoveRows();
}

Player* PlayerModel::player(int id)
{
    for(auto* player: m_players)
    {
        if(player->info().id() == id)
            return player;
    }

    return nullptr;
}

Player *PlayerModel::at(int index)
{
    if(index > m_players.count() || index < 0)
        return nullptr;

    return m_players.at(index);
}

int PlayerModel::positionCount(QString position)
{
    return std::count_if(m_players.begin(), m_players.end(), [=](Player* player ) {
        return player->info().assignedPosition() == position;
    });
}

int PlayerModel::count() const
{
    return m_players.count();
}
