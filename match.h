#ifndef MATCH_H
#define MATCH_H

#include <QObject>
#include <QDate>


/*
      "Match": {
        "id": "6",
        "home_club_id": "23325084",
        "away_club_id": "23147325",
        "date": "2019-02-22",
        "time": "15:00:00"
      },
      "HomeClub": {
        "name": "Quanjian"
      },
      "AwayClub": {
        "name": "Fuli"
      }
*/
class Match : public QObject
{
    Q_OBJECT
public:
    Match(QObject *parent = nullptr);

    int id() const;
    void setId(int id);

    QString homeClubName() const;
    void setHomeClubName(const QString &homeClubName);

    QString awayClubName() const;
    void setAwayClubName(const QString &awayClubName);

    int homeClubId() const;
    void setHomeClubId(int homeClubId);

    int awayClubId() const;
    void setAwayClubId(int awayClubId);

    QDate date() const;
    void setDate(const QDate &date);

    QTime time() const;
    void setTime(const QTime &time);

private:

    int m_id;
    QString m_homeClubName;
    QString m_awayClubName;
    int m_homeClubId;
    int m_awayClubId;
    QDate m_date;
    QTime m_time;

};

#endif // MATCH_H
