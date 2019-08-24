#ifndef APICONNECTION_H
#define APICONNECTION_H

#include <QObject>
#include <QNetworkAccessManager>

class Tournament;
class Club;
class Player;
class SearchingPoolPlayer;
class User;
class Notification;
class Match;
class SimpleUser;
class Invitation;
class News;

class APIConnection : public QObject
{
    Q_OBJECT

    enum class Operation {
        NO_OP,
        SIGN_IN,
        SIGN_UP,
        UPDATE_QUIZ_PASS,
        GET_TOURNAMENTS,
        GET_CLUB_PLAYERS,
        GET_ALL_PLAYERS,
        GET_CLUB_DETAILS,
        GET_CLUBS,
        GET_PLAYER_DETAILS,
        GET_LEAGUE_CLUBS,
        GET_CLUBS_BY_LEAGUE,
        UPDATE_USER_DETAILS,
        UPDATE_PLAYERS_POSITION,
        UPDATE_PLAYERS_NUMBER,
        GET_NOTIFICATIONS,
        GET_MATCHES,
        UPDATE_USER_ONLINE_STATUS,
        GET_USERS,
        INVITE_TO_MATCH,
        GET_INVITATIONS,
        ACCEPT_INVITATION,
        DECLINE_INVITATION,

        CREATE_OFFER,
        ACCEPT_OFFER,
        WITHDRAW_OFFER,
        REJECT_OFFER,
        NEGOTIATE_OFFER,

        GET_OFFER,
        GET_OFFER_WITH_PLAYER_DETAILS,

        CREATE_OFFER_CONTRACT,
        ACCEPT_OFFER_CONTRACT,
        TERMINATE_OFFER_CONTRACT,

        //GHANGE_TRANDFER_DETAILS,
        //GHANGE_LOAN_DETAILS,
        CHANGE_OFFER_DETAILS,
        GET_NEWS
    };

public:
    explicit APIConnection(QObject *parent = nullptr);

    static void setToken(QString& token);

    void parseJson(const QString& json);

signals:
    void replyAvailable(const QString& reply);
    void errorHappened(const QString& error);
    void messageReceived(const QString& message);


    void signupFinished(const QString& message);
    void signinFinished(const QString& message, User* user);
    void getTournamentsFinished(QVector<Tournament*> ts);
    void getPlayersFinished(QList<Player*> players);
    void getClubDetailsFinished(Club *club);
    void getClubsFinished(QVector<Club*> clubs);
    void getAllPlayersFinished(QList<SearchingPoolPlayer*> players);
    void getPlayerDetailsFinished(Player* player);
    void getNotificationsFinished(QList<Notification *> notifiations);
    void getMatchesFinished(QList<Match*> matches);
    void getUsersFinished(QList<SimpleUser*> users);
    void getInvitationsFinished(QList<Invitation *> invitations);

    void submitOfferFinished(int offer_id, int player_id, QString message);
    void withdrawOfferFinished(int offer_id, int player_id, QString message);

    void getTransferOfferFinished(int offer_id, int owner_club_id, int bidding_club_id, int player_id, int fees, int minimum_fee);
    void getTransferOfferWithPlayerDetailsFinished(int offer_id, Player* player, int oci, QString ocn, int bci, QString bcn, int fee);

    void getLoanOfferFinished(int offer_id, int owner_club_id, int bidding_club_id, int player_id, int fees, int minimum_fee);
    void getLoanOfferWithPlayerDetailsFinished(int offer_id, Player* player, int oci, QString ocn, int bci, QString bcn, int fee,
                 int future_fee, int wages, QString duration, QString duration_type, bool can_play_in_cup, bool can_play_against, bool can_be_recalled);

    void getNewsFinished(QList<News*> news);

public slots:

    void signIn(const QString& username, const QString& password);
    void signUp(const QString& email, const QString& username, const QString& password);
    void updateQuizPass(const QString& token, bool success = true);
    void updateUser(User* user);
    void getTournaments(const QString& token);
    void getClubPlayers(const QString& token, int club_id);
    void getAllPlayers(const QString& token);
    void getClubDetails(const QString& token, int club_id);
    void getClubs(const QString& token);
    void getPlayerDetails(const QString& token, int id);
    void getLeagueClubs(const QString& token, int club_id);
    void getClubsByLeague(const QString &token, int league_id);
    void getMatches(const QString& token);

    void sendRequest(const QString& url);
    void processResponse(const QString& response);
    void processError(const QString& error);

    void updatePlayerPosition(const QString& token, Player* player);
    void updatePlayerNumber(const QString& token, Player* player);

    void updatePlayersPosition(const QString& token, QVector<Player*> players);
    void updatePlayersNumber(const QString& token, QVector<Player*> players);

    void createOffer(const QString &params);
    void changeOffer(const QString &params);

    void getOffer(const QString& token, int offer_id);
    void getOfferWithPlayerDetails(const QString& token, int offer_id);

    void withdrawOffer(const QString& token, int offer_id);
    void acceptOffer(const QString& token, int offer_id, const QString& message);
    void rejectOffer(const QString& token, int offer_id, QString message);

    void negotiateOffer(const QString& token, int offer_id);
    void changeTransferOffer(const QString& token, int offer_id, int fee, int minimum_fee);

    void getNotifications(const QString& token, int club_id);
    void getNews(const QString& token, int user_id);
    void updateNewsReadStatus(const QString& token, int message_id);

    void updateUserOnlineStatus(const QString& token, const QString& username);
    void getUsers(const QString& token);

    void sendInvitation(const QString& token, int userId, int invitedUserId);
    void getInvitations(const QString& token, int userId);
    void acceptInvitation(const QString& token, int invitation_id);
    void declineInvitation(const QString& token, int invitation_id);

    void createOfferContract(const QString& params);
    void acceptOfferContract(const QString& token, int offer_id);
    void terminateOfferContract(const QString& token, int offer_id);

private:
    QNetworkAccessManager m_manger;
    QHash<QString, APIConnection::Operation> m_operationName;

    static QString s_token;
    const static QString s_apiUrl;
};

#endif // APICONNECTION_H
