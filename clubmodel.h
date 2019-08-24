#ifndef CLUBMODEL_H
#define CLUBMODEL_H

#include <QAbstractListModel>
#include <QJSValue>
#include "club.h"

class ClubModel : public QAbstractListModel
{
    Q_OBJECT
    enum {
        IdRole = Qt::UserRole+1,
        NameRole,
        DivisoinRole,
        RepRole,
        AvAgeRole,
        BalanceRole,
        TrnBudgetSRole,
        TrnBudgetRRole,
        WageBudgetRole,
        StatusRole,
        TfRole,
        YfRole,
        YaRole,
        StadCapRole,
        AvAttRole,
        MinAttRole,
        MaxAttRole,
        RatingRole,
        PotRatingRole,
        Foreground1Role,
        Background1Role,
        Foreground2Role,
        Background2Role,
        Foreground3Role,
        Background3Role,
        Foreground1ValueRole,
        Background1ValueRole,
        Foreground2ValueRole,
        Background2ValueRole,
        Foreground3ValueRole,
        Background3ValueRole,
        Favourite1Role,
        Favourite2Role,
        Favourite3Role,
        Dislike1Role,
        Dislike2Role,
        Dislike3Role,
        Rival1Role,
        Rival2Role,
        Rival3Role,
        OwnerIdRole,
        OwnerNameRole,
        NationRole,
        LeagueIdRole,
        TargetClubRole
    };

public:
    explicit ClubModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex& index, const QVariant& value, int role = Qt::EditRole) override;

    virtual QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE QJSValue get(int idx) const;

public slots:
    void setClubs(QVector<Club*> clubs);
    void clear();
private:

    QVector<Club*> m_clubs;
};

#endif // CLUBMODEL_H
