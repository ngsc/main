#ifndef USERCOMMENTSMODEL_H
#define USERCOMMENTSMODEL_H

#include <QObject>
#include <QDateTime>
#include <QAbstractListModel>

class UserComment : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int id READ id NOTIFY idChanged)
    Q_PROPERTY(int userId READ userId)
    Q_PROPERTY(int messageRate READ messageRate NOTIFY messageRateChanged)
    Q_PROPERTY(QDateTime dateTime READ dateTime NOTIFY dateTimeChanged)
    Q_PROPERTY(QString message READ message NOTIFY messageChanged)

public:
    explicit UserComment(QObject *parent = nullptr);

    void setId(int id);
    int id() const;

    void setUserId(int userid);
    int userId() const;

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
    int m_UserId;
    QDateTime m_dateTime;
    QString m_message;

};



class UserCommentsModel : public QAbstractListModel
{
    Q_OBJECT
    enum{
        IdRole = Qt::UserRole+1,
        UserId,
        DateTimeRole,
        MessageRateRole,
        MessageRole
    };

public:
    explicit UserCommentsModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex& index, const QVariant& value, int role = Qt::EditRole) override;

    virtual QHash<int, QByteArray> roleNames() const override;

    int count() const;
    void setCount(int count);

public slots:
    QList<UserComment *> userComment() const;
    void setuserComment(QList<UserComment *> userComment);
    void clear();

    UserComment *userComment(int id);
    UserComment *at(int index);

signals:
//    void countChanged(int);

private:
    QList<UserComment *> m_UserComment;
    int m_count;
};

#endif // USERCOMMENTSMODEL_H
