#include "clubmodel.h"
#include <QtQml>

ClubModel::ClubModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int ClubModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return m_clubs.size();
}

QVariant ClubModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    const auto & club = m_clubs.at(index.row());
    switch(role)
    {
    case IdRole:
        return QVariant(club->id());
    case NameRole:
        return QVariant(club->name());
    case DivisoinRole:
        return QVariant(club->division());
    case RepRole:
        return QVariant(club->rep());
    case AvAgeRole:
        return QVariant(club->avAge());
    case BalanceRole:
        return QVariant(club->balance());
    case TrnBudgetSRole:
        return QVariant(club->trnBudgetS());
    case TrnBudgetRRole:
        return QVariant(club->trnBudgetR());
    case WageBudgetRole:
        return QVariant(club->wageBudget());
    case StatusRole:
        return QVariant(club->status());
    case TfRole:
        return QVariant(club->tf());
    case YfRole:
        return QVariant(club->yf());
    case YaRole:
        return QVariant(club->ya());
    case StadCapRole:
        return QVariant(club->stadCap());
    case AvAttRole:
        return QVariant(club->avAtt());
    case MinAttRole:
        return QVariant(club->minAtt());
    case MaxAttRole:
        return QVariant(club->maxAtt());
    case RatingRole:
        return QVariant(club->rating());
    case PotRatingRole:
        return QVariant(club->potRating());
    case Foreground1Role:
        return QVariant(club->foreground1());
    case Background1Role:
        return QVariant(club->foreground2());
    case Foreground2Role:
        return QVariant(club->foreground3());
    case Background2Role:
        return QVariant(club->background1());
    case Foreground3Role:
        return QVariant(club->background2());
    case Background3Role:
        return QVariant(club->background3());
    case Foreground1ValueRole:
        return QVariant(club->foreground1Value());
    case Background1ValueRole:
        return QVariant(club->background1Value());
    case Foreground2ValueRole:
        return QVariant(club->foreground2Value());
    case Background2ValueRole:
        return QVariant(club->background2Value());
    case Foreground3ValueRole:
        return QVariant(club->foreground3Value());
    case Background3ValueRole:
        return QVariant(club->background3Value());
    case Favourite1Role:
        return QVariant(club->favourite1());
    case Favourite2Role:
        return QVariant(club->favourite2());
    case Favourite3Role:
        return QVariant(club->favourite3());
    case Dislike1Role:
        return QVariant(club->dislike1());
    case Dislike2Role:
        return QVariant(club->dislike2());
    case Dislike3Role:
        return QVariant(club->dislike3());
    case Rival1Role:
        return QVariant(club->rival1());
    case Rival2Role:
        return QVariant(club->rival2());
    case Rival3Role:
        return QVariant(club->rival3());
    case OwnerIdRole:
        return QVariant(club->ownerId());
    case OwnerNameRole:
        return QVariant(club->ownerName());
    case NationRole:
        return QVariant(club->nation());
    case LeagueIdRole:
        return QVariant(club->leagueId());
    case TargetClubRole:
        return QVariant(club->targetClub());
    }
    return QVariant();
}

bool ClubModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid())
        return false;

    auto& club = m_clubs.at(index.row());
    switch(role)
    {
    case IdRole:
        club->setId(value.toInt());
        break;
    case NameRole:
        club->setName(value.toString());
        break;
    case DivisoinRole:
        club->setDivision(value.toString());
        break;
    case RepRole:
        club->setRep(value.toInt());
        break;
    case AvAgeRole:
        club->setAvAge(value.toDouble());
        break;
    case BalanceRole:
        club->setBalance(value.toInt());
        break;
    case TrnBudgetSRole:
        club->setTrnBudgetS(value.toInt());
        break;
    case TrnBudgetRRole:
        club->setTrnBudgetR(value.toInt());
        break;
    case WageBudgetRole:
        club->setWageBudget(value.toInt());
        break;
    case StatusRole:
        club->setStatus(value.toString());
        break;
    case TfRole:
        club->setTf(value.toInt());
        break;
    case YfRole:
        club->setYf(value.toInt());
        break;
    case YaRole:
        club->setYa(value.toInt());
        break;
    case StadCapRole:
        club->setStadCap(value.toInt());
        break;
    case AvAttRole:
        club->setAvAtt(value.toInt());
        break;
    case MinAttRole:
        club->setMinAtt(value.toInt());
        break;
    case MaxAttRole:
        club->setMaxAtt(value.toInt());
        break;
    case RatingRole:
        club->setRating(value.toInt());
        break;
    case PotRatingRole:
        club->setPotRating(value.toDouble());
        break;
    case Foreground1Role:
        club->setForeground1(value.toString());
        break;
    case Background1Role:
        club->setBackground1(value.toString());
        break;
    case Foreground2Role:
        club->setForeground2(value.toString());
        break;
    case Background2Role:
        club->setBackground2(value.toString());
        break;
    case Foreground3Role:
        club->setForeground3(value.toString());
        break;
    case Background3Role:
        club->setBackground3(value.toString());
        break;
    case Foreground1ValueRole:
        club->setForeground1Value(value.toString());
        break;
    case Background1ValueRole:
        club->setBackground1Value(value.toString());
        break;
    case Foreground2ValueRole:
        club->setForeground2Value(value.toString());
        break;
    case Background2ValueRole:
        club->setBackground2Value(value.toString());
        break;
    case Foreground3ValueRole:
        club->setForeground3Value(value.toString());
        break;
    case Background3ValueRole:
        club->setBackground3Value(value.toString());
        break;
    case Favourite1Role:
        club->setFavourite1(value.toString());
        break;
    case Favourite2Role:
        club->setFavourite2(value.toString());
        break;
    case Favourite3Role:
        club->setFavourite3(value.toString());
        break;
    case Dislike1Role:
        club->setDislike1(value.toString());
        break;
    case Dislike2Role:
        club->setDislike2(value.toString());
        break;
    case Dislike3Role:
        club->setDislike3(value.toString());
        break;
    case Rival1Role:
        club->setRival1(value.toString());
        break;
    case Rival2Role:
        club->setRival2(value.toString());
        break;
    case Rival3Role:
        club->setRival3(value.toString());
        break;
    case TargetClubRole:
        club->settargetClub(value.toBool());
        break;
    }

    emit dataChanged(index, index, {role});
    return true;
}

QHash<int, QByteArray> ClubModel::roleNames() const
{
    return {
        {IdRole, "id"},
        {NameRole, "name"},
        {DivisoinRole, "division"},
        {RepRole, "rep"},
        {AvAgeRole, "avAge"},
        {BalanceRole, "balance"},
        {TrnBudgetSRole, "trnBudgetS"},
        {TrnBudgetRRole, "trnBudgetR"},
        {WageBudgetRole, "wageBudget"},
        {StatusRole, "status"},
        {TfRole, "tf"},
        {YfRole, "yf"},
        {YaRole, "ya"},
        {StadCapRole, "stadCap"},
        {AvAttRole, "avAtta"},
        {MinAttRole, "minAtt"},
        {MaxAttRole, "maxAtt"},
        {RatingRole, "rating"},
        {PotRatingRole, "potRating"},
        {Foreground1Role, "foreground1"},
        {Background1Role, "background1"},
        {Foreground2Role, "foreground2"},
        {Background2Role, "background2"},
        {Foreground3Role, "foreground3"},
        {Background3Role, "background3"},
        {Foreground1ValueRole, "foreground1Value"},
        {Background1ValueRole, "background1Value"},
        {Foreground2ValueRole, "foreground2Value"},
        {Background2ValueRole, "background2Value"},
        {Foreground3ValueRole, "foreground3Value"},
        {Background3ValueRole, "background3Value"},
        {Favourite1Role, "favourite1"},
        {Favourite2Role, "favourite2"},
        {Favourite3Role, "favourite3"},
        {Dislike1Role, "dislike1"},
        {Dislike2Role, "dislike2"},
        {Dislike3Role, "dislike3"},
        {Rival1Role, "rival1"},
        {Rival2Role, "rival2"},
        {Rival3Role, "rival3"},
        {OwnerIdRole, "ownerId"},
        {OwnerNameRole, "ownerName"},
        {NationRole, "nation"},
        {LeagueIdRole, "leagueId"},
        {TargetClubRole,"targetClub"}
    };
}

QJSValue ClubModel::get(int idx) const
{
    QJSEngine *engine = qmlEngine(this);
    QJSValue value = engine->newObject();
    if (idx >= 0 && idx < m_clubs.size()) {
        QHash<int, QByteArray> roles = roleNames();
        QHashIterator<int, QByteArray> it(roles);
        while (it.hasNext()) {
            it.next();
            value.setProperty(QString::fromUtf8(it.value()), data(index(idx, 0), it.key()).toString());
        }
    }
    return value;
}

void ClubModel::setClubs(QVector<Club *> clubs)
{
    beginResetModel();

    clear();
    beginInsertRows(QModelIndex(), 0, 0);
    m_clubs = clubs;
    for(auto & c: m_clubs) c->setParent(this);
    endInsertRows();

    endResetModel();
}

void ClubModel::clear()
{
    if(m_clubs.isEmpty())
        return;

    beginRemoveRows(QModelIndex(), 0, m_clubs.count()-1);
    //qDeleteAll(m_clubs.begin(), m_clubs.end());
    m_clubs.clear();
    endRemoveRows();
}
