#ifndef ONLINEUSERSMODEL_H
#define ONLINEUSERSMODEL_H

#include <QAbstractListModel>
//This is a stripped down version of the user. containing a subset of users properties
class SimpleUser : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int userId READ userId CONSTANT)
    Q_PROPERTY(QString username READ username CONSTANT)
    Q_PROPERTY(QString firstName READ firstName CONSTANT)
    Q_PROPERTY(QString lastName READ lastName CONSTANT)
    Q_PROPERTY(int clubId READ clubId CONSTANT)
    Q_PROPERTY(QString clubName READ clubName CONSTANT)
    Q_PROPERTY(bool online READ online WRITE setOnline NOTIFY onlineChanged)

public:
    explicit SimpleUser(QObject* parent = nullptr);

    int userId() const;
    void setUserId(int userId);

    QString username() const;
    void setUsername(const QString &username);

    QString firstName() const;
    void setFirstName(const QString &firstName);

    QString lastName() const;
    void setLastName(const QString &lastName);

    int clubId() const;
    void setClubId(int clubId);

    QString clubName() const;
    void setClubName(const QString &clubName);

    bool online() const;
    void setOnline(bool online);

signals:
   void onlineChanged(bool online);

private:
    int m_userId;
    QString m_username;

    QString m_firstName;
    QString m_lastName;

    int m_clubId;
    QString m_clubName;

    bool m_online;
};

class SimpleUserModel : public QAbstractListModel
{
    Q_OBJECT

    enum {
        UserIdRole = Qt::UserRole+1,
        UserNameRole,
        UserFirstNameRole,
        UserLastNameRole,
        ClubIdRole,
        ClubNameRole,
        OnlineRole
    };


public:
    explicit SimpleUserModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    virtual QHash<int, QByteArray> roleNames() const override;

public slots:
    void setUsers(QList<SimpleUser *> users, QString currentUsername);
    void clear();

private:
    QList<SimpleUser*> m_users;
};

#endif // ONLINEUSERSMODEL_H
