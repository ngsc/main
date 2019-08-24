#ifndef HISTORYBRIEF_H
#define HISTORYBRIEF_H
#include <QAbstractListModel>
#include <QObject>

class UserHistory : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int userId READ userId CONSTANT)
    Q_PROPERTY(int userIndex READ userIndex CONSTANT)
    Q_PROPERTY(QString username READ username CONSTANT)
    Q_PROPERTY(QString firstName READ firstName CONSTANT)
    Q_PROPERTY(QString lastName READ lastName CONSTANT)
    Q_PROPERTY(int clubId READ clubId CONSTANT)
    Q_PROPERTY(QString clubName READ clubName CONSTANT)
    Q_PROPERTY(bool online READ online WRITE setOnline NOTIFY onlineChanged)
    Q_PROPERTY(bool isVisible READ isVisible)

public:
    explicit UserHistory(QObject* parent = nullptr);

    int userId() const;
    void setUserId(int userId);

    int userIndex() const;
    void setUserIndex(int userIndex);

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

    bool isVisible() const;
    void setVisible(bool check);

signals:
   void onlineChanged(bool online);

private:
    int m_userId;
    int m_userIndex;
    QString m_username;

    QString m_firstName;
    QString m_lastName;

    int m_clubId;
    QString m_clubName;

    bool m_online;
    bool m_IsVisible ;
};

class HistoryBrief : public QAbstractListModel
{
    Q_OBJECT
        enum{
        HistoryIndex = Qt::UserRole+1,
        IdRole,
        UserNameRole,
        ClubNameRole,
        FirstNameRole,
        LastNameRole,
        OnlineRole,
        IsVisible
    };
public:
    explicit HistoryBrief(QObject *parent = nullptr);

        // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex& index, const QVariant& value, int role = Qt::EditRole) override;

    virtual QHash<int, QByteArray> roleNames() const override;

    int count() const;
    void setCount(int count);

signals:

public slots:
    QList<UserHistory *> userHistory() const;
    void setUserHistory(QList<UserHistory *> userHistory ,QString currentUsername);
    void clear();

    UserHistory *userHistory(int id);
    UserHistory *at(int index);

private:
    QList<UserHistory*> m_users;
//    QVector<UserHistory*> m_Allusers;
    int m_count;
};

#endif // HISTORYBRIEF_H
