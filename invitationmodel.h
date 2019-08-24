#ifndef INVITATIONMODEL_H
#define INVITATIONMODEL_H

#include <QAbstractListModel>
#include "invitation.h"

class InvitationModel : public QAbstractListModel
{
    Q_OBJECT

/*

    Q_PROPERTY(int id READ id CONSTANT)
    Q_PROPERTY(int homeUserId READ homeUserId CONSTANT)
    Q_PROPERTY(int awayUserId READ awayUserId CONSTANT)
    Q_PROPERTY(QString homeClubName READ homeClubName CONSTANT)
    Q_PROPERTY(QString awayClubName READ awayClubName CONSTANT)
    Q_PROPERTY(int homeClubId READ homeClubId CONSTANT)
    Q_PROPERTY(int awayClubId READ awayClubId CONSTANT)
    Q_PROPERTY(int status READ status CONSTANT)
    Q_PROPERTY(QDateTime date READ date)
*/
    enum {
        IdRole = Qt::UserRole + 1,
        HomeUserIdRole,
        AwayUserIdRoe,
        HomeClubIdRole,
        HomeClubNameRole,
        AwayClubIdRole,
        AwayClubNameRole,
        StatusRole,
        DateTimeRole
    };

public:
    explicit InvitationModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    virtual QHash<int, QByteArray> roleNames() const override;

public slots:
    void setInvitations(QList<Invitation*> invitations);
    void clear();
    QList<Invitation *> invitations();

private:
    QList<Invitation *> m_invitations;
};

#endif // INVITATIONMODEL_H
