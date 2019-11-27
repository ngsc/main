#include "invitationmodel.h"

InvitationModel::InvitationModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int InvitationModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return m_invitations.size();
}

QVariant InvitationModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_invitations.size())
        return QVariant();

    auto invitation = m_invitations.at(index.row());
    switch(role) {
    case IdRole:
        return QVariant(invitation->id());
    case HomeUserIdRole:
        return QVariant(invitation->homeUserId());
    case AwayUserIdRoe:
        return QVariant(invitation->awayUserId());
    case HomeClubNameRole:
        return QVariant(invitation->homeClubName());
    case AwayClubNameRole:
        return QVariant(invitation->awayClubName());
    case HomeClubIdRole:
        return QVariant(invitation->homeClubId());
    case AwayClubIdRole:
        return QVariant(invitation->awayClubId());
    case DateTimeRole:
        return QVariant(invitation->date().toString("yyyy-MM-dd hh:mm:ss"));
    }
    return QVariant();
}

QHash<int, QByteArray> InvitationModel::roleNames() const
{
    return {
        {IdRole, "id"},
        {HomeUserIdRole, "homeUserId"},
        {AwayUserIdRoe, "awayUserId"},
        {HomeClubIdRole, "homeClubId"},
        {HomeClubNameRole, "homeClubName"},
        {AwayClubIdRole, "awayClubId"},
        {AwayClubNameRole, "awayClubName"},
        {StatusRole, "status"},
        {DateTimeRole, "date"}
    };
}

void InvitationModel::setInvitations(QList<Invitation *> invitations)
{
    beginResetModel();
    clear();
    beginInsertRows(QModelIndex(), 0, 0);
    m_invitations = invitations;
    for(auto & i : m_invitations) i->setParent(this);
    endInsertRows();
    endResetModel();
}

void InvitationModel::clear()
{
    if(m_invitations.isEmpty())
        return;
    beginRemoveRows(QModelIndex(), 0, m_invitations.count() - 1);
    qDeleteAll(m_invitations.begin(), m_invitations.end());
    m_invitations.clear();
    endRemoveRows();
}

QList<Invitation *> InvitationModel::invitations()
{
    return m_invitations;
}

void InvitationModel::setHomeClubId(int clubId)
{
    m_HomeClubID = clubId;
}

bool InvitationModel::areThereInvetationNews()
{
    for(int i = 0 ; i < m_invitations.count(); i++){
        if(m_invitations.at(i)->status().compare("active") == 0 && (m_HomeClubID == m_invitations.at(i)->awayClubId())){
            return true;
        }
    }
    return false;
}

bool InvitationModel::isLastInvitationAccepted(QDateTime date, int lastInviteeId)
{
    for(int i = 0 ; i < m_invitations.count(); i++){
        if(m_invitations.at(i)->status().compare("accepted",Qt::CaseInsensitive) == 0
                && m_HomeClubID == m_invitations.at(i)->homeClubId()
                && lastInviteeId == m_invitations.at(i)->awayUserId()
                && date.isValid() )
        {
            QString chinaServerTimeString = m_invitations.at(i)->date().toString() + " GMT+8";
            QDateTime invitationCreationDateChina = QDateTime::fromString( chinaServerTimeString );
            if( date.toUTC() <= invitationCreationDateChina.toUTC() )
            {
                return true;
            }
        }
    }
    return false;
}

QList<int> InvitationModel::cancelAllInvetation()
{
    m_InvetationId.clear();
    for(int i = 0 ; i < m_invitations.count () ; i++){
        if(m_invitations.at(i)->status().compare("active", Qt::CaseInsensitive) == 0 && (m_HomeClubID == m_invitations.at(i)->awayClubId())){
            m_InvetationId.append(m_invitations.at(i)->id());
            m_invitations.at(i)->setStatus("Rejected");
        }
    }
    return m_InvetationId;
}
