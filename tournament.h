#ifndef TOURNAMENT_H
#define TOURNAMENT_H

#include <QObject>
#include <QDate>

class Tournament : public QObject
{
    Q_OBJECT
public:
    explicit Tournament(QObject *parent = nullptr);
    explicit Tournament(int id, const QString& name, const QDate& date);

    int id() const;
    void setId(int id);

    QString name() const;
    void setName(const QString &name);

    QDate startDate() const;
    void setStartDate(const QDate &startDate);

signals:

public slots:

private:

    int m_id;
    QString m_name;
    QDate m_startDate;
};

#endif // TOURNAMENT_H
