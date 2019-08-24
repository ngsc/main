#ifndef PLAYERMODEL_H
#define PLAYERMODEL_H

#include <QAbstractListModel>
#include <QSortFilterProxyModel>
#include "player.h"

class PlayerModel : public QAbstractListModel
{
    Q_OBJECT

    enum {
        IdRole = Qt::UserRole+1,
        NameRole,
        NumberRole,
        ClubIdRole,
        NationRole,
        ProposedPositionRole,
        AssignedPositionRole,
        AgeRole,
        IntCapsRole,
        IntGoalsRole,
        CurARole,
        PotARole,
        ADiffRole,
        BasedRole,
        HomeRepRole,
        CurrentRepRole,
        WorldRepRole,
        DobRole,
        OfferId,
        LikeRate,
        DislikeRate
    };

public:
    explicit PlayerModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;

    virtual QHash<int, QByteArray> roleNames() const override;

public slots:
    void setPlayers(QList<Player *> players);
    QList<Player *> players();
    QList<Player *> playersInFormation();       //return players who has positions and will play in the match
    void clear();
    Player *player(int id);
    Player *at(int index);

    int positionCount(QString position);
    int count() const;

signals:
    void playersAdded();

private:
    QList<Player*> m_players;
};

#endif // PLAYERMODEL_H
