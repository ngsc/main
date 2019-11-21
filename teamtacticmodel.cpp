#include "teamtacticmodel.h"
#include "teamtactic.h"


std::initializer_list<TeamTacticModel::TacticType> TeamTacticModel::all_teamTacticTypes =  {
        OFFSIDETRAP,
        HARDTACKLE,
        HIGHLINECLOSINGDOWN,
        OFFSIDELINE,
        PREVENTPASS,
        PREVENTINGCUTINSIDE,
        TIGHTMARKING,
        STOPSPLAY,
        GETSFORWARD,
        SHOOTFROMDISTANCE,
        STAYBACK,
        RUNDOWNTHELINE,
        MOVESINTOCHANNELS,
        PREFERDRIBBLEOVERPASS,
        DICTATESTEMPO,
        COMESDEEPTOGETBALL,
        LONGPASSES,
        ROUNDTOKEEPER,
        BEATOFFSIDETRAP,
        CUTINSIDE,
        CROSSTHEBALLMOREOFTEN,
        RUSHOUT,
        FORWARDINCORNERKICK,
        PASSBALLTODEFENDER,
        TRIESKILLERBALLOFTEN
    };

std::string const TeamTacticModel::all_teamTacticName[] =  {
        "Offside Trap",
        "Hard Tackle",
        "Highline closing down",
        "Offside Line",
        "Prevent Pass",
        "Preventing Cut Inside",
        "Tight Marking",
        "Stops Play",
        "Gets Forward",
        "Shoot From Distance",
        "Stay Back",
        "Run Down The Line",
        "Moves Into Channels",
        "Prefer Dribble Over Pass",
        "Dictates Tempo",
        "Comes Deep To Get Ball",
        "Long Passes",
        "Round To Keeper",
        "Beat Offside Trap",
        "Cut Inside",
        "Cross Theball More Often",
        "Rush Out",
        "Forward In Corner Kick",
        "Pass Ball To Defender",
        "Tries Killer Ball Often"
    };

TeamTacticModel::TeamTacticModel(QObject *parent)
    : QAbstractListModel(parent)
{
    int i = 0;
    for (auto e : all_teamTacticTypes) {
        TeamTactic* pTeamTactic = new TeamTactic(this);
        pTeamTactic->setType(e);
        pTeamTactic->setName(all_teamTacticName[i++].c_str());
        pTeamTactic->setSelected(false);
        m_teamTactics.push_back( pTeamTactic );
    }
}

int TeamTacticModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_teamTactics.size ();
}

QVariant TeamTacticModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_teamTactics.size())
        return QVariant();

    auto& teamTactic = m_teamTactics.at(index.row());

    switch (role)
    {
    case SelectedRole:
        return QVariant(teamTactic->getSelected() );
    case NameRole:
        return QVariant(teamTactic->getName() );
    case TypeRole:
        return QVariant(teamTactic->getType() );
    }
    return QVariant();
}

bool TeamTacticModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if(index.isValid() || index.row() < 0 || index.row() >= m_teamTactics.size())
        return false;

    auto& teamTactic = m_teamTactics.at(index.row());
    switch(role)
    {
    case SelectedRole:
        teamTactic->setSelected( value.toBool() );
        break;
    case NameRole:
        teamTactic->setName( value.toString() );
        break;
    case TypeRole:
        teamTactic->setType( value.toInt() );
        break;
    }

    emit dataChanged(index, index, { role } );
    return true;
}

QHash<int, QByteArray> TeamTacticModel::roleNames() const
{
    return {
        {SelectedRole, "selected"},
        {NameRole, "name"},
        {TypeRole, "type"}
    };
}

int TeamTacticModel::count() const
{
    return m_count;
}

void TeamTacticModel::setCount(int count)
{
    m_count = count;
    emit countChanged(count);
}
