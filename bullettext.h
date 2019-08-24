#ifndef BULLETTEXT_H
#define BULLETTEXT_H

#include <QDateTime>
#include <QObject>

class BulletText : public QObject
{
    Q_OBJECT
public:
    explicit BulletText(QObject *parent = nullptr);

    int id() const;
    void setId(int id);

    int userId() const;
    void setUserId(int userid);

    QString comment() const;
    void setComment(QString &comment);

    QDateTime dateTime() const;
    void setDateTime(const QDateTime &dateTime);

private:

    int m_id;
    int m_UserId;
    QString m_Comment;
    QDateTime m_DateTime;
};

#endif // BULLETTEXT_H
