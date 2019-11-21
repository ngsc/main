#ifndef TEAMTACTICMODEL_H
#define TEAMTACTICMODEL_H

#include <QAbstractListModel>
#include "teamtactic.h"

class TeamTacticModel : public QAbstractListModel
{
    Q_OBJECT
    enum{
        SelectedRole = Qt::UserRole+1,
        NameRole,
        TypeRole
    };

public:
    enum TacticType {
        OFFSIDETRAP = 1 << 0,
        HARDTACKLE = 1 << 1,
        HIGHLINECLOSINGDOWN = 1 << 2,
        OFFSIDELINE = 1 << 3,
        PREVENTPASS = 1 << 4,
        PREVENTINGCUTINSIDE = 1 << 5,
        TIGHTMARKING = 1 << 6,
        STOPSPLAY = 1 << 7,
        GETSFORWARD = 1 << 8,
        SHOOTFROMDISTANCE = 1 << 9,
        STAYBACK = 1 << 10,
        RUNDOWNTHELINE = 1 << 11,
        MOVESINTOCHANNELS = 1 << 12,
        PREFERDRIBBLEOVERPASS = 1 << 13,
        DICTATESTEMPO = 1 << 14,
        COMESDEEPTOGETBALL = 1 << 15,
        LONGPASSES = 1 << 16,
        ROUNDTOKEEPER = 1 << 17,
        BEATOFFSIDETRAP = 1 << 18,
        CUTINSIDE = 1 << 19,
        CROSSTHEBALLMOREOFTEN = 1 << 20,
        RUSHOUT = 1 << 21,
        FORWARDINCORNERKICK = 1 << 22,
        PASSBALLTODEFENDER = 1 << 23,
        TRIESKILLERBALLOFTEN = 1 << 24
    };
    static std::initializer_list<TacticType> all_teamTacticTypes;
    static std::string const all_teamTacticName[];
public:
    explicit TeamTacticModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex& index, const QVariant& value, int role = Qt::EditRole) override;

    virtual QHash<int, QByteArray> roleNames() const override;

    int count() const;
    void setCount(int count);

public slots:
    QList<TeamTactic *> teamTactics() const;
    void setTeamTactics(QList<TeamTactic *> teamTactics);
    void clear();

    TeamTactic *at(int index);


signals:
    void countChanged(int);

private:
    QList<TeamTactic *> m_teamTactics;
    int m_count;
};

#endif // TEAMTACTICMODEL_H
