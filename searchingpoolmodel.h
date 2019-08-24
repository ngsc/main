#ifndef SEARCHINGPOOLMODEL_H
#define SEARCHINGPOOLMODEL_H

#include "player.h"
#include <QAbstractListModel>

class SearchingPoolPlayer : public QObject {
    Q_OBJECT

public:

    explicit SearchingPoolPlayer(QObject *parent = nullptr);

    int id() const;
    void setId(int id);

    QString name() const;
    void setName(const QString &name);

    int clubId() const;
    void setClubId(int clubId);

    QString clubName() const;
    void setClubName(const QString &clubName);

    QString position() const;
    void setPosition(const QString &position);

    int value() const;
    void setValue(int value);

    QString based() const;
    void setBased(const QString &based);

    int minimumFee() const;
    void setMinimumFee(int minimumFee);

    int offerId() const;
    void setOfferId(int offerId);

private:

    int m_id;
    QString m_name;
    int m_clubId;
    QString m_clubName;
    QString m_position;
    int m_value;
    QString m_based;
    int m_minimumFee;
    int m_offerId;
};

class SearchingPoolModel : public QAbstractListModel
{
    Q_OBJECT

/*
1- name
2- club name/id
3- position
4- value
5- based
*/
    enum {
        IdRole = Qt::UserRole+1,
        NameRole,
        ClubIdRole,
        ClubNameRole,
        PositionRole,
        ValueRole,
        BasedRole,
        MinimumFeeRole,
        OfferId
    };

public:
    explicit SearchingPoolModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    virtual QHash<int, QByteArray> roleNames() const override;

public slots:
    void setPlayers(QList<SearchingPoolPlayer *> players);
    void clear();
    SearchingPoolPlayer *player(int id);

private:
    QList<SearchingPoolPlayer*> m_players;
};

#endif // SEARCHINGPOOLMODEL_H
