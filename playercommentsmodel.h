#ifndef PLAYERCOMMENTSMODEL_H
#define PLAYERCOMMENTSMODEL_H

#include <QAbstractListModel>
#include "playercomment.h"

class playerCommentsModel : public QAbstractListModel
{
    Q_OBJECT
    enum{
        IdRole = Qt::UserRole+1,
        PlayerId,
        DateTimeRole,
        MessageRateRole,
        MessageRole
    };

public:
    explicit playerCommentsModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex& index, const QVariant& value, int role = Qt::EditRole) override;

    virtual QHash<int, QByteArray> roleNames() const override;

    int count() const;
    void setCount(int count);

public slots:
    QList<PlayerComment *> playerComment() const;
    void setplayerComment(QList<PlayerComment *> playerComment);
    void clear();

    PlayerComment *playerComment(int id);
    PlayerComment *at(int index);

signals:
//    void countChanged(int);

private:
    QList<PlayerComment *> m_PlayerComment;
    int m_count;

};

#endif // PLAYERCOMMENTSMODEL_H
