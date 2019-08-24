#ifndef NOTIFICATION_H
#define NOTIFICATION_H

#include <QObject>
#include <QDate>

class Notification : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int id READ id CONSTANT)
    Q_PROPERTY(QDate date READ date CONSTANT)
    Q_PROPERTY(int status READ status WRITE setStatus NOTIFY statusChanged)
    Q_PROPERTY(int ownerClubId READ ownerClubId CONSTANT)
    Q_PROPERTY(QString ownerClubName READ ownerClubName CONSTANT)
    Q_PROPERTY(int biddingClubId READ biddingClubId CONSTANT)
    Q_PROPERTY(QString biddingClubName READ biddingClubName CONSTANT)
    Q_PROPERTY(QString title READ title CONSTANT)
    Q_PROPERTY(QString message READ message CONSTANT)


public:
    enum class Type {
        NEWS,
        NOTIFICATIONS
    };
    Q_ENUM(Type)

    explicit Notification(QObject *parent = nullptr);

    explicit Notification(QObject* parent, int id, QDate date, int status, int oci, QString ocn, int bci, QString bcn);

    int id() const;
    void setId(int id);

    QDate date() const;
    void setDate(const QDate &date);

    int status() const;
    void setStatus(int status);

    QString title() const;
    void setTitle(const QString &title);

    QString message() const;
    void setMessage(const QString &message);

    int ownerClubId() const;
    void setOwnerClubId(int ownerClubId);

    QString ownerClubName() const;
    void setOwnerClubName(const QString &ownerClubName);

    int biddingClubId() const;
    void setBiddingClubId(int biddingClubId);

    QString biddingClubName() const;
    void setBiddingClubName(const QString &biddingClubName);

signals:
    void statusChanged(int status);

public slots:

private:

    int m_id = 0;
    QDate m_date;
    int m_status = 0;    //read/ not read
    QString m_title;
    QString m_message;

    int m_ownerClubId = 0;
    QString m_ownerClubName;

    int m_biddingClubId = 0;
    QString m_biddingClubName;
};

#endif // NOTIFICATION_H
