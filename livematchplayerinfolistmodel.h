#ifndef LIVEMATCHPLAYERINFOLISTMODEL_H
#define LIVEMATCHPLAYERINFOLISTMODEL_H

#include <QAbstractListModel>
#include "livematchplayerinfo.h"

class LiveMatchPlayerInfoListModel : public QAbstractListModel
{
    Q_OBJECT
    enum{
        NumberRole = Qt::UserRole+1,
        PlayerColorRole,
        PlayerPositionRole,
        BodyAngleRole,
        NeckAngleRole
    };
public:
    LiveMatchPlayerInfoListModel(QObject* parent = nullptr);
    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    QHash<int, QByteArray> roleNames() const override;
    int count() const;
    void setCount(int count);

public slots:
    QList<LiveMatchPlayerInfo *> liveMatchPlayerInfo() const;
    void setLiveMatchPlayerInfo(QList<LiveMatchPlayerInfo*> liveMatchPlayers);
    void clear();
    void modifyItem(LiveMatchPlayerInfo* newvalue, int i);

    LiveMatchPlayerInfo *liveMatchPlayerInfo(int number);
    LiveMatchPlayerInfo *at(int index);

private:
    QList<LiveMatchPlayerInfo*>  m_Players;
    int m_count;
};

#endif // LIVEMATCHPLAYERINFOLISTMODEL_H
