#include "user.h"
#include "club.h"
#include <QDebug>

User::User(QObject *parent) : QObject(parent)
{

}

QString User::username() const
{
    return m_username;
}

void User::setUsername(const QString &username)
{
    m_username = username;
}

QString User::password() const
{
    return m_password;
}

void User::setPassword(const QString &password)
{
    m_password = password;
}

QString User::token() const
{
    return m_token;
}

void User::setToken(const QString &token)
{
    m_token = token;
}

bool User::quizPass() const
{
    return m_quizPass;
}

void User::setQuizPass(bool quizPass)
{
    m_quizPass = quizPass;
    emit quizPassChanged(quizPass);
}

QString User::firstName() const
{
    return m_firstName;
}

void User::setFirstName(const QString &firstName)
{
    m_firstName = firstName;
    emit firstNameChanged(firstName);
}

QString User::lastName() const
{
    return m_lastName;
}

void User::setLastName(const QString &lastName)
{
    m_lastName = lastName;
    emit lastNameChanged(lastName);
}

QString User::nickName() const
{
    return m_nickName;
}

void User::setNickName(const QString &nickName)
{
    m_nickName = nickName;
    emit nickNameChanged(nickName);
}

int User::clubId() const
{
    return m_clubId;
}

void User::setClubId(int clubId)
{
    m_clubId = clubId;
    emit clubIdChanged(clubId);
}

QString User::clubName() const
{
    return m_clubName;
}

void User::setClubName(const QString &clubName)
{
    m_clubName = clubName;
    emit clubNameChanged(clubName);
}

QString User::UserPortrait() const
{
    return m_UserPortrait;
}

void User::setUserPortrait(const QString &userPortrait)
{
    m_UserPortrait = userPortrait;
}

QString User::city() const
{
    return m_city;
}

void User::setCity(const QString &city)
{
    m_city = city;
    emit cityChanged(city);
}

QString User::favFormation() const
{
    return m_favFormation;
}

void User::setFavFormation(const QString &favFormation)
{
    m_favFormation = favFormation;
}

void User::printDetails()
{
    qDebug() << "usename: " << m_username;
    qDebug() << "password: " << m_password;
    qDebug() << "firstName: " << m_firstName;
    qDebug() << "lastName: " << m_lastName;
    qDebug() << "pass quiz: " << m_quizPass;
    qDebug() << "clubId: " << m_clubId;
    qDebug() << "UserPortrait: " << m_UserPortrait;
    qDebug() << "city: " << m_city;
    qDebug() << "clubName: " << m_clubName;
    qDebug() << "ID: " << m_id;
    qDebug() << "token: " << m_token;

}

int User::id() const
{
    return m_id;
}

void User::setId(int id)
{
    m_id = id;
    emit idChanged(id);
}

Club* User::club() const
{
    return m_club;
}

void User::setClub(Club *club)
{
    if(m_club)
    {
        delete m_club;
        m_club = nullptr;
    }

    m_club = club;
    m_club->setParent(this);
    emit clubChanged(m_club);
}

void User::setUser(User *user)
{
    if(!user)
        return;

    m_id = user->id();
    m_firstName = user->firstName();
    m_lastName = user->lastName();
    m_nickName = user->nickName();

    m_username = user->username();
    m_password = user->password();
    m_token = user->token();
    setQuizPass(user->quizPass());

    m_clubId = user->clubId();     //selected clubId for user
    m_clubName = user->clubName();

    m_city = user->city();
    m_favFormation = user->favFormation();
    m_UserPortrait = user->UserPortrait ();
}
