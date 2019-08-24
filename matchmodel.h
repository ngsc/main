#ifndef MATCHMODEL_H
#define MATCHMODEL_H

#include <QAbstractListModel>
#include <match.h>

class MatchModel : public QAbstractListModel
{
    Q_OBJECT

    /*
        "id": "6",
        "home_club_id": "23325084",
        "away_club_id": "23147325",
        "date": "2019-02-22",
        "time": "15:00:00"
    */

    enum {
        IdRole = Qt::UserRole + 1,
        DateRole,
        TimeRole,
        HomeClubIdRole,
        HomeClubNameRole,
        AwayClubIdRole,
        AwayClubNameRole,
        DateTimeRole
    };

public:
    explicit MatchModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    virtual QHash<int, QByteArray> roleNames() const override;

public slots:
    void setMatches(QList<Match*> match);
    void clear();
    QList<Match*> matches();

private:
    QList<Match*> m_matches;
};

#endif // MATCHMODEL_H
