#ifndef ANNOUNCEMENTMODEL_H
#define ANNOUNCEMENTMODEL_H

#include <QAbstractListModel>
#include "announcement.h"

class AnnouncementModel : public QAbstractListModel
{
    Q_OBJECT
    enum{
        IdRole = Qt::UserRole+1,
        FontStyleRole,
        FontSizeRole,
        FontBackGroundRole,
        FontDifferenceRole,
        FontColorRole,
        MessageTypeRole,
        MessageRole
    };

public:
    explicit AnnouncementModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex& index, const QVariant& value, int role = Qt::EditRole) override;

    virtual QHash<int, QByteArray> roleNames() const override;

    int count() const;
    void setCount(int count);

public slots:
    QList<Announcement *> announcement() const;
    void setAnnouncement(QList<Announcement *> announcement);
    void clear();

    Announcement *announcement(int id);
    Announcement *at(int index);


signals:
//    void countChanged(int);

private:
    QList<Announcement *> m_Announcement;
    int m_count;
};

#endif // ANNOUNCEMENTMODEL_H
