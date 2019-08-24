#include "apiconnection.h"
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

#include <QNetworkReply>
#include <QByteArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

QString APIConnection::s_token = "";
const QString APIConnection::s_apiUrl = "http://173.208.200.82";

APIConnection::APIConnection(QObject *parent) : QObject(parent)
{
    connect(&m_manger, &QNetworkAccessManager::finished,
            [this] (QNetworkReply* reply) {
        if(reply->error() == QNetworkReply::NoError)
            emit replyAvailable(QString::fromUtf8(reply->readAll()));
        else //error happened
            emit errorHappened(reply->errorString());
    });

    connect(this, SIGNAL(replyAvailable(const QString&)), this, SLOT(processResponse(const QString&)));
    connect(this, SIGNAL(errorHappened(const QString&)), this, SLOT(processError(const QString&)));
}

void APIConnection::setToken(QString &token)
{
    s_token = token;
}

void APIConnection::parseJson(const QString &json)
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


        User *user = new User();
        user->setId(userId);
        user->setUsername(username);
        user->setToken(token);
        user->setFirstName(firstName);
        user->setLastName(lastName);
        user->setQuizPass(quizPass);
        user->setClubId(clubId);
		user->setClubName(clubName);
        user->setCity(city);

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
        c->setLeagueId(club["league_id"].toString().toInt());

        emit getClubDetailsFinished(c);
    }
    else if(operation == Operation::GET_PLAYER_DETAILS)
    {
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
            ou->setUserId(userId);
            ou->setUsername(username);
            ou->setFirstName(firstName);
            ou->setLastName(lastName);
            ou->setClubId(clubId);
            ou->setClubName(clubName);
            ou->setOnline(online);
            ous.append(ou);
        }

        emit getUsersFinished(ous);
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
            auto active     = invitation["status"].toString().toLower() == "active";
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
            i->setActive(active);
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

            auto *n = new News();
            n->setId(id);
            n->setNewsType(news_type);
            n->setDateTime(date);
            n->setBrief(brief);
            n->setMessage(message);
            n->setRead(read);

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
}

void APIConnection::signIn(const QString& username, const QString& password)
{
    //auto passwordBase64 = QByteArray().append(password).toBase64();
    //http://173.208.200.82/?action=signin&email=himanshunagpal25061992@gmail.com&password=xxxxx
    m_operationName["signin"] = Operation::SIGN_IN;
    auto passwordBase64 =password;
    auto url = QString("%1/?action=signin&email=%2&password=%3").arg(s_apiUrl).arg(username).arg(QString(passwordBase64));
    sendRequest(url);
}

void APIConnection::signUp(const QString &email, const QString &username, const QString &password)
{
    //auto passwordBase64 = QByteArray().append(password).toBase64();
    m_operationName["signup"] = Operation::SIGN_UP;
    auto passwordBase64 = password;
    auto url = QString("%1/?action=signup&name=%2&password=%3&email=%4").arg(s_apiUrl).arg(username).arg(QString(passwordBase64)).arg(email);
    sendRequest(url);
}

void APIConnection::updateQuizPass(const QString &token, bool success)
{
    Q_UNUSED(success)
    m_operationName["quiz_update"] = Operation::UPDATE_QUIZ_PASS;
    auto url = QString("%1/?action=quiz_update&token=%2=&quiz_pass=true").arg(s_apiUrl).arg(token);
    sendRequest(url);
}

void APIConnection::updateUser(User *user)
{
    m_operationName["update_user_details"] = Operation::UPDATE_USER_DETAILS;
    auto url = QString("%1/?action=update_user_details&token=%2&first_name=%3&last_name=%4&nick_name=%5&city=%6&club_id=%7&club_name=%8&fav_formation=%9")
            .arg(s_apiUrl)
            .arg(user->token())
            .arg(user->firstName())
            .arg(user->lastName())
            .arg(user->nickName())
            .arg(user->city())
            .arg(user->clubId())
            .arg(user->clubName())
            .arg(user->favFormation());
    sendRequest(url);
}

void APIConnection::getTournaments(const QString &token)
{
    m_operationName["get_tournaments"] = Operation::GET_TOURNAMENTS;
    auto url = QString("%1/?action=get_tournaments&token=%2").arg(s_apiUrl).arg(token);
    sendRequest(url);
}

void APIConnection::getClubPlayers(const QString &token, int club_id)
{
    m_operationName["get_club_players"] = Operation::GET_CLUB_PLAYERS;
    auto url = QString("%1/?action=get_club_players&token=%2&club_id=%3").arg(s_apiUrl).arg(token).arg(club_id);
    sendRequest(url);
}

void APIConnection::getAllPlayers(const QString &token)
{
    m_operationName["get_all_players"] = Operation::GET_ALL_PLAYERS;
    auto url = QString("%1/?action=get_all_players&token=%2").arg(s_apiUrl).arg(token);
    sendRequest(url);
}

void APIConnection::getClubDetails(const QString &token, int club_id)
{
    m_operationName["get_club_details"] = Operation::GET_CLUB_DETAILS;
    auto url = QString("%1/?action=get_club_details&token=%2&club_id=%3").arg(s_apiUrl).arg(token).arg(club_id);
    sendRequest(url);
}

void APIConnection::getClubs(const QString &token)
{
    m_operationName["get_clubs"] = Operation::GET_CLUBS;
    auto url = QString("%1/?action=get_clubs&token=%2").arg(s_apiUrl).arg(token);
    sendRequest(url);
}

void APIConnection::getPlayerDetails(const QString &token, int id)
{
    m_operationName["get_player_details"] = Operation::GET_PLAYER_DETAILS;
    auto url = QString("%1/?action=get_player_details&token=%2&player_id=%3").arg(s_apiUrl).arg(token).arg(id);
    sendRequest(url);
}

void APIConnection::getLeagueClubs(const QString &token, int club_id)
{
    m_operationName["get_league_clubs"] = Operation::GET_LEAGUE_CLUBS;
    auto url = QString("%1/?action=get_league_clubs&token=%2&club_id=%3").arg(s_apiUrl).arg(token).arg(club_id);
    sendRequest(url);
}

void APIConnection::getClubsByLeague(const QString &token, int league_id)
{
    //http://173.208.200.82/?action=get_clubs_by_league&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&league=0
    m_operationName["get_clubs_by_league"] = Operation::GET_CLUBS_BY_LEAGUE;
    auto url = QString("%1/?action=get_clubs_by_league&token=%2&league=%3").arg(s_apiUrl).arg(token).arg(league_id);
    sendRequest(url);
}

void APIConnection::getMatches(const QString &token)
{
    m_operationName["get_all_fixtures"] = Operation::GET_MATCHES;
    auto url = QString("%1/?action=get_all_fixtures&token=%2").arg(s_apiUrl).arg(token);

    sendRequest(url);
}

void APIConnection::sendRequest(const QString &url)
{
    qDebug() << "Sending: " << url;
    auto request = QNetworkRequest(QUrl(url));
    request.setRawHeader("User-Agent", "APIConnectionAgent");
    m_manger.get(request);
}

void APIConnection::processResponse(const QString &response)
{
    parseJson(response);
}

void APIConnection::processError(const QString &error)
{
    Q_UNUSED(error);
}

void APIConnection::updatePlayerPosition(const QString &token, Player *player)
{
    m_operationName["update_position"] = Operation::UPDATE_PLAYERS_POSITION;
    auto url = QString("%1/?action=update_position&token=%2&%3=%4").arg(s_apiUrl).arg(token).arg(player->id()).arg(player->assignedPosition());
    sendRequest(url);
}

void APIConnection::updatePlayerNumber(const QString &token, Player *player)
{
    m_operationName["update_number"] = Operation::UPDATE_PLAYERS_POSITION;
    if(player->number() < 0) player->setNumber(0);
    auto url = QString("%1/?action=update_number&token=%2&%3=%4").arg(s_apiUrl).arg(token).arg(player->id()).arg(player->number());
    sendRequest(url);
}

void APIConnection::updatePlayersPosition(const QString &token, QVector<Player *> players)
{
    m_operationName["update_position"] = Operation::UPDATE_PLAYERS_POSITION;
    QStringList plist;
    for(auto p: players)
    {
        if(!p->assignedPosition().trimmed().isEmpty())
            plist.append(QString("%1=%2").arg(p->id()).arg(p->assignedPosition().trimmed()));
    }

    if(plist.isEmpty())
        return;
    auto url = QString("%1/?action=update_position&token=%2&%3").arg(s_apiUrl).arg(token).arg(plist.join("&"));
    sendRequest(url);
}

void APIConnection::updatePlayersNumber(const QString &token, QVector<Player *> players)
{
    m_operationName["update_number"] = Operation::UPDATE_PLAYERS_NUMBER;
    QStringList plist;
    for(auto p: players)
    {
        if(p->number() > 0)
            plist.append(QString("%1=%2").arg(p->id()).arg(p->number()));
        else
            plist.append(QString("%1=0").arg(p->id()));
    }

    if(plist.isEmpty())
        return;
    auto url = QString("%1/?action=update_number&token=%2&%3").arg(s_apiUrl).arg(token).arg(plist.join("&"));
    sendRequest(url);
}

void APIConnection::createOffer(const QString& params)
{
    m_operationName["create_offer"] = Operation::CREATE_OFFER;
    auto url = QString("%1/?%2")
            .arg(s_apiUrl)
            .arg(params);
    sendRequest(url);
}

void APIConnection::changeOffer(const QString &params)
{
    m_operationName["change_transfer_details"] = Operation::CHANGE_OFFER_DETAILS;
    m_operationName["change_loan_details"]     = Operation::CHANGE_OFFER_DETAILS;
    auto url = QString("%1/?%2")
            .arg(s_apiUrl)
            .arg(params);
    sendRequest(url);
}

void APIConnection::getOffer(const QString &token, int offer_id)
{
    //http://173.208.200.82/?action=get_offer&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&offer_id=5
    m_operationName["get_offer"] = Operation::GET_OFFER;
    auto url = QString("%1?action=get_offer&offer_id=%2&token=%3")
            .arg(s_apiUrl)
            .arg(offer_id)
            .arg(token);
    sendRequest(url);
}

void APIConnection::getOfferWithPlayerDetails(const QString &token, int offer_id)
{
    m_operationName["get_offer_with_player_details"] = Operation::GET_OFFER_WITH_PLAYER_DETAILS;
    auto url = QString("%1?action=get_offer_with_player_details&offer_id=%2&token=%3")
            .arg(s_apiUrl)
            .arg(offer_id)
            .arg(token);
    sendRequest(url);
}

void APIConnection::withdrawOffer(const QString &token, int offer_id)
{
    //http://173.208.200.82/?action=withdrawn_offer&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&offer_id=1
    m_operationName["withdrawn_offer"] = Operation::WITHDRAW_OFFER;
    auto url = QString("%1?action=withdrawn_offer&offer_id=%2&token=%3")
            .arg(s_apiUrl)
            .arg(offer_id)
            .arg(token);


    sendRequest(url);
}

void APIConnection::acceptOffer(const QString &token, int offer_id, const QString &message)
{
    m_operationName["accept_offer"] = Operation::ACCEPT_OFFER;
    //http://173.208.200.82/?action=accept_offer&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&offer_id=1
    auto url = QString("%1?action=accept_offer&offer_id=%2&token=%3")
            .arg(s_apiUrl)
            .arg(offer_id)
            .arg(token);
    sendRequest(url);
}

void APIConnection::rejectOffer(const QString &token, int offer_id, QString message)
{
    //http://173.208.200.82/?action=reject_offer&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&offer_id=1&reason=None
    m_operationName["reject_offer"] = Operation::REJECT_OFFER;
    auto url = QString("%1?action=reject_offer&offer_id=%2&token=%3")
            .arg(s_apiUrl)
            .arg(offer_id)
            .arg(token);
    sendRequest(url);
}

void APIConnection::negotiateOffer(const QString &token, int offer_id)
{
    //http://173.208.200.82/?action=negotiate_offer&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&offer_id=1
    m_operationName["negotiate_offer"] = Operation::NEGOTIATE_OFFER;
    auto url = QString("%1/?action=negotiate_offer&token=%2&offer_id=%3").arg(s_apiUrl).arg(token).arg(offer_id);
    sendRequest(url);
}

void APIConnection::changeTransferOffer(const QString &token, int offer_id, int fee, int minimum_fee)
{
    //http://173.208.200.82/?action=change_transfer_details&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&offer_id=5&minimum_fee=70000&fee=95000
    m_operationName["change_transfer_details"] = Operation::CHANGE_OFFER_DETAILS;
    auto url = QString("%1/?action=change_transfer_details&token=%2&offer_id=%3&fee=%4&minimum_fee=%5").arg(s_apiUrl).arg(token).arg(offer_id).arg(fee).arg(minimum_fee);
    sendRequest(url);
}

void APIConnection::getNotifications(const QString &token, int club_id)
{
    m_operationName["get_notifications"] = Operation::GET_NOTIFICATIONS;
    //http://173.208.200.82/?action=get_notifications&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&club_id=1736
    auto url = QString("%1/?action=get_notifications&token=%2&club_id=%3").arg(s_apiUrl).arg(token).arg(club_id);
    sendRequest(url);
}

void APIConnection::getNews(const QString &token, int user_id)
{
    m_operationName["get_news_by_user"] = Operation::GET_NEWS;
    //http://173.208.200.82/?action=get_news_by_user&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&club_id=1736
    auto url = QString("%1/?action=get_news_by_user&token=%2&user_id=%3").arg(s_apiUrl).arg(token).arg(user_id);
    sendRequest(url);
}

void APIConnection::updateNewsReadStatus(const QString &token, int message_id)
{
    m_operationName["update_news_read"] = Operation::GET_NEWS;
    //http://173.208.200.82/?action=update_message_status&news_id=84&token=Z2s1NDU0NTQ1ZnNkZlVFc2Rmc2JEc2RoXzEzXzE1NTA4MjE3MTk=
    auto url = QString("%1/?action=update_message_status&token=%2&news_id=%3").arg(s_apiUrl).arg(token).arg(message_id);
    sendRequest(url);
}

void APIConnection::updateUserOnlineStatus(const QString &token, const QString &username)
{
    m_operationName["update_online_status"] = Operation::UPDATE_USER_ONLINE_STATUS;
    auto url = QString("%1/?action=update_online_status&token=%2&username=%3").arg(s_apiUrl).arg(token).arg(username);
    sendRequest(url);
}

void APIConnection::getUsers(const QString &token)
{
    m_operationName["get_users"] = Operation::GET_USERS;
    auto url = QString("%1/?action=get_users&token=%2").arg(s_apiUrl).arg(token);
    sendRequest(url);
}

void APIConnection::sendInvitation(const QString &token, int userId, int invitedUserId)
{
    m_operationName["invite_to_match"] = Operation::INVITE_TO_MATCH;
    auto url = QString("%1/?action=invite_to_match&token=%2&home_user_id=%3&away_user_id=%4").arg(s_apiUrl).arg(token).arg(userId).arg(invitedUserId);
    sendRequest(url);
}

void APIConnection::getInvitations(const QString &token, int userId)
{
    //http://173.208.200.82/?action=get_invites&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&user_id=16
    m_operationName["get_invites"] = Operation::GET_INVITATIONS;
    auto url = QString("%1/?action=get_invites&token=%2&user_id=%3").arg(s_apiUrl).arg(token).arg(userId);
    sendRequest(url);
}

void APIConnection::acceptInvitation(const QString &token, int invitation_id)
{
    //http://173.208.200.82/?action=accept_invite&token=Z2s1NDU0NTQ1ZnNkZlVFc2Rmc2JEc2RoXzEzXzE1NTE5ODkxODE=&invitation_id=39
    m_operationName["accept_invite"] = Operation::ACCEPT_INVITATION;
    auto url = QString("%1/?action=accept_invite&token=%2&invitation_id=%3").arg(s_apiUrl).arg(token).arg(invitation_id);
    sendRequest(url);
}

void APIConnection::declineInvitation(const QString &token, int invitation_id)
{
    //http://173.208.200.82/?action=accept_invite&token=Z2s1NDU0NTQ1ZnNkZlVFc2Rmc2JEc2RoXzEzXzE1NTE5ODkxODE=&invitation_id=39
    m_operationName["decline_invite"] = Operation::DECLINE_INVITATION;
    auto url = QString("%1/?action=decline_invite&token=%2&invitation_id=%3").arg(s_apiUrl).arg(token).arg(invitation_id);
    sendRequest(url);
}

void APIConnection::createOfferContract(const QString &params)
{
    //http://173.208.200.82/?action=create_transfer_offer_contract&token=Z2s1NDU0NTQ1ZnNkZlVFc2Rmc2JEc2RoXzI3XzE1NTI1ODQ1MTY=&offer_id=92&
    //squad_status=Rotation&job=Player&wage=10000&contract_type=Full%20Time&contract_length=3&signing_on_fee=5000000
    m_operationName["create_transfer_offer_contract"] = Operation::CREATE_OFFER_CONTRACT;
    auto url = QString("%1/?%2")
            .arg(s_apiUrl)
            .arg(params);
    sendRequest(url);
}

void APIConnection::acceptOfferContract(const QString &token, int offer_id)
{
    //http://173.208.200.82/?action=accept_transfer_contract_offer&token=Z2s1NDU0NTQ1ZnNkZlVFc2Rmc2JEc2RoXzI4XzE1NTI1ODU5NTI=&offer_id=92
    m_operationName["accept_transfer_contract_offer"] = Operation::ACCEPT_OFFER_CONTRACT;
    auto url = QString("%1/?action=accept_transfer_contract_offer&token=%2&offer_id=%3").arg(s_apiUrl).arg(token).arg(offer_id);
    sendRequest(url);
}

void APIConnection::terminateOfferContract(const QString &token, int offer_id)
{
    //http://173.208.200.82/?action=terminate_transfer_contract_offer&token=Z2s1NDU0NTQ1ZnNkZlVFc2Rmc2JEc2RoXzI4XzE1NTI1ODU5NTI=&offer_id=92
    m_operationName["terminate_transfer_contract_offer"] = Operation::TERMINATE_OFFER_CONTRACT;
    auto url = QString("%1/?action=terminate_transfer_contract_offer&token=%2&offer_id=%3").arg(s_apiUrl).arg(token).arg(offer_id);
    sendRequest(url);
}
