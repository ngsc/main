#include "club.h"

Club::Club(QObject *parent) : QObject(parent)
{

}

int Club::id() const
{
    return m_id;
}

void Club::setId(int id)
{
    m_id = id;
    emit idChanged(id);
}

QString Club::name() const
{
    return m_name;
}

void Club::setName(const QString &name)
{
    m_name = name;
    emit nameChanged(name);
}

QString Club::division() const
{
    return m_division;
}

void Club::setDivision(const QString &division)
{
    m_division = division;
    emit divisionChanged(division);
}

int Club::rep() const
{
    return m_rep;
}

void Club::setRep(int rep)
{
    m_rep = rep;
    emit repChanged(rep);
}

double Club::avAge() const
{
    return m_avAge;
}

void Club::setAvAge(double avAge)
{
    m_avAge = avAge;
    emit avAgeChanged(avAge);
}

int Club::balance() const
{
    return m_balance;
}

void Club::setBalance(int balance)
{
    m_balance = balance;
    emit balanceChanged(balance);
}

int Club::trnBudgetS() const
{
    return m_trnBudgetS;
}

void Club::setTrnBudgetS(int trnBudgetS)
{
    m_trnBudgetS = trnBudgetS;
    emit trnBudgetSChanged(trnBudgetS);
}

int Club::trnBudgetR() const
{
    return m_trnBudgetR;
}

void Club::setTrnBudgetR(int trnBudgetR)
{
    m_trnBudgetR = trnBudgetR;
    emit trnBudgetRChanged(trnBudgetR);
}

int Club::wageBudget() const
{
    return m_wageBudget;
}

void Club::setWageBudget(int wageBudget)
{
    m_wageBudget = wageBudget;
    emit wageBudgetChanged(wageBudget);
}

QString Club::status() const
{
    return m_status;
}

void Club::setStatus(const QString &status)
{
    m_status = status;
    emit statusChanged(status);
}

int Club::tf() const
{
    return m_tf;
}

void Club::setTf(int tf)
{
    m_tf = tf;
    emit tfChanged(tf);
}

int Club::yf() const
{
    return m_yf;
}

void Club::setYf(int yf)
{
    m_yf = yf;
    emit yfChanged(yf);
}

int Club::ya() const
{
    return m_ya;
}

void Club::setYa(int ya)
{
    m_ya = ya;
    emit yaChanged(ya);
}

int Club::stadCap() const
{
    return m_stadCap;
}

void Club::setStadCap(int stadCap)
{
    m_stadCap = stadCap;
    emit stadCapChanged(stadCap);
}

int Club::avAtt() const
{
    return m_avAtt;
}

void Club::setAvAtt(int avAtt)
{
    m_avAtt = avAtt;
    emit avAttChanged(avAtt);
}

int Club::minAtt() const
{
    return m_minAtt;
}

void Club::setMinAtt(int minAtt)
{
    m_minAtt = minAtt;
    emit minAttChanged(minAtt);
}

int Club::maxAtt() const
{
    return m_maxAtt;
}

void Club::setMaxAtt(int maxAtt)
{
    m_maxAtt = maxAtt;
    emit maxAttChanged(maxAtt);
}

int Club::rating() const
{
    return m_rating;
}

void Club::setRating(int rating)
{
    m_rating = rating;
    emit ratingChanged(rating);
}

double Club::potRating() const
{
    return m_potRating;
}

void Club::setPotRating(double potRating)
{
    m_potRating = potRating;
    emit potRatingChanged(potRating);
}

int Club::divisionId() const
{
    return m_divisionId;
}

void Club::setDivisionId(int divisionId)
{
    m_divisionId = divisionId;
    emit divisionIdChanged(divisionId);
}

QString Club::foreground1() const
{
    return m_foreground1;
}

void Club::setForeground1(const QString &foreground1)
{
    m_foreground1 = foreground1;
    emit foreground1Changed(foreground1);
}

QString Club::background1() const
{
    return m_background1;
}

void Club::setBackground1(const QString &background1)
{
    m_background1 = background1;
    emit background1Changed(background1);
}

QString Club::foreground2() const
{
    return m_foreground2;
}

void Club::setForeground2(const QString &foreground2)
{
    m_foreground2 = foreground2;
    emit foreground2Changed(foreground2);
}

QString Club::background2() const
{
    return m_background2;
}

void Club::setBackground2(const QString &background2)
{
    m_background2 = background2;
}

QString Club::foreground3() const
{
    return m_foreground3;
}

void Club::setForeground3(const QString &foreground3)
{
    m_foreground3 = foreground3;
}

QString Club::background3() const
{
    return m_background3;
}

void Club::setBackground3(const QString &background3)
{
    m_background3 = background3;
}

QString Club::favourite1() const
{
    return m_favourite1;
}

void Club::setFavourite1(const QString &favourite1)
{
    m_favourite1 = favourite1;
}

QString Club::favourite2() const
{
    return m_favourite2;
}

void Club::setFavourite2(const QString &favourite2)
{
    m_favourite2 = favourite2;
}

QString Club::favourite3() const
{
    return m_favourite3;
}

void Club::setFavourite3(const QString &favourite3)
{
    m_favourite3 = favourite3;
}

QString Club::dislike1() const
{
    return m_dislike1;
}

void Club::setDislike1(const QString &dislike1)
{
    m_dislike1 = dislike1;
}

QString Club::dislike2() const
{
    return m_dislike2;
}

void Club::setDislike2(const QString &dislike2)
{
    m_dislike2 = dislike2;
}

QString Club::dislike3() const
{
    return m_dislike3;
}

void Club::setDislike3(const QString &dislike3)
{
    m_dislike3 = dislike3;
}

QString Club::rival1() const
{
    return m_rival1;
}

void Club::setRival1(const QString &rival1)
{
    m_rival1 = rival1;
}

QString Club::rival2() const
{
    return m_rival2;
}

void Club::setRival2(const QString &rival2)
{
    m_rival2 = rival2;
}

QString Club::rival3() const
{
    return m_rival3;
}

void Club::setRival3(const QString &rival3)
{
    m_rival3 = rival3;
}

QString Club::foreground1Value() const
{
    return m_foreground1Value;
}

void Club::setForeground1Value(const QString &foreground1Value)
{
    m_foreground1Value = foreground1Value;
}

QString Club::background1Value() const
{
    return m_background1Value;
}

void Club::setBackground1Value(const QString &background1Value)
{
    m_background1Value = background1Value;
}

QString Club::foreground2Value() const
{
    return m_foreground2Value;
}

void Club::setForeground2Value(const QString &foreground2Value)
{
    m_foreground2Value = foreground2Value;
}

QString Club::background2Value() const
{
    return m_background2Value;
}

void Club::setBackground2Value(const QString &background2Value)
{
    m_background2Value = background2Value;
}

QString Club::foreground3Value() const
{
    return m_foreground3Value;
}

void Club::setForeground3Value(const QString &foreground3Value)
{
    m_foreground3Value = foreground3Value;
}

QString Club::background3Value() const
{
    return m_background3Value;
}

void Club::setBackground3Value(const QString &background3Value)
{
    m_background3Value = background3Value;
}

int Club::ownerId() const
{
    return m_ownerId;
}

void Club::setOwnerId(int ownerId)
{
    m_ownerId = ownerId;
}

QString Club::ownerName() const
{
    return m_ownerName;
}

void Club::setOwnerName(const QString &ownerName)
{
    m_ownerName = ownerName;
}

QString Club::nation() const
{
    return m_nation;
}

void Club::setNation(const QString &nation)
{
    m_nation = nation;
}

int Club::leagueId() const
{
    return m_leagueId;
}

void Club::setLeagueId(int leagueId)
{
    m_leagueId = leagueId;
}

