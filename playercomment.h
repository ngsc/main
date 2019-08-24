#ifndef PLAYERCOMMENT_H
#define PLAYERCOMMENT_H

#include <QObject>
#include <QDateTime>

class PlayerComment : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int id READ id NOTIFY idChanged)
    Q_PROPERTY(int playerId READ playerId)
    Q_PROPERTY(int messageRate READ messageRate NOTIFY messageRateChanged)
    Q_PROPERTY(QDateTime dateTime READ dateTime NOTIFY dateTimeChanged)
    Q_PROPERTY(QString message READ message NOTIFY messageChanged)

public:
    explicit PlayerComment(QObject *parent = nullptr);

    void setId(int id);
    int id() const;

    void setPlayerId(int playerid);
    int playerId() const;

    void setmessageRate(int messageRate);
    int messageRate() const;

    void setMessage(const QString &message);
    QString message()const;

    QDateTime dateTime() const;
    void setDateTime(const QDateTime &dateTime);

    std::string splitInLines(std::string source, std::size_t width);

signals:
    void idChanged(int id);
    void messageRateChanged(int messageRate);
    void dateTimeChanged(QDateTime dt);
    void messageChanged(QString message);

private:

    int m_id;
    int m_messageRate;
    int m_playerId;
    QDateTime m_dateTime;
    QString m_message;

};

#endif // PLAYERCOMMENT_H
