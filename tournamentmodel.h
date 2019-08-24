#ifndef TOURNAMENTMODEL_H
#define TOURNAMENTMODEL_H

#include <QAbstractListModel>
#include <tournament.h>

class TournamentModel : public QAbstractListModel
{
    Q_OBJECT

    enum {
        IdRole = Qt::UserRole+1,
        NameRole,
        StartDateRole
    };

public:
    explicit TournamentModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;

    //Qt::ItemFlags flags(const QModelIndex& index) const override;

    virtual QHash<int, QByteArray> roleNames() const override;

public slots:
    void setTournaments(QVector<Tournament*> tournaments);
    void clear();

private:
    QVector<Tournament*> m_tournaments;


};

#endif // TOURNAMENTMODEL_H
