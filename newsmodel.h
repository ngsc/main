#ifndef NEWSMODEL_H
#define NEWSMODEL_H

#include <QAbstractListModel>
#include <QJSValue>
#include "news.h"

class NewsModel : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(int count READ count NOTIFY countChanged)

    enum {
        IdRole = Qt::UserRole + 1,
        BriefRole,
        MessageRole,
        OfferIdRole,
        BiddingClubIdRole,
        OwnerClubIdRole,
        ReadRole,
        ActiveRole,
        RoleRole,
        StageRole,
        DateTimeRole
    };

public:
    explicit NewsModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex& index, const QVariant& value, int role = Qt::EditRole) override;

    virtual QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE QJSValue get(int idx) const;

    int count() const;
    void setCount(int count);

public slots:
    QList<News *> news() const;
    void setNews(const QList<News *> news);
    void clear();

    News *news(int id);
    News *at(int index);

    bool containsUnread();

signals:
    void countChanged(int count);

private:
    QList<News *> m_news;
    int m_count;

};

#endif // NEWSMODEL_H
