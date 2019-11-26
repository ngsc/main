#ifndef INVITATION_H
#define INVITATION_H

#include <QObject>
#include <QDate>
#include <QTime>

//{"Invitation":{"id":"13","home_user_id":"15","away_user_id":"16","home_user_club_id":"1139",
//"away_user_club_id":"907","status":"1","created_time":"2019-01-17 11:44:59"},
//"HomeClub":{"id":"1139","name":"Juventus"},"AwayClub":{"id":"907","name":"Dortmund"}}

class Invitation : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int id READ id CONSTANT)
    Q_PROPERTY(int homeUserId READ homeUserId CONSTANT)
    Q_PROPERTY(int awayUserId READ awayUserId CONSTANT)
    Q_PROPERTY(QString homeClubName READ homeClubName CONSTANT)
    Q_PROPERTY(QString awayClubName READ awayClubName CONSTANT)
    Q_PROPERTY(int homeClubId READ homeClubId CONSTANT)
    Q_PROPERTY(int awayClubId READ awayClubId CONSTANT)
    Q_PROPERTY(QString status READ status WRITE setStatus NOTIFY statusChanged)
    Q_PROPERTY(QDateTime date READ date)

public:
    explicit Invitation(QObject *parent = nullptr);

    int id() const;
    void setId(int id);

    int homeUserId() const;
    void setHomeUserId(int homeUserId);

    int awayUserId() const;
    void setAwayUserId(int awayUserId);

    QString homeClubName() const;
    void setHomeClubName(const QString &homeClubName);

    QString awayClubName() const;
    void setAwayClubName(const QString &awayClubName);

    int homeClubId() const;
    void setHomeClubId(int homeClubId);

    int awayClubId() const;
    void setAwayClubId(int awayClubId);

    QDateTime date() const;
    void setDate(const QDateTime &date);

    QString status() const;
    void setStatus(QString status);

signals:

    void statusChanged();

private:
    int m_id;
    int m_homeUserId;
    int m_awayUserId;
    QString m_homeClubName;
    QString m_awayClubName;
    int m_homeClubId;
    int m_awayClubId;
    QString m_status;
    QDateTime m_date;
};

#endif // INVITATION_H
