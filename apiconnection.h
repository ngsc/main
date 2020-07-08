#ifndef APICONNECTION_H
#define APICONNECTION_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QByteArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

#include "tournament.h"
#include "player.h"
#include "club.h"
#include "searchingpoolmodel.h"
#include "user.h"
#include "notification.h"
#include "match.h"
#include "simpleusermodel.h"
#include "invitationmodel.h"
#include "newsmodel.h"
#include "announcementmodel.h"
#include "playercomment.h"
#include "bullettext.h"
#include "historybrief.h"
#include "usercommentsmodel.h"
#include "qprocess.h"

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
        Send_Message,
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
        GET_NEWS,

        UPDATE_USER_STATUS,
        Get_Announcement,
        Get_Resign,
        Get_Public_News,
        Get_Retire,
//        Player_Rate,
//        Like_Player_Announcement,
        Player_Announcement,
        Get_Player_Comment,
        Get_Bullet,
        Create_Bullet,
        Get_Game_Clock,
        Get_User_Comment,
        Translate,
        Create_Transfer_Offer_Contract
    };
    QProcess* m_background_process;

public:

    explicit APIConnection(QObject *parent = nullptr);

    static void setToken(QString& token);

    void parseJson(const QString& json);

    Q_INVOKABLE void startMatchServerCmd(int homeClubId, int awayClubId );

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
    void getUsersHistoryFinished(QList<UserHistory*> usersHistory);
    void getInvitationsFinished(QList<Invitation *> invitations);

    void submitOfferFinished(int offer_id, int player_id, QString message);
    void withdrawOfferFinished(int offer_id, int player_id, QString message);

    void getTransferOfferFinished(int offer_id, int owner_club_id, int bidding_club_id, int player_id, int fees, int minimum_fee);
    void getTransferOfferWithPlayerDetailsFinished(int offer_id, Player* player, int oci, QString ocn, int bci, QString bcn, int fee);

    void getLoanOfferFinished(int offer_id, int owner_club_id, int bidding_club_id, int player_id, int fees, int minimum_fee);
    void getLoanOfferWithPlayerDetailsFinished(int offer_id, Player* player, int oci, QString ocn, int bci, QString bcn, int fee,
                 int future_fee, int wages, QString duration, QString duration_type, bool can_play_in_cup, bool can_play_against, bool can_be_recalled);

    void getNewsFinished(QList<News*> news);
    void getUserSignInStatus(QString userName,QString Status);
    void getUserStatus(QString userName,QString status);
    void getAnnouncementFinished(QList<Announcement*> announcement);

//    void getRetire(const QString& message);
    void getPlayerRate(int rate);
    void getTakeControl(QList<News*> publicNews);
    void getPlayerCommentFinished(QList<PlayerComment*> playecomment);
    void getBulletTexFinished(QList<BulletText*> bulletText);
    void getGameClockFinished(QDateTime dateTime);
    void getUserCommentFinished(QList<UserComment*> usercomment);


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
    void upDateUserStatus(const QString& token, const QString &userName, const QString &userStatus);


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

    void getAnnouncement(const QString& token);

    void sendResign(const QString& token, int user_id);
    void getPublicNews(const QString& token);
    void sendRetire(const QString& token, int user_id);

    void updatePublicNewsReadStatus(const QString& token, int news_id);
    void increasePlayerRate(const QString& token,int player_id);
    void decreasePlayerRate(const QString& token,int player_id);
    void likeplayerComment(const QString& token,int player_id, int commentID);
    void setPlayerComment(const QString& token,int player_id, const QString& comment);

    void getPlayerComment(const QString& token,int player_id);
    void getBulletText(const QString& token);
    void createBullet(const QString& token,int user_id, const QString& comment);

    void getGameClock(const QString& token);

    void likeUserComment(const QString& token,int user_id, int commentID);
    void setUserComment(const QString& token,int user_id, const QString& comment);
    void getUserComment(const QString& token,int user_id);
//    void translate(QString keyword);

    void setPlayerValue(const QString& token,int player_id, int value);
    void createTransferOfferContract(const QString &token, int offer_id, QString squad_status,
                                     QString job,int wage,QString contract_type, int contract_length, int signing_on_fee);
    void acceptTransferContractOffer(const QString &token, int offer_id);
    void terminateTransferContractOffer(const QString &token, int offer_id);
    void createFreeOfferContract(const QString &token, int player_id, int bidding_club_id, QString squad_status,
                                 int wage, QString contract_type, int contract_length, int signing_on_fee);
    void acceptFreePlayerContractOffer(const QString &token, int contract_id);
    void terminateFreePlayerContractOffer(const QString &token, int contract_id);

private:
    QNetworkAccessManager m_manger;
    QHash<QString, APIConnection::Operation> m_operationName;

    static QString s_token;
    const static QString s_apiUrl;
    Club *m_SelectedClub = nullptr;
};

__forceinline void APIConnection::parseJson(const QString &json)
{
    QJsonParseError parseError;
    QJsonDocument doc = QJsonDocument::fromJson(json.toUtf8(), &parseError);

    if (parseError.error != QJsonParseError::NoError)
    {
        qDebug() << "Parse error: " << parseError.errorString();
        return;
    }

    QJsonObject obj = doc.object();
    auto status = obj["status"].toBool();

    if(!status) {
        emit errorHappened(obj["message"].toString());
        return;
    }

    auto action = obj["action_name"].toString();
    auto operation = m_operationName[action];

    if(operation == Operation::SIGN_UP)
    {
        auto message = obj["message"].toString();

        qDebug() << "status: " << status << endl;
        qDebug() << "message: " << message << endl;
        emit signupFinished(message);
    }
    else if(operation == Operation::SIGN_IN)
    {
        auto message = obj["message"].toString();
        auto token   = obj["token"].toString();
        auto quizPass = obj["quiz_pass"].toString().toLower() == "true";
        auto firstName = obj["first_name"].toString();
        auto lastName = obj["last_name"].toString();
        auto clubId = obj["club_id"].toString().toInt();
        auto clubName = obj["club_name"].toString();
        auto city = obj["city"].toString();
        auto nickName = obj["nick_name"].toString();
        auto username = obj["username"].toString();
        auto userId = obj["user_id"].toString().toInt();
        auto userPortrait = obj["portrait"].toString();//
        auto favformation = obj["fav_formation"].toString();//



        User *user = new User();
        user->setId(userId);
        user->setUsername(username);
        user->setNickName (nickName);
        user->setToken(token);
        user->setFirstName(firstName);
        user->setLastName(lastName);
        user->setQuizPass(quizPass);
        user->setClubId(clubId);
        user->setClubName(clubName);
        user->setCity(city);
        user->setUserPortrait (userPortrait);
        user->setFavFormation (favformation);

//        qDebug() << "portiat: "<<userPortrait<<" : "<< obj["user_portrait"].toString()<<obj;
        qDebug() << "message: " << message << endl;
        emit signinFinished(message, user);
    }
    else if(operation == Operation::GET_TOURNAMENTS)
    {
        auto tournaments = obj["tournaments"].toArray();
        QVector<Tournament*> ts;
        foreach (const QJsonValue & v, tournaments)
        {
            auto obj = v.toObject();
            auto id  = obj["id"].toString().toInt();
            auto name = obj["name"].toString();
            auto startDate   = QDate::fromString(obj["start_date"].toString(), "yyyy/MM/dd");
            Tournament *t = new Tournament(id, name, startDate);
            ts.append(t);
        }
        emit getTournamentsFinished(ts);
    }
    else if(operation == Operation::GET_CLUB_PLAYERS)
    {
        auto players = obj["players"].toArray();
        QList<Player*> ps;
        foreach (const QJsonValue & v, players)
        {
            auto obj = v.toObject();
            auto player = obj["player"].toObject();
            auto info = player["info"].toObject();
            PlayerInfo pi;
            pi.setId(info["id"].toString().toInt());
            pi.setNumber(info["assigned_number"].toString().toInt());
            pi.setClubId(info["club_id"].toString().toInt());
            pi.setName(info["name"].toString());
            pi.setClubName(info["club_name"].toString());
            pi.setNation(info["nation"].toString());
            pi.setProposedPosition(info["proposed_position"].toString());
            pi.setAssignedPosition(info["assigned_position"].toString());
            pi.setAge(info["age"].toString().toInt());
            pi.setIntCaps(info["int_caps"].toString().toInt());
            pi.setIntGoals(info["int_goals"].toInt());
            pi.setCurA(info["cur_a"].toString().toInt());
            pi.setPotA(info["pot_a"].toString().toInt());
            pi.setADiff(info["a_diff"].toString().toInt());
            pi.setBased(info["based"].toString());
            pi.setHomeRep(info["home_rep"].toString().toInt());
            pi.setCurrentRep(info["current_rep"].toString().toInt());
            pi.setWorldRep(info["world_rep"].toString().toInt());
            auto s = info["date_of_birth"].toString();

            QDate dob = QDate::fromString(s, "yyyy-MM-dd");
            pi.setDob(dob);

            //-------
            PlayerAttributes pa;
            auto attr = player["attributes"].toObject();
            pa.m_acceleration = attr["acceleration"].toString().toInt();
            pa.m_adaptability = attr["adaptability"].toString().toInt();
            pa.m_aerialAbility = attr["aerial_ability"].toString().toInt();
            pa.m_aggression = attr["aggression"].toString().toInt();
            pa.m_agility = attr["agility"].toString().toInt();
            pa.m_ambition = attr["ambition"].toString().toInt();
            pa.m_anticipation = attr["anticipation"].toString().toInt();
            pa.m_balance = attr["balance"].toString().toInt();
            pa.m_bravery = attr["bravery"].toString().toInt();
            pa.m_commandOfArea = attr["command_of_area"].toString().toInt();
            pa.m_communication = attr["communication"].toString().toInt();
            pa.m_composure = attr["composure"].toString().toInt();
            pa.m_fr = attr["fr"].toString().toInt();
            pa.m_concentration = attr["concentration"].toString().toInt();
            pa.m_consistency = attr["consistency"].toString().toInt();
            pa.m_controversy = attr["controversy"].toString().toInt();
            pa.m_corners = attr["corners"].toString().toInt();
            pa.m_vision = attr["vision"].toString().toInt();
            pa.m_crossing = attr["crossing"].toString().toInt();
            pa.m_decisions = attr["decisions"].toString().toInt();
            pa.m_determination = attr["determination"].toString().toInt();
            pa.m_dirtiness = attr["dirtiness"].toString().toInt();
            pa.m_dribbling = attr["dribbling"].toString().toInt();
            pa.m_eccentricity = attr["eccentricity"].toString().toInt();
            pa.m_finishing = attr["finishing"].toString().toInt();
            pa.m_firstTouch = attr["first_touch"].toString().toInt();
            pa.m_flair = attr["flair"].toString().toInt();
            pa.m_handling = attr["handling"].toString().toInt();
            pa.m_heading = attr["heading"].toString().toInt();
            pa.m_importantMatches = attr["important_matches"].toString().toInt();
            pa.m_leadership = attr["leadership"].toString().toInt();
            pa.m_injuryProneness = attr["injury_proneness"].toString().toInt();
            pa.m_jumping = attr["jumping"].toString().toInt();
            pa.m_kicking = attr["kicking"].toString().toInt();
            pa.m_longShots = attr["long_shots"].toString().toInt();
            pa.m_longThrows = attr["long_throws"].toString().toInt();
            pa.m_loyalty = attr["loyalty"].toString().toInt();
            pa.m_marking = attr["marking"].toString().toInt();
            pa.m_naturalFitness = attr["natural_fitness"].toString().toInt();
            pa.m_offTheBall = attr["off_the_ball"].toString().toInt();
            pa.m_oneOnOnes = attr["one_on_ones"].toString().toInt();
            pa.m_pace = attr["pace"].toString().toInt();
            pa.m_passing = attr["passing"].toString().toInt();
            pa.m_penalties = attr["penalties"].toString().toInt();
            pa.m_positioning = attr["positioning"].toString().toInt();
            pa.m_pressure = attr["pressure"].toString().toInt();
            pa.m_professionalism = attr["professionalism"].toString().toInt();
            pa.m_reflexes = attr["reflexes"].toString().toInt();
            pa.m_rushingOut = attr["rushing_out"].toString().toInt();
            pa.m_freeKicks = attr["free_kicks"].toString().toInt();
            pa.m_sportsmanship = attr["sportsmanship"].toString().toInt();
            pa.m_stamina = attr["stamina"].toString().toInt();
            pa.m_strength = attr["strength"].toString().toInt();
            pa.m_tackling = attr["tackling"].toString().toInt();
            pa.m_teamwork = attr["teamwork"].toString().toInt();
            pa.m_technique = attr["technique"].toString().toInt();
            pa.m_temperament = attr["temperament"].toString().toInt();
            pa.m_throwing = attr["throwing"].toString().toInt();
            pa.m_versatility = attr["versatility"].toString().toInt();
            pa.m_workRate = attr["work_rate"].toString().toInt();
            pa.m_tendencyToPunch = attr["tendency_to_punch"].toString().toInt();
            pa.m_leftFoot = attr["left_foot"].toString().toInt();
            pa.m_rightFoot = attr["right_foot"].toString().toInt();


            PlayerContracts pc;
            auto contracts = player["contract"].toObject();
            pc.setDivision(contracts["division"].toString());
            pc.setSquad(contracts["squad"].toString());
            pc.setSquadRep(contracts["squad_rep"].toString().toInt());
            pc.setJoinedClub(contracts["joined_club"].toString());
            pc.setContractType(contracts["contract_type"].toString());
//            qDebug()<<pc.contractType()<<" : Full Time";//contracts["contract_type"].toString()<<" :contracts[\"contract_type\"].toString()";
            pc.setContractEnd(contracts["contract_end"].toString());
            pc.setLeavingOnBosman(contracts["leaving_on_bosman"].toString().toInt());
            pc.setMinimumFee(contracts["minimum_fee"].toString().toInt());
            pc.setRelegationFee(contracts["relegation_fee"].toString().toInt());
            pc.setNonPromotionFee(contracts["non_promotion_fee"].toString().toInt());
            pc.setSquadStatus(contracts["squad_status"].toString().toInt());
            pc.setPerceivedSquadStatus(contracts["perceived_squad_status"].toString());
            pc.setTransferStatus(contracts["transfer_status"].toString().toInt());
            pc.setWage(contracts["wage"].toString().toInt());
            pc.setValue(contracts["value"].toString().toInt());
            pc.setSaleValue(contracts["sale_value"].toString().toInt());
            pc.setHappinessLevel(contracts["happiness_level"].toString().toInt());

            ps.append(new Player(nullptr, pi, pa, pc));
        }
        emit getPlayersFinished(ps);
    }
    else if(operation == Operation::GET_ALL_PLAYERS)
    {
        qDebug() << "Get all players...";
        auto players = obj["players"].toArray();

        QList<SearchingPoolPlayer*> ps;
        foreach (const QJsonValue & v, players)
        {
            auto obj = v.toObject();
            auto player = obj["player"].toObject();

            SearchingPoolPlayer* p = new SearchingPoolPlayer();
            p->setId(player["id"].toString().toInt());
            p->setName(player["name"].toString());
            p->setClubId(player["club_id"].toString().toInt());
            p->setClubName(player["club_name"].toString());
            p->setPosition(player["position"].toString());
            p->setBased(player["based"].toString());
            p->setValue(player["value"].toString().toInt());
            p->setMinimumFee(player["minimum_fee"].toString().toInt());
            p->setOfferId(player["offer_id"].toString().toInt());
            ps.append(p);
        }
        qDebug() << "got all searching pool players: " << ps.count();
        emit getAllPlayersFinished(ps);
    }
    else if(operation == Operation::GET_CLUB_DETAILS)
    {
        auto club    = obj["club"].toObject();
        m_SelectedClub = new Club();
        m_SelectedClub->setId(club["id"].toString().toInt());
        m_SelectedClub->setName(club["name"].toString());
        m_SelectedClub->setNation(club["nation"].toString());
        m_SelectedClub->setDivision(club["division"].toString());
        m_SelectedClub->setRep(club["rep"].toString().toInt());
        m_SelectedClub->setAvAge(club["av_age"].toString().toDouble());
        m_SelectedClub->setBalance(club["balance"].toString().toInt());
        m_SelectedClub->setTrnBudgetS(club["trn_budget_s"].toString().toInt());
        m_SelectedClub->setTrnBudgetR(club["trn_budget_r"].toString().toInt());
        m_SelectedClub->setWageBudget(club["wage_budget"].toString().toInt());
        m_SelectedClub->setStatus(club["status"].toString());
        m_SelectedClub->setTf(club["tf"].toString().toInt());
        m_SelectedClub->setYf(club["yf"].toString().toInt());
        m_SelectedClub->setYa(club["ya"].toString().toInt());
        m_SelectedClub->setStadCap(club["stad_cap"].toString().toInt());
        m_SelectedClub->setAvAtt(club["av_att"].toString().toInt());
        m_SelectedClub->setMinAtt(club["min_att"].toString().toInt());
        m_SelectedClub->setMaxAtt(club["max_att"].toString().toInt());
        m_SelectedClub->setRating(club["rating"].toString().toInt());
        m_SelectedClub->setPotRating(club["pot_rating"].toString().toDouble());
        m_SelectedClub->setDivisionId(club["division_id"].toString().toInt());
        m_SelectedClub->setForeground1(club["foreground1"].toString());
        m_SelectedClub->setBackground1(club["background1"].toString());
        m_SelectedClub->setForeground2(club["foreground2"].toString());
        m_SelectedClub->setBackground2(club["background2"].toString());
        m_SelectedClub->setForeground3(club["foreground3"].toString());
        m_SelectedClub->setForeground1Value(club["foreground1_value"].toString());
        m_SelectedClub->setBackground1Value(club["background1_value"].toString());
        m_SelectedClub->setForeground2Value(club["foreground2_value"].toString());
        m_SelectedClub->setBackground2Value(club["background2_value"].toString());
        m_SelectedClub->setForeground3Value(club["foreground3_value"].toString());
        m_SelectedClub->setBackground3(club["background3"].toString());
        m_SelectedClub->setFavourite1(club["favourite1"].toString());
        m_SelectedClub->setFavourite2(club["favourite2"].toString());
        m_SelectedClub->setFavourite3(club["favourite3"].toString());
        m_SelectedClub->setDislike1(club["dislike1"].toString());
        m_SelectedClub->setDislike2(club["dislike2"].toString());
        m_SelectedClub->setDislike3(club["dislike3"].toString());
        m_SelectedClub->setRival1(club["rival1"].toString());
        m_SelectedClub->setRival2(club["rival2"].toString());
        m_SelectedClub->setRival3(club["rival3"].toString());
        m_SelectedClub->setLeagueId(club["league_id"].toString().toInt());

        emit getClubDetailsFinished(m_SelectedClub);
    }
    else if(operation == Operation::GET_PLAYER_DETAILS)
    {//"like_rate":"8","dislike_rate":"1"
        auto player = obj["player"].toObject();
        auto info = player["info"].toObject();
        PlayerInfo pi;
        pi.setId(info["id"].toString().toInt());
        pi.setNumber(info["assigned_number"].toString().toInt());
        pi.setClubId(info["club_id"].toString().toInt());
        pi.setName(info["name"].toString());
        pi.setClubName(info["club_name"].toString());
        pi.setNation(info["nation"].toString());
        pi.setProposedPosition(info["proposed_position"].toString());
        pi.setAssignedPosition(info["assigned_position"].toString());
        pi.setAge(info["age"].toString().toInt());
        pi.setIntCaps(info["int_caps"].toString().toInt());
        pi.setIntGoals(info["int_goals"].toInt());
        pi.setCurA(info["cur_a"].toString().toInt());
        pi.setPotA(info["pot_a"].toString().toInt());
        pi.setADiff(info["a_diff"].toString().toInt());
        pi.setBased(info["based"].toString());
        pi.setHomeRep(info["home_rep"].toString().toInt());
        pi.setCurrentRep(info["current_rep"].toString().toInt());
        pi.setWorldRep(info["world_rep"].toString().toInt());
        pi.setLikeRate(info["like_rate"].toString().toInt());
        pi.setDislikeRate(info["dislike_rate"].toString().toInt());
        auto s = info["date_of_birth"].toString();
        QDate dob = QDate::fromString(s, "yyyy-MM-dd");
        pi.setOfferId(info["offer_id"].toString().toInt());
        pi.setDob(dob);

        //-------
        PlayerAttributes pa;
        auto attr = player["attributes"].toObject();
        pa.m_acceleration = attr["acceleration"].toString().toInt();
        pa.m_adaptability = attr["adaptability"].toString().toInt();
        pa.m_aerialAbility = attr["aerial_ability"].toString().toInt();
        pa.m_aggression = attr["aggression"].toString().toInt();
        pa.m_agility = attr["agility"].toString().toInt();
        pa.m_ambition = attr["ambition"].toString().toInt();
        pa.m_anticipation = attr["anticipation"].toString().toInt();
        pa.m_balance = attr["balance"].toString().toInt();
        pa.m_bravery = attr["bravery"].toString().toInt();
        pa.m_commandOfArea = attr["command_of_area"].toString().toInt();
        pa.m_communication = attr["communication"].toString().toInt();
        pa.m_composure = attr["composure"].toString().toInt();
        pa.m_fr = attr["fr"].toString().toInt();
        pa.m_concentration = attr["concentration"].toString().toInt();
        pa.m_consistency = attr["consistency"].toString().toInt();
        pa.m_controversy = attr["controversy"].toString().toInt();
        pa.m_corners = attr["corners"].toString().toInt();
        pa.m_vision = attr["vision"].toString().toInt();
        pa.m_crossing = attr["crossing"].toString().toInt();
        pa.m_decisions = attr["decisions"].toString().toInt();
        pa.m_determination = attr["determination"].toString().toInt();
        pa.m_dirtiness = attr["dirtiness"].toString().toInt();
        pa.m_dribbling = attr["dribbling"].toString().toInt();
        pa.m_eccentricity = attr["eccentricity"].toString().toInt();
        pa.m_finishing = attr["finishing"].toString().toInt();
        pa.m_firstTouch = attr["first_touch"].toString().toInt();
        pa.m_flair = attr["flair"].toString().toInt();
        pa.m_handling = attr["handling"].toString().toInt();
        pa.m_heading = attr["heading"].toString().toInt();
        pa.m_importantMatches = attr["important_matches"].toString().toInt();
        pa.m_leadership = attr["leadership"].toString().toInt();
        pa.m_injuryProneness = attr["injury_proneness"].toString().toInt();
        pa.m_jumping = attr["jumping"].toString().toInt();
        pa.m_kicking = attr["kicking"].toString().toInt();
        pa.m_longShots = attr["long_shots"].toString().toInt();
        pa.m_longThrows = attr["long_throws"].toString().toInt();
        pa.m_loyalty = attr["loyalty"].toString().toInt();
        pa.m_marking = attr["marking"].toString().toInt();
        pa.m_naturalFitness = attr["natural_fitness"].toString().toInt();
        pa.m_offTheBall = attr["off_the_ball"].toString().toInt();
        pa.m_oneOnOnes = attr["one_on_ones"].toString().toInt();
        pa.m_pace = attr["pace"].toString().toInt();
        pa.m_passing = attr["passing"].toString().toInt();
        pa.m_penalties = attr["penalties"].toString().toInt();
        pa.m_positioning = attr["positioning"].toString().toInt();
        pa.m_pressure = attr["pressure"].toString().toInt();
        pa.m_professionalism = attr["professionalism"].toString().toInt();
        pa.m_reflexes = attr["reflexes"].toString().toInt();
        pa.m_rushingOut = attr["rushing_out"].toString().toInt();
        pa.m_freeKicks = attr["free_kicks"].toString().toInt();
        pa.m_sportsmanship = attr["sportsmanship"].toString().toInt();
        pa.m_stamina = attr["stamina"].toString().toInt();
        pa.m_strength = attr["strength"].toString().toInt();
        pa.m_tackling = attr["tackling"].toString().toInt();
        pa.m_teamwork = attr["teamwork"].toString().toInt();
        pa.m_technique = attr["technique"].toString().toInt();
        pa.m_temperament = attr["temperament"].toString().toInt();
        pa.m_throwing = attr["throwing"].toString().toInt();
        pa.m_versatility = attr["versatility"].toString().toInt();
        pa.m_workRate = attr["work_rate"].toString().toInt();
        pa.m_tendencyToPunch = attr["tendency_to_punch"].toString().toInt();
        pa.m_leftFoot = attr["left_foot"].toString().toInt();
        pa.m_rightFoot = attr["right_foot"].toString().toInt();


        PlayerContracts pc;
        auto contracts = player["contract"].toObject();
        pc.setDivision(contracts["division"].toString());
        pc.setSquad(contracts["squad"].toString());
        pc.setSquadRep(contracts["squad_rep"].toString().toInt());
        pc.setJoinedClub(contracts["joined_club"].toString());
        pc.setContractType(contracts["contract_type"].toString());
        pc.setContractEnd(contracts["contract_end"].toString());
        pc.setLeavingOnBosman(contracts["leaving_on_bosman"].toString().toInt());
        pc.setMinimumFee(contracts["minimum_fee"].toString().toInt());
        pc.setRelegationFee(contracts["relegation_fee"].toString().toInt());
        pc.setNonPromotionFee(contracts["non_promotion_fee"].toString().toInt());
        pc.setSquadStatus(contracts["squad_status"].toString().toInt());
        pc.setPerceivedSquadStatus(contracts["perceived_squad_status"].toString());
        pc.setTransferStatus(contracts["transfer_status"].toString().toInt());
        pc.setWage(contracts["wage"].toString().toInt());
        pc.setValue(contracts["value"].toString().toInt());
        pc.setSaleValue(contracts["sale_value"].toString().toInt());
        pc.setHappinessLevel(contracts["happiness_level"].toString().toInt());

        emit getPlayerDetailsFinished(new Player(nullptr, pi, pa, pc));
    }
    else if(operation == Operation::GET_LEAGUE_CLUBS || operation == Operation::GET_CLUBS_BY_LEAGUE || operation == Operation::GET_CLUBS)
    {
        auto clubs = obj["clubs"].toArray();
        QVector<Club*> cs;
        foreach (const QJsonValue & v, clubs)
        {
            auto obj = v.toObject();
            auto club = obj["club"].toObject();
            Club *c = new Club();
            c->setId(club["id"].toString().toInt());
            c->setName(club["name"].toString());
            c->setNation(club["nation"].toString());
            c->setDivision(club["division"].toString());
            c->setRep(club["rep"].toString().toInt());
            c->setAvAge(club["av_age"].toString().toDouble());
            c->setBalance(club["balance"].toString().toInt());
            c->setTrnBudgetS(club["trn_budget_s"].toString().toInt());
            c->setTrnBudgetR(club["trn_budget_r"].toString().toInt());
            c->setWageBudget(club["wage_budget"].toString().toInt());
            c->setStatus(club["status"].toString());
            c->setTf(club["tf"].toString().toInt());
            c->setYf(club["yf"].toString().toInt());
            c->setYa(club["ya"].toString().toInt());
            c->setStadCap(club["stad_cap"].toString().toInt());
            c->setAvAtt(club["av_att"].toString().toInt());
            c->setMinAtt(club["min_att"].toString().toInt());
            c->setMaxAtt(club["max_att"].toString().toInt());
            c->setRating(club["rating"].toString().toInt());
            c->setPotRating(club["pot_rating"].toString().toDouble());
            c->setDivisionId(club["division_id"].toString().toInt());
            c->setForeground1(club["foreground1"].toString());
            c->setBackground1(club["background1"].toString());
            c->setForeground2(club["foreground2"].toString());
            c->setBackground2(club["background2"].toString());
            c->setForeground3(club["foreground3"].toString());
            c->setForeground1Value(club["foreground1_value"].toString());
            c->setBackground1Value(club["background1_value"].toString());
            c->setForeground2Value(club["foreground2_value"].toString());
            c->setBackground2Value(club["background2_value"].toString());
            c->setForeground3Value(club["foreground3_value"].toString());
            c->setBackground3(club["background3"].toString());
            c->setFavourite1(club["favourite1"].toString());
            c->setFavourite2(club["favourite2"].toString());
            c->setFavourite3(club["favourite3"].toString());
            c->setDislike1(club["dislike1"].toString());
            c->setDislike2(club["dislike2"].toString());
            c->setDislike3(club["dislike3"].toString());
            c->setRival1(club["rival1"].toString());
            c->setRival2(club["rival2"].toString());
            c->setRival3(club["rival3"].toString());
            c->setOwnerId(club["owner_id"].toString().toInt());
            c->setOwnerName(club["username"].toString());
            c->setLeagueId(club["league_id"].toString().toInt());

            cs.append(c);
        }

        emit getClubsFinished(cs);
    }
    else if(operation == Operation::GET_NOTIFICATIONS) {
        QList<Notification *> ns;
        auto nots = obj["notifications"].toArray();
        foreach (const QJsonValue & n, nots)
        {
            auto obj = n.toObject();
            auto id  = obj["id"].toString().toInt();
            auto date = QDate::fromString(obj["date"].toString(), "yyyy/MM/dd");
            auto status = obj["status"].toString().toInt();
            auto oci = obj["owner_club_id"].toString().toInt();
            auto ocn = obj["owner_club_name"].toString();
            auto bci = obj["bidding_club_id"].toString().toInt();
            auto bcn = obj["bidding_club_name"].toString();
            auto* notification = new Notification(nullptr, id, date, status, oci, ocn, bci, bcn);
            ns.append(notification);
        }

        emit  getNotificationsFinished(ns);
    }
    else if(operation == Operation::GET_MATCHES) {
        QList<Match*> ms;
        auto matches= obj["matches"].toArray();
        foreach (const QJsonValue & v, matches)
        {
            auto obj = v.toObject();
            auto match = obj["Match"].toObject();
            auto id = match["id"].toString().toInt();
            auto homeClubId = match["home_club_id"].toString().toInt();
            auto awayClubId = match["away_club_id"].toString().toInt();
            auto date = QDate::fromString(match["date"].toString(), "yyyy-MM-dd");
            auto time = QTime::fromString(match["time"].toString(), "hh:mm:ss");

            auto homeClub = obj["HomeClub"].toObject();
            auto homeName = homeClub["name"].toString();

            auto awayClub = obj["AwayClub"].toObject();
            auto awayName = awayClub["name"].toString();
            auto m = new Match();
            m->setId(id);
            m->setDate(date);
            m->setTime(time);
            m->setAwayClubId(awayClubId);
            m->setAwayClubName(awayName);
            m->setHomeClubId(homeClubId);
            m->setHomeClubName(homeName);
            ms.append(m);
        }

        emit getMatchesFinished(ms);
    }
    else if(operation == Operation::GET_USERS) {
        QList<SimpleUser*> ous;
        QList<UserHistory*> hus;
        auto users = obj["users"].toArray();
        foreach (const QJsonValue & v, users)
        {
            auto user = v.toObject();
            auto userId = user["id"].toString().toInt();
            auto username = user["username"].toString();
            auto firstName = user["first_name"].toString();
            auto lastName = user["last_name"].toString();
            auto clubId = user["club_id"].toString().toInt();
            auto clubName = user["club_name"].toString();
            auto online = user["status"].toBool();

            auto ou = new SimpleUser();
            auto hu = new UserHistory();

            ou->setUserId(userId);
            hu->setUserId(userId);
            ou->setUsername(username);
            hu->setUsername(username);
            ou->setFirstName(firstName);
            hu->setFirstName(firstName);
            ou->setLastName(lastName);
            hu->setLastName(lastName);
            ou->setClubId(clubId);
            hu->setClubId(clubId);
            ou->setClubName(clubName);
            hu->setClubName(clubName);
            ou->setOnline(online);
            hu->setOnline(online);

            ous.append(ou);
            hus.append(hu);
        }

        emit getUsersFinished(ous);
        emit getUsersHistoryFinished(hus);
    }
    else if(operation == Operation::INVITE_TO_MATCH || operation == Operation::CHANGE_OFFER_DETAILS || operation == Operation::ACCEPT_OFFER ||
            operation == Operation::ACCEPT_INVITATION || operation == Operation::DECLINE_INVITATION || operation == Operation::CREATE_OFFER_CONTRACT) {
        auto message = obj["message"].toString();
        emit messageReceived(message);
    }
    else if(operation == Operation::GET_INVITATIONS) {
        QList<Invitation*> is;
        auto invitations = obj["invitations"].toArray();
        foreach (const QJsonValue & v, invitations)
        {
            auto obj = v.toObject();
            auto invitation = obj["Invitation"].toObject();
            auto id = invitation["id"].toString().toInt();
            auto homeUserId = invitation["home_user_id"].toString().toInt();
            auto awayUserId = invitation["away_user_id"].toString().toInt();
            auto homeClubId = invitation["home_user_club_id"].toString().toInt();
            auto awayClubId = invitation["away_user_club_id"].toString().toInt();
            auto status     = invitation["status"].toString().toLower();
            auto date = QDateTime::fromString(invitation["created_time"].toString(), "yyyy-MM-dd hh:mm:ss");

            auto homeClub = obj["HomeClub"].toObject();
            auto homeName = homeClub["name"].toString();

            auto awayClub = obj["AwayClub"].toObject();
            auto awayName = awayClub["name"].toString();

            auto i = new Invitation();
            i->setId(id);
            i->setDate(date);
            i->setHomeUserId(homeUserId);
            i->setAwayUserId(awayUserId);
            i->setAwayClubId(awayClubId);
            i->setAwayClubName(awayName);
            i->setHomeClubId(homeClubId);
            i->setHomeClubName(homeName);
            i->setStatus(status);
            is.append(i);
        }
        emit getInvitationsFinished(is);
    }
    else if(operation == Operation::CREATE_OFFER) {
        //{"status":true,"offer_id":"44","player_id":"132202","message":"The club has remaining 22832950 in transfer budget","action_name":"create_offer"}
        auto message = "Offer submitted successfully";   //obj["message"].toString();
        auto offer_id = obj["offer_id"].toString().toInt();
        auto player_id = obj["player_id"].toString().toInt();
        auto m = obj["message"].toString();
        emit submitOfferFinished(offer_id, player_id, message);
    }
    else if(operation == Operation::GET_OFFER) {
        /*
        {"status":true,"offer":
        {"Offer":
        {"id":"5","about_player_id":"14044150","bidding_club_id":"1736",
        "bidding_user_id":"8","owner_club_id":"1139",
        "owner_user_id":"15","type":"Transfer",
        "fee":"95000","minimum_fee":"70000"},

        "BidClub":{"id":"1736","name":"R. Madrid"},
        "OwnerClub":{"id":"1139","name":"Juventus"}
        },
        "action_name":"GET_OFFER"}
        */
        auto trans = obj["offer"].toObject();
        auto offer = trans["Offer"].toObject();
        auto offer_id = offer["id"].toString().toInt();
        auto offer_type = offer["type"].toString().toLower();
        if(offer_type == "transfer") {
            auto player_id = offer["about_player_id"].toString().toInt();
            auto bidding_club_id = offer["bidding_club_id"].toString().toInt();
            auto fee = offer["fee"].toString().toInt();
            auto minimum_fee = offer["minimum_fee"].toString().toInt();
            auto owner_club_id = offer["owner_club_id"].toString().toInt();
            emit getTransferOfferFinished(offer_id, owner_club_id, bidding_club_id, player_id, fee, minimum_fee);
        }
        else {
        }
    }
    else if(operation == Operation::GET_OFFER_WITH_PLAYER_DETAILS) {
        auto trans = obj["offer"].toObject();

        auto bidClub = trans["BidClub"].toObject();
        auto bci = bidClub["id"].toString().toInt();
        auto bcn = bidClub["name"].toString();

        auto ownClub = trans["OwnerClub"].toObject();
        auto oci = ownClub["id"].toString().toInt();
        auto ocn = ownClub["name"].toString();

        auto player = trans["Player"].toObject();
        auto info = player["info"].toObject();
        PlayerInfo pi;
        pi.setId(info["id"].toString().toInt());
        pi.setNumber(info["assigned_number"].toString().toInt());
        pi.setClubId(info["club_id"].toString().toInt());
        pi.setName(info["name"].toString());
        pi.setClubName(info["club_name"].toString());
        pi.setNation(info["nation"].toString());
        pi.setProposedPosition(info["proposed_position"].toString());
        pi.setAssignedPosition(info["assigned_position"].toString());
        pi.setAge(info["age"].toString().toInt());
        pi.setIntCaps(info["int_caps"].toString().toInt());
        pi.setIntGoals(info["int_goals"].toInt());
        pi.setCurA(info["cur_a"].toString().toInt());
        pi.setPotA(info["pot_a"].toString().toInt());
        pi.setADiff(info["a_diff"].toString().toInt());
        pi.setBased(info["based"].toString());
        pi.setHomeRep(info["home_rep"].toString().toInt());
        pi.setCurrentRep(info["current_rep"].toString().toInt());
        pi.setWorldRep(info["world_rep"].toString().toInt());
        auto s = info["date_of_birth"].toString();
        QDate dob = QDate::fromString(s, "yyyy-MM-dd");
        pi.setOfferId(info["offer_id"].toString().toInt());
        pi.setDob(dob);

        //-------
        PlayerAttributes pa;
        auto attr = player["attributes"].toObject();
        pa.m_acceleration = attr["acceleration"].toString().toInt();
        pa.m_adaptability = attr["adaptability"].toString().toInt();
        pa.m_aerialAbility = attr["aerial_ability"].toString().toInt();
        pa.m_aggression = attr["aggression"].toString().toInt();
        pa.m_agility = attr["agility"].toString().toInt();
        pa.m_ambition = attr["ambition"].toString().toInt();
        pa.m_anticipation = attr["anticipation"].toString().toInt();
        pa.m_balance = attr["balance"].toString().toInt();
        pa.m_bravery = attr["bravery"].toString().toInt();
        pa.m_commandOfArea = attr["command_of_area"].toString().toInt();
        pa.m_communication = attr["communication"].toString().toInt();
        pa.m_composure = attr["composure"].toString().toInt();
        pa.m_fr = attr["fr"].toString().toInt();
        pa.m_concentration = attr["concentration"].toString().toInt();
        pa.m_consistency = attr["consistency"].toString().toInt();
        pa.m_controversy = attr["controversy"].toString().toInt();
        pa.m_corners = attr["corners"].toString().toInt();
        pa.m_vision = attr["vision"].toString().toInt();
        pa.m_crossing = attr["crossing"].toString().toInt();
        pa.m_decisions = attr["decisions"].toString().toInt();
        pa.m_determination = attr["determination"].toString().toInt();
        pa.m_dirtiness = attr["dirtiness"].toString().toInt();
        pa.m_dribbling = attr["dribbling"].toString().toInt();
        pa.m_eccentricity = attr["eccentricity"].toString().toInt();
        pa.m_finishing = attr["finishing"].toString().toInt();
        pa.m_firstTouch = attr["first_touch"].toString().toInt();
        pa.m_flair = attr["flair"].toString().toInt();
        pa.m_handling = attr["handling"].toString().toInt();
        pa.m_heading = attr["heading"].toString().toInt();
        pa.m_importantMatches = attr["important_matches"].toString().toInt();
        pa.m_leadership = attr["leadership"].toString().toInt();
        pa.m_injuryProneness = attr["injury_proneness"].toString().toInt();
        pa.m_jumping = attr["jumping"].toString().toInt();
        pa.m_kicking = attr["kicking"].toString().toInt();
        pa.m_longShots = attr["long_shots"].toString().toInt();
        pa.m_longThrows = attr["long_throws"].toString().toInt();
        pa.m_loyalty = attr["loyalty"].toString().toInt();
        pa.m_marking = attr["marking"].toString().toInt();
        pa.m_naturalFitness = attr["natural_fitness"].toString().toInt();
        pa.m_offTheBall = attr["off_the_ball"].toString().toInt();
        pa.m_oneOnOnes = attr["one_on_ones"].toString().toInt();
        pa.m_pace = attr["pace"].toString().toInt();
        pa.m_passing = attr["passing"].toString().toInt();
        pa.m_penalties = attr["penalties"].toString().toInt();
        pa.m_positioning = attr["positioning"].toString().toInt();
        pa.m_pressure = attr["pressure"].toString().toInt();
        pa.m_professionalism = attr["professionalism"].toString().toInt();
        pa.m_reflexes = attr["reflexes"].toString().toInt();
        pa.m_rushingOut = attr["rushing_out"].toString().toInt();
        pa.m_freeKicks = attr["free_kicks"].toString().toInt();
        pa.m_sportsmanship = attr["sportsmanship"].toString().toInt();
        pa.m_stamina = attr["stamina"].toString().toInt();
        pa.m_strength = attr["strength"].toString().toInt();
        pa.m_tackling = attr["tackling"].toString().toInt();
        pa.m_teamwork = attr["teamwork"].toString().toInt();
        pa.m_technique = attr["technique"].toString().toInt();
        pa.m_temperament = attr["temperament"].toString().toInt();
        pa.m_throwing = attr["throwing"].toString().toInt();
        pa.m_versatility = attr["versatility"].toString().toInt();
        pa.m_workRate = attr["work_rate"].toString().toInt();
        pa.m_tendencyToPunch = attr["tendency_to_punch"].toString().toInt();
        pa.m_leftFoot = attr["left_foot"].toString().toInt();
        pa.m_rightFoot = attr["right_foot"].toString().toInt();


        PlayerContracts pc;
        auto contracts = player["contract"].toObject();
        pc.setDivision(contracts["division"].toString());
        pc.setSquad(contracts["squad"].toString());
        pc.setSquadRep(contracts["squad_rep"].toString().toInt());
        pc.setJoinedClub(contracts["joined_club"].toString());
        pc.setContractType(contracts["contract_type"].toString());
        pc.setContractEnd(contracts["contract_end"].toString());
        pc.setLeavingOnBosman(contracts["leaving_on_bosman"].toString().toInt());
        pc.setMinimumFee(contracts["minimum_fee"].toString().toInt());
        pc.setRelegationFee(contracts["relegation_fee"].toString().toInt());
        pc.setNonPromotionFee(contracts["non_promotion_fee"].toString().toInt());
        pc.setSquadStatus(contracts["squad_status"].toString().toInt());
        pc.setPerceivedSquadStatus(contracts["perceived_squad_status"].toString());
        pc.setTransferStatus(contracts["transfer_status"].toString().toInt());
        pc.setWage(contracts["wage"].toString().toInt());
        pc.setValue(contracts["value"].toString().toInt());
        pc.setSaleValue(contracts["sale_value"].toString().toInt());
        pc.setHappinessLevel(contracts["happiness_level"].toString().toInt());

        auto pp = new Player(nullptr, pi, pa, pc);

        auto offer = trans["Offer"].toObject();
        auto offer_id = offer["id"].toString().toInt();
        auto offer_type = offer["type"].toString().toLower();
        if(offer_type == "transfer") {
            auto fee = offer["fee"].toString().toInt();
            emit getTransferOfferWithPlayerDetailsFinished(offer_id, pp, oci, ocn, bci, bcn, fee);
        }
        else {
            auto fee = offer["fee"].toString().toInt();
            auto future_fee = offer["futureFee"].toString().toInt();
            auto wages = offer["wages"].toString().toInt();
            auto duration = offer["duration"].toString();
            auto duration_type = offer["duration_type"].toString();
            auto can_play_in_cup = offer["canPlayInCup"].toString() == "true";
            auto can_play_against = offer["canPlayAgainst"].toString() == "true";
            auto can_be_recalled = offer["canBeRecalled"].toString() == "true";
            emit getLoanOfferWithPlayerDetailsFinished(offer_id, pp, oci, ocn, bci, bcn,
                        fee, future_fee, wages, duration, duration_type, can_play_in_cup, can_play_against, can_be_recalled);

        }
    }
    else if(operation == Operation::WITHDRAW_OFFER) {
        auto offer_id = obj["offer_id"].toString().toInt();
        auto player_id = obj["player_id"].toString().toInt();
        auto message = obj["message"].toString();
        emit withdrawOfferFinished(offer_id, player_id, message);
    }
    else if(operation == Operation::GET_NEWS) {
        QList<News*> l;
        auto array = obj["news"].toArray();
        foreach (const QJsonValue & a, array)
        {
            auto obj = a.toObject();
            auto news = obj;    //["News"].toObject();
            auto id = news["news_id"].toString().toInt();
            auto date = QDateTime::fromString(news["date_time"].toString(), "yyyy-MM-dd hh:mm:ss");
            auto news_type = news["message_type"].toString();
            auto brief = news["brief"].toString();
            auto message = news["full_message"].toString();
            auto read = news["message_read_status"].toString().toLower() == "read";
            auto invId = news["invitation_id"].toString().toInt();

            auto *n = new News();
            n->setId(id);
            n->setNewsType(news_type);
            n->setDateTime(date);
            n->setBrief(brief);
            n->setMessage(message);
            n->setRead(read);
            n->setInvitationId (invId);

            if(n->newsType() == News::NewsType::Offer)
            {
                auto role = news["role"].toString();
                auto offer_id = news["offer_id"].toString().toInt();
                auto bci = news["bidding_club_id"].toString().toInt();
                auto oci = news["owner_club_id"].toString().toInt();
                auto stage = news["stage"].toString();
                auto active = news["status"].toString().toLower() == "active";
                auto offerType = news["offer_type"].toString();
                n->setRole(role);
                n->setOfferId(offer_id);
                n->setBiddingClubId(bci);
                n->setOwnerClubId(oci);
                n->setActive(active);
                n->setStage(stage);
                n->setOfferType(offerType);
            }

            l.append(n);
        }
        emit getNewsFinished(l);
    }
    else if(operation == Operation::UPDATE_USER_ONLINE_STATUS){

        auto userName = obj["first_name"].toString();
        auto status = obj["last_name"].toString();

        emit getUserSignInStatus (userName,status);
    }
    else if(operation == Operation::UPDATE_USER_STATUS){

        auto userName = obj["first_name"].toString();
        auto status = obj["last_name"].toString();

        emit getUserStatus (userName,status);
    }
    else if(operation == Operation::Get_Announcement){

        QList<Announcement*> announcementList;//Announcement
        auto array = obj["announcements"].toArray();
        foreach (const QJsonValue & a, array){
            auto obj = a.toObject();
            auto Announc =obj["Announcement"].toObject();// obj;    //["News"].toObject();

             auto id = Announc["id"].toString().toInt();
            auto font_style = Announc["font_style"].toString().toInt ();
            auto font_size = Announc["font_size"].toString().toInt ();
            auto font_background = Announc["font_backgroundcolor"].toString();
            auto font_difference = Announc["font_difference"].toString();
            auto font_color = Announc["font_color"].toString();
            auto message_type = Announc["message_type"].toString();
            auto message = Announc["message"].toString();

            if(font_background == ""){
               font_background = "light blue";
            }
            if(font_size == 0){
               font_size = 12;
            }

            auto *ann = new Announcement();
            ann->setId(id);

            ann->setFontStyle (font_style);
            ann->setFontSize (font_size);
            ann->setFontbackGround (font_background);
            ann->setFontDifference (font_difference);
            ann->setFontColor (font_color);
            ann->setMessageType (message_type);
            ann->setMessage (message);

            announcementList.append(ann);

        }
        emit getAnnouncementFinished(announcementList);

    }
    else if(operation == Operation::Get_Resign)
    {
        auto message = obj["message"].toString();

        qDebug() << "status: " << status << endl;
        qDebug() << "message: " << message << endl;
        emit messageReceived(message);
    }
    else if(operation == Operation::Get_Retire)
    {
        auto message = obj["message"].toString();

        qDebug() << "status: " << status << endl;
        qDebug() << "message: " << message << endl;
        emit messageReceived(message);
    }
    else if(operation == Operation::Get_Public_News)
    {
        auto message = obj["message"].toString();

        qDebug() << "status: " << status << endl;
        qDebug() << "message: " << message << endl;

        QList<News*> publicNews;
        auto array = obj["news"].toArray();
        foreach (const QJsonValue & a, array)
        {
            auto obj = a.toObject();
            auto news = obj;    //["News"].toObject();
            auto id = news["news_id"].toString().toInt();
            auto date = QDateTime::fromString(news["date_time"].toString(), "yyyy-MM-dd hh:mm:ss");
            auto news_type = news["message_type"].toString();
            auto brief = news["brief"].toString();
            auto message = news["full_message"].toString();
            auto read = news["message_read_status"].toString().toLower() == "read";
            auto invId = news["invitation_id"].toString().toInt();

            auto *n = new News();
            n->setId(id);
            n->setNewsType(news_type);
            n->setDateTime(date);
            n->setBrief(brief);
            n->setMessage(message);
            n->setRead(read);
            n->setInvitationId (invId);

            if(n->newsType() == News::NewsType::Offer)
            {
                auto role = news["role"].toString();
                auto offer_id = news["offer_id"].toString().toInt();
                auto bci = news["bidding_club_id"].toString().toInt();
                auto oci = news["owner_club_id"].toString().toInt();
                auto stage = news["stage"].toString();
                auto active = news["status"].toString().toLower() == "active";
                auto offerType = news["offer_type"].toString();
                n->setRole(role);
                n->setOfferId(offer_id);
                n->setBiddingClubId(bci);
                n->setOwnerClubId(oci);
                n->setActive(active);
                n->setStage(stage);
                n->setOfferType(offerType);
            }

            publicNews.append(n);
        }

        emit getTakeControl(publicNews);
    }
    else if(operation == Operation::Send_Message){
        auto message = obj["message"].toString();
        emit messageReceived(message);
    }
    else if(operation == Operation::Get_Player_Comment){
//        auto message = obj["message"].toString();

//        qDebug() << "status: " << status << endl;
//        qDebug() << "message: " << message << endl;

        QList<PlayerComment*> playerComments;
        auto array = obj["comments"].toArray();
        foreach (const QJsonValue & a, array)
        {
            //TODO

            auto obj = a.toObject();
            auto playercomment = obj["PlayerComment"].toObject();
            auto id = playercomment["id"].toString().toInt();
            auto date = QDateTime::fromString(playercomment["date_time"].toString(), "yyyy-MM-dd hh:mm:ss");
            auto message = playercomment["comment"].toString();
            auto playerId = playercomment["player_id"].toString().toInt();
            auto commentRate = playercomment["comment_rate"].toString().toInt();

            qDebug() << "id: " << id << endl;
            qDebug() << "message: " << message << endl;

            auto *comm = new PlayerComment();
            comm->setId(id);
            comm->setDateTime(date);
            comm->setMessage(message);
            comm->setmessageRate(commentRate);

            playerComments.append(comm);
        }
        getPlayerCommentFinished(playerComments);
    }
    else if (operation == Operation::Get_Bullet) {
        //TODO
        QList<BulletText*> bulletText;
        auto bullets = obj["bullets"].toArray();
        foreach (const QJsonValue & v, bullets){
            auto obj = v.toObject();
            auto bullet = obj["Bullet"].toObject();
            int id = bullet["id"].toInt();
            int userId = bullet["user_id"].toInt();
            QString comment = bullet["comment"].toString();
            QDateTime date = bullet["date_time"].toVariant().toDateTime();

            BulletText *newBulletText = new BulletText();
            newBulletText->setId(id);
            newBulletText->setUserId(userId);
            newBulletText->setComment(comment);
            newBulletText->setDateTime(date);

            bulletText.append(newBulletText);
//            qDebug()<<"comment :"<<comment<<" ,date :"<<date.toString("yyyy MM d");
        }

        emit getBulletTexFinished(bulletText);
    }
    else if(operation == Operation::Get_Game_Clock){
        QString string = obj["gameclock"].toVariant().toString();
//        QString string = "Tuesday, 23 April 12 22:51:41";
        QString format = "yyyy-MM-d hh:mm:ss";
        QDateTime gameClock = QDateTime::fromString(string, format);
        emit getGameClockFinished(gameClock);
    }else if (operation == Operation::Get_User_Comment){
                auto message = obj["message"].toString();

        QList<UserComment*> userComments;
        auto array = obj["comments"].toArray();
        foreach (const QJsonValue & a, array)
        {
            auto obj = a.toObject();
            auto usercomment = obj["UserComment"].toObject();
            auto id = usercomment["id"].toString().toInt();
            auto date = QDateTime::fromString(usercomment["date_time"].toString(), "yyyy-MM-dd hh:mm:ss");
            auto message = usercomment["comment"].toString();
            auto userId = usercomment["user_id"].toString().toInt();
            auto commentRate = usercomment["comment_rate"].toString().toInt();

            auto *comm = new UserComment();
            comm->setId(id);
            comm->setDateTime(date);
            comm->setMessage(message);
            comm->setmessageRate(commentRate);

            userComments.append(comm);
        }
        getUserCommentFinished(userComments);
    }else {
        auto message = obj["message"].toString();
        qDebug()<<"translated word :"<<message;
    }

}

#endif // APICONNECTION_H
