#ifndef USER_H
#define USER_H

#include <QObject>
class Club;

class User : public QObject
{
    Q_OBJECT

public:
    Q_PROPERTY(int id READ id WRITE setClubId NOTIFY idChanged)
    Q_PROPERTY(QString token READ token WRITE setToken NOTIFY tokenChanged)
    Q_PROPERTY(QString username READ username WRITE setUsername)
    Q_PROPERTY(QString userPortrait READ UserPortrait WRITE setUserPortrait)
    Q_PROPERTY(QString password READ password WRITE setPassword)
    Q_PROPERTY(bool quizPass READ quizPass WRITE setQuizPass NOTIFY quizPassChanged)
    Q_PROPERTY(QString firstName READ firstName WRITE setFirstName NOTIFY firstNameChanged)
    Q_PROPERTY(QString lastName READ lastName WRITE setLastName NOTIFY lastNameChanged)
    Q_PROPERTY(QString nickName READ nickName WRITE setNickName NOTIFY nickNameChanged)
    Q_PROPERTY(int clubId READ clubId WRITE setClubId NOTIFY clubIdChanged)
    Q_PROPERTY(QString clubName READ clubName WRITE setClubName NOTIFY clubNameChanged)
    Q_PROPERTY(QString city READ city WRITE setCity NOTIFY cityChanged)
    Q_PROPERTY(QString favFormation READ favFormation WRITE setFavFormation NOTIFY favFormationChanged)
    Q_PROPERTY(Club* club READ club WRITE setClub NOTIFY clubChanged)

    explicit User(QObject *parent = nullptr);

    int id() const;
    void setId(int id);

    QString username() const;
    void setUsername(const QString &username);

    QString password() const;
    void setPassword(const QString &password);

    QString token() const;
    void setToken(const QString &token);

    bool quiz_pass() const;

    bool quizPass() const;
    void setQuizPass(bool quizPass);

    QString firstName() const;
    void setFirstName(const QString &firstName);

    QString lastName() const;
    void setLastName(const QString &lastName);

    QString nickName() const;
    void setNickName(const QString &nickName);

    int clubId() const;
    void setClubId(int clubId);

    QString city() const;
    void setCity(const QString &city);

    QString favFormation() const;
    void setFavFormation(const QString &favFormation);

    QString clubName() const;
    void setClubName(const QString &clubName);

    QString UserPortrait() const;
    void setUserPortrait(const QString &userPortrait);

    Club *club() const;
    void setClub(Club *club);

signals:
    void idChanged(int id);
    void tokenChanged(QString token);
    void quizPassChanged(bool pass);
    void firstNameChanged(QString firstName);
    void lastNameChanged(QString lastName);
    void nickNameChanged(QString nickName);
    void clubIdChanged(int clubId);
    void clubNameChanged(QString clubName);
    void cityChanged(QString city);
    void favFormationChanged(QString formation);
    void clubChanged(Club *club);

public slots:

   void setUser(User* user);
   void printDetails();

private:
    int m_id;
    QString m_firstName;
    QString m_lastName;
    QString m_nickName;

    QString m_username;
    QString m_password;
    QString m_token;
    bool m_quizPass;

    int m_clubId;     //selected clubId for user
    QString m_clubName;

    QString m_city;
    QString m_favFormation;

    QString m_UserPortrait;
    Club* m_club = nullptr;    //current club owned by the user
};

#endif // USER_H
