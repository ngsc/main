#ifndef CLUB_H
#define CLUB_H

#include <QObject>

class Club : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString division READ division WRITE setDivision NOTIFY divisionChanged)
    Q_PROPERTY(int rep READ rep WRITE setRep NOTIFY repChanged)
    Q_PROPERTY(double avAge READ avAge WRITE setAvAge NOTIFY avAgeChanged)
    Q_PROPERTY(int balance READ balance WRITE setBalance NOTIFY balanceChanged)
    Q_PROPERTY(int trnBudgetS READ trnBudgetS WRITE setTrnBudgetS NOTIFY trnBudgetSChanged)
    Q_PROPERTY(int trnBudgetR READ trnBudgetR WRITE setTrnBudgetR NOTIFY trnBudgetRChanged)
    Q_PROPERTY(int wageBudget READ wageBudget WRITE setWageBudget NOTIFY wageBudgetChanged)
    Q_PROPERTY(QString status READ status WRITE setStatus NOTIFY statusChanged)
    Q_PROPERTY(int tf READ tf WRITE setTf NOTIFY tfChanged)
    Q_PROPERTY(int yf READ yf WRITE setYf NOTIFY yfChanged)
    Q_PROPERTY(int ya READ ya WRITE setYa NOTIFY yaChanged)
    Q_PROPERTY(int stadCap READ stadCap WRITE setStadCap NOTIFY stadCapChanged)
    Q_PROPERTY(int avAtt READ avAtt WRITE setAvAtt NOTIFY avAttChanged)
    Q_PROPERTY(int minAtt READ minAtt WRITE setMinAtt NOTIFY minAttChanged)
    Q_PROPERTY(int maxAtt READ maxAtt WRITE setMaxAtt NOTIFY maxAttChanged)
    Q_PROPERTY(int rating READ rating WRITE setRating NOTIFY ratingChanged)
    Q_PROPERTY(double potRating READ potRating WRITE setPotRating NOTIFY potRatingChanged)
    Q_PROPERTY(int divisionId READ divisionId WRITE setDivisionId NOTIFY divisionIdChanged)
    Q_PROPERTY(QString foreground1 READ foreground1 WRITE setForeground1 NOTIFY foreground1Changed)
    Q_PROPERTY(QString background1 READ background1 WRITE setBackground1 NOTIFY background1Changed)
    Q_PROPERTY(QString foreground2 READ foreground2 WRITE setForeground2 NOTIFY foreground2Changed)
    Q_PROPERTY(QString background2 READ background2 WRITE setBackground2 NOTIFY background2Changed)
    Q_PROPERTY(QString foreground3 READ foreground3 WRITE setForeground3 NOTIFY foreground3Changed)
    Q_PROPERTY(QString background3 READ background3 WRITE setBackground3 NOTIFY background3Changed)
    Q_PROPERTY(QString foreground1Value READ foreground1Value WRITE setForeground1Value NOTIFY foreground1ValueChanged)
    Q_PROPERTY(QString background1Value READ background1Value WRITE setBackground1Value NOTIFY background1ValueChanged)
    Q_PROPERTY(QString foreground2Value READ foreground2Value WRITE setForeground2Value NOTIFY foreground2ValueChanged)
    Q_PROPERTY(QString background2Value READ background2Value WRITE setBackground2Value NOTIFY background2ValueChanged)
    Q_PROPERTY(QString foreground3Value READ foreground3Value WRITE setForeground3Value NOTIFY foreground3ValueChanged)
    Q_PROPERTY(QString background3Value READ background3Value WRITE setBackground3Value NOTIFY background3ValueChanged)
    Q_PROPERTY(QString favourite1 READ favourite1 WRITE setFavourite1 NOTIFY favourite1Changed)
    Q_PROPERTY(QString favourite2 READ favourite2 WRITE setFavourite2 NOTIFY favourite2Changed)
    Q_PROPERTY(QString favourite3 READ favourite3 WRITE setFavourite3 NOTIFY favourite3Changed)
    Q_PROPERTY(QString dislike1 READ dislike1 WRITE setDislike1 NOTIFY dislike1Changed)
    Q_PROPERTY(QString dislike2 READ dislike2 WRITE setDislike2 NOTIFY dislike2Changed)
    Q_PROPERTY(QString dislike3 READ dislike3 WRITE setDislike3 NOTIFY dislike3Changed)
    Q_PROPERTY(QString rival1 READ rival1 WRITE setRival1 NOTIFY rival1Changed)
    Q_PROPERTY(QString rival2 READ rival2 WRITE setRival2 NOTIFY rival2Changed)
    Q_PROPERTY(QString rival3 READ rival3 WRITE setRival3 NOTIFY rival3Changed)
    Q_PROPERTY(int ownerId READ ownerId WRITE setOwnerId NOTIFY ownerIdChanged)
    Q_PROPERTY(QString ownerName READ ownerName WRITE setOwnerName NOTIFY ownerNameChanged)
    Q_PROPERTY(QString nation READ nation CONSTANT)
    Q_PROPERTY(int leagueId READ leagueId CONSTANT)



public:
    explicit Club(QObject *parent = nullptr);

    int id() const;
    void setId(int id);

    QString name() const;
    void setName(const QString &name);

    QString division() const;
    void setDivision(const QString &division);

    int rep() const;
    void setRep(int rep);

    double avAge() const;
    void setAvAge(double avAge);

    int balance() const;
    void setBalance(int balance);

    int trnBudgetS() const;
    void setTrnBudgetS(int trnBudgetS);

    int trnBudgetR() const;
    void setTrnBudgetR(int trnBudgetR);

    int wageBudget() const;
    void setWageBudget(int wageBudget);

    QString status() const;
    void setStatus(const QString &status);

    int tf() const;
    void setTf(int tf);

    int yf() const;
    void setYf(int yf);

    int ya() const;
    void setYa(int ya);

    int stadCap() const;
    void setStadCap(int stadCap);

    int avAtt() const;
    void setAvAtt(int avAtt);

    int minAtt() const;
    void setMinAtt(int minAtt);

    int maxAtt() const;
    void setMaxAtt(int maxAtt);

    int rating() const;
    void setRating(int rating);

    double potRating() const;
    void setPotRating(double potRating);

    int divisionId() const;
    void setDivisionId(int divisionId);

    QString foreground1() const;
    void setForeground1(const QString &foreground1);

    QString background1() const;
    void setBackground1(const QString &background1);

    QString foreground2() const;
    void setForeground2(const QString &foreground2);

    QString background2() const;
    void setBackground2(const QString &background2);

    QString foreground3() const;
    void setForeground3(const QString &foreground3);

    QString background3() const;
    void setBackground3(const QString &background3);

    QString favourite1() const;
    void setFavourite1(const QString &favourite1);

    QString favourite2() const;
    void setFavourite2(const QString &favourite2);

    QString favourite3() const;
    void setFavourite3(const QString &favourite3);

    QString dislike1() const;
    void setDislike1(const QString &dislike1);

    QString dislike2() const;
    void setDislike2(const QString &dislike2);

    QString dislike3() const;
    void setDislike3(const QString &dislike3);

    QString rival1() const;
    void setRival1(const QString &rival1);

    QString rival2() const;
    void setRival2(const QString &rival2);

    QString rival3() const;
    void setRival3(const QString &rival3);

    QString foreground1Value() const;
    void setForeground1Value(const QString &foreground1Value);

    QString background1Value() const;
    void setBackground1Value(const QString &background1Value);

    QString foreground2Value() const;
    void setForeground2Value(const QString &foreground2Value);

    QString background2Value() const;
    void setBackground2Value(const QString &background2Value);

    QString foreground3Value() const;
    void setForeground3Value(const QString &foreground3Value);

    QString background3Value() const;
    void setBackground3Value(const QString &background3Value);


    int ownerId() const;
    void setOwnerId(int ownerId);

    QString ownerName() const;
    void setOwnerName(const QString &ownerName);

    QString nation() const;
    void setNation(const QString &nation);

    int leagueId() const;
    void setLeagueId(int leagueId);

signals:
    void idChanged(int id);
    void nameChanged(QString name);
    void divisionChanged(QString division);
    void repChanged(int rep);
    void avAgeChanged(double avAge);
    void balanceChanged(int balance);
    void trnBudgetSChanged(int trnBudgetS);
    void trnBudgetRChanged(int trnBudgetS);
    void wageBudgetChanged(int wageBudget);
    void statusChanged(QString status);
    void tfChanged(int tf);
    void yfChanged(int yf);
    void yaChanged(int ya);
    void stadCapChanged(int stadCap);
    void avAttChanged(int avAtt);
    void minAttChanged(int minAtt);
    void maxAttChanged(int maxAtt);
    void ratingChanged(int rating);
    void potRatingChanged(double potRating);
    void divisionIdChanged(int divisionId);
    void foreground1Changed(QString foreground1);
    void foreground2Changed(QString foreground2);
    void foreground3Changed(QString foreground3);
    void background1Changed(QString background1);
    void background2Changed(QString background2);
    void background3Changed(QString background3);
    void foreground1ValueChanged(QString foreground1Value);
    void foreground2ValueChanged(QString foreground2Value);
    void foreground3ValueChanged(QString foreground3Value);
    void background1ValueChanged(QString background1Value);
    void background2ValueChanged(QString background2Value);
    void background3ValueChanged(QString background3Value);
    void favourite1Changed(QString favourite1);
    void favourite2Changed(QString favourite2);
    void favourite3Changed(QString favourite3);
    void dislike1Changed(QString dislike1);
    void dislike2Changed(QString dislike2);
    void dislike3Changed(QString dislike3);
    void rival1Changed(QString rival1);
    void rival2Changed(QString rival2);
    void rival3Changed(QString rival3);
    void ownerIdChanged(int ownerId);
    void ownerNameChanged(QString ownerName);

public slots:

private:
    int m_id;
    QString m_name;
    QString m_nation;
    QString m_division;
    int m_rep;
    double m_avAge;
    int m_balance;
    int m_trnBudgetS;
    int m_trnBudgetR;
    int m_wageBudget;
    QString m_status;
    int m_tf;
    int m_yf;
    int m_ya;
    int m_stadCap;
    int m_avAtt;
    int m_minAtt;
    int m_maxAtt;
    int m_rating;
    double m_potRating;
    int m_divisionId;
    QString m_foreground1;
    QString m_background1;
    QString m_foreground2;
    QString m_background2;
    QString m_foreground3;
    QString m_background3;
    QString m_foreground1Value;
    QString m_background1Value;
    QString m_foreground2Value;
    QString m_background2Value;
    QString m_foreground3Value;
    QString m_background3Value;
    QString m_favourite1;
    QString m_favourite2;
    QString m_favourite3;
    QString m_dislike1;
    QString m_dislike2;
    QString m_dislike3;
    QString m_rival1;
    QString m_rival2;
    QString m_rival3;

    int m_ownerId;
    QString m_ownerName;
    int m_leagueId;

};

#endif // CLUB_H
