#ifndef NOTIFICATIONMODEL_H
#define NOTIFICATIONMODEL_H

#include <QAbstractListModel>
#include "notification.h"

class NotificationModel : public QAbstractListModel
{
    Q_OBJECT

    enum {
        IdRole = Qt::UserRole + 1,
        StatusRole,
        DateRole,
        BiddingClubIdRole,
        BiddingClubNameRole,
        OwnerClubIdRole,
        OwnerClubNameRole
    };

public:
    explicit NotificationModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    virtual QHash<int, QByteArray> roleNames() const override;

public slots:
    void setNotifications(QList<Notification*> notifications);
    void clear();
    QList<Notification *> notifications();

private:
    QList<Notification*> m_notifications;
};

#endif // NOTIFICATIONMODEL_H
