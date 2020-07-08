#include "apiconnection.h"
#include "Constants.h"
#include "simplecrypt.h"
#include "qfile.h"


QString APIConnection::s_token = "";
const QString APIConnection::s_apiUrl = "http://" + ClientConstants::serverHost;

APIConnection::APIConnection(QObject *parent)
    : QObject(parent)
    , m_background_process(new QProcess(this))
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

void APIConnection::signIn(const QString& username, const QString& password)
{
    //auto passwordBase64 = QByteArray().append(password).toBase64();
    //s_apiUrl/?action=signin&email=himanshunagpal25061992@gmail.com&password=xxxxx
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
    auto url = QString("%1/?action=update_user_details&token=%2&first_name=%3&last_name=%4&nick_name=%5&city=%6&club_id=%7&club_name=%8&fav_formation=%9&user_portrait=%10")
            .arg(s_apiUrl)
            .arg(user->token())
            .arg(user->firstName())
            .arg(user->lastName())
            .arg(user->nickName())
            .arg(user->city())
            .arg(user->clubId())
            .arg(user->clubName())
            .arg(user->favFormation())
            .arg (user->UserPortrait ());
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
    //    m_operationName["get_club_players"] = Operation::GET_CLUB_PLAYERS;
    //    auto url = QString("%1/?action=get_club_players&token=%2&club_id=%3").arg(s_apiUrl).arg(token).arg(club_id);
    //s_apiUrl/?action=get_club_players_by_sort&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&club_id=23172080
    m_operationName["get_club_players_by_sort"] = Operation::GET_CLUB_PLAYERS;
    auto url = QString("%1/?action=get_club_players_by_sort&token=%2&club_id=%3").arg(s_apiUrl).arg(token).arg(club_id);
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
    //s_apiUrl/?action=get_clubs_by_league&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&league=0
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

void APIConnection::upDateUserStatus(const QString &token,const QString &userName,const QString &userStatus)
{
    //TODO
    //    m_operationName["update_user_status"] = Operation::UPDATE_USER_STATUS;
    //    auto url = QString("%1/?action=update_user_status&token=%2&%3=%4").arg(s_apiUrl).arg(token);

    //    sendRequest(url);
}

void APIConnection::sendRequest(const QString &url)
{
    //qDebug() << "Sending: " << url;
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
    //s_apiUrl/?action=get_offer&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&offer_id=5
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
    //s_apiUrl/?action=withdrawn_offer&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&offer_id=1
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
    //s_apiUrl/?action=accept_offer&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&offer_id=1
    auto url = QString("%1?action=accept_offer&offer_id=%2&token=%3")
            .arg(s_apiUrl)
            .arg(offer_id)
            .arg(token);
    sendRequest(url);
}

void APIConnection::rejectOffer(const QString &token, int offer_id, QString message)
{
    //s_apiUrl/?action=reject_offer&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&offer_id=1&reason=None
    m_operationName["reject_offer"] = Operation::REJECT_OFFER;
    auto url = QString("%1?action=reject_offer&offer_id=%2&token=%3")
            .arg(s_apiUrl)
            .arg(offer_id)
            .arg(token);
    sendRequest(url);
}

void APIConnection::negotiateOffer(const QString &token, int offer_id)
{
    //s_apiUrl/?action=negotiate_offer&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&offer_id=1
    m_operationName["negotiate_offer"] = Operation::NEGOTIATE_OFFER;
    auto url = QString("%1/?action=negotiate_offer&token=%2&offer_id=%3").arg(s_apiUrl).arg(token).arg(offer_id);
    sendRequest(url);
}

void APIConnection::changeTransferOffer(const QString &token, int offer_id, int fee, int minimum_fee)
{
    //s_apiUrl/?action=change_transfer_details&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&offer_id=5&minimum_fee=70000&fee=95000
    m_operationName["change_transfer_details"] = Operation::CHANGE_OFFER_DETAILS;
    auto url = QString("%1/?action=change_transfer_details&token=%2&offer_id=%3&fee=%4&minimum_fee=%5").arg(s_apiUrl).arg(token).arg(offer_id).arg(fee).arg(minimum_fee);
    sendRequest(url);
}

void APIConnection::getNotifications(const QString &token, int club_id)
{
    m_operationName["get_notifications"] = Operation::GET_NOTIFICATIONS;
    //s_apiUrl/?action=get_notifications&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&club_id=1736
    auto url = QString("%1/?action=get_notifications&token=%2&club_id=%3").arg(s_apiUrl).arg(token).arg(club_id);
    sendRequest(url);
}

void APIConnection::getNews(const QString &token, int user_id)
{
    m_operationName["get_news_by_user"] = Operation::GET_NEWS;
    //s_apiUrl/?action=get_news_by_user&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&club_id=1736
    auto url = QString("%1/?action=get_news_by_user&token=%2&user_id=%3").arg(s_apiUrl).arg(token).arg(user_id);
    sendRequest(url);
}

void APIConnection::updateNewsReadStatus(const QString &token, int message_id)
{
    m_operationName["update_news_read"] = Operation::GET_NEWS;
    //s_apiUrl/?action=update_message_status&news_id=84&token=Z2s1NDU0NTQ1ZnNkZlVFc2Rmc2JEc2RoXzEzXzE1NTA4MjE3MTk=
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
    //s_apiUrl/?action=get_invites&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&user_id=16
    m_operationName["get_invites"] = Operation::GET_INVITATIONS;
    auto url = QString("%1/?action=get_invites&token=%2&user_id=%3").arg(s_apiUrl).arg(token).arg(userId);
    sendRequest(url);
}

void APIConnection::acceptInvitation(const QString &token, int invitation_id)
{
    //s_apiUrl/?action=accept_invite&token=Z2s1NDU0NTQ1ZnNkZlVFc2Rmc2JEc2RoXzEzXzE1NTE5ODkxODE=&invitation_id=39
    m_operationName["accept_invite"] = Operation::ACCEPT_INVITATION;
    auto url = QString("%1/?action=accept_invite&token=%2&invitation_id=%3").arg(s_apiUrl).arg(token).arg(invitation_id);
    sendRequest(url);
}

void APIConnection::declineInvitation(const QString &token, int invitation_id)
{
    //s_apiUrl/?action=accept_invite&token=Z2s1NDU0NTQ1ZnNkZlVFc2Rmc2JEc2RoXzEzXzE1NTE5ODkxODE=&invitation_id=39
    m_operationName["decline_invite"] = Operation::DECLINE_INVITATION;
    auto url = QString("%1/?action=decline_invite&token=%2&invitation_id=%3").arg(s_apiUrl).arg(token).arg(invitation_id);
    sendRequest(url);
}

void APIConnection::createOfferContract(const QString &params)
{
    //s_apiUrl/?action=create_transfer_offer_contract&token=Z2s1NDU0NTQ1ZnNkZlVFc2Rmc2JEc2RoXzI3XzE1NTI1ODQ1MTY=&offer_id=92&
    //squad_status=Rotation&job=Player&wage=10000&contract_type=Full%20Time&contract_length=3&signing_on_fee=5000000
    m_operationName["create_transfer_offer_contract"] = Operation::CREATE_OFFER_CONTRACT;
    auto url = QString("%1/?%2")
            .arg(s_apiUrl)
            .arg(params);
    sendRequest(url);
}

void APIConnection::acceptOfferContract(const QString &token, int offer_id)
{
    //s_apiUrl/?action=accept_transfer_contract_offer&token=Z2s1NDU0NTQ1ZnNkZlVFc2Rmc2JEc2RoXzI4XzE1NTI1ODU5NTI=&offer_id=92
    m_operationName["accept_transfer_contract_offer"] = Operation::ACCEPT_OFFER_CONTRACT;
    auto url = QString("%1/?action=accept_transfer_contract_offer&token=%2&offer_id=%3").arg(s_apiUrl).arg(token).arg(offer_id);
    sendRequest(url);
}

void APIConnection::terminateOfferContract(const QString &token, int offer_id)
{
    //s_apiUrl/?action=terminate_transfer_contract_offer&token=Z2s1NDU0NTQ1ZnNkZlVFc2Rmc2JEc2RoXzI4XzE1NTI1ODU5NTI=&offer_id=92
    m_operationName["terminate_transfer_contract_offer"] = Operation::TERMINATE_OFFER_CONTRACT;
    auto url = QString("%1/?action=terminate_transfer_contract_offer&token=%2&offer_id=%3").arg(s_apiUrl).arg(token).arg(offer_id);
    sendRequest(url);
}
/////////////
void APIConnection::getAnnouncement(const QString &token)
{
    //s_apiUrl/?action=get_announcements&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf
    m_operationName["get_announcements"] = Operation::Get_Announcement;
    auto url = QString("%1/?action=get_announcements&token=%2").arg(s_apiUrl).arg(token);
    sendRequest(url);
}

void APIConnection::sendResign(const QString &token, int user_id)
{
    m_operationName["resign_user"] = Operation::Get_Resign;
    auto url = QString("%1/?action=resign_user&token=%2&user_id=%3").arg(s_apiUrl).arg(token).arg (user_id);
    sendRequest(url);
}

void APIConnection::getPublicNews(const QString &token)
{
    m_operationName["get_public_news"] = Operation::Get_Public_News;
    //s_apiUrl/?action=get_notifications&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&club_id=1736
    auto url = QString("%1/?action=get_public_news&token=%2").arg(s_apiUrl).arg(token);
    sendRequest(url);
}

void APIConnection::sendRetire(const QString &token, int user_id)
{
    m_operationName["retire_user"] = Operation::Get_Retire;
    auto url = QString("%1/?action=retire_user&token=%2&user_id=%3").arg(s_apiUrl).arg(token).arg (user_id);
    sendRequest(url);
}

void APIConnection::updatePublicNewsReadStatus(const QString &token, int news_id)
{
    m_operationName["update_pubic_news_read"] = Operation::Send_Message;
    //s_apiUrl/?action=update_message_status&news_id=84&token=Z2s1NDU0NTQ1ZnNkZlVFc2Rmc2JEc2RoXzEzXzE1NTA4MjE3MTk=
    auto url = QString("%1/?action=update_pubic_news_read&token=%2&news_id=%3").arg(s_apiUrl).arg(token).arg(news_id);
    sendRequest(url);
}

void APIConnection::increasePlayerRate(const QString &token, int player_id)
{
    m_operationName["increase_player_rate"] = Operation::Send_Message;//s_apiUrl/?action=increase_player_like_rate
    //s_apiUrl/?action=update_message_status&news_id=84&token=Z2s1NDU0NTQ1ZnNkZlVFc2Rmc2JEc2RoXzEzXzE1NTA4MjE3MTk=
    auto url = QString("%1/?action=increase_player_like_rate&token=%2&player_id=%3").arg(s_apiUrl).arg(token).arg(player_id);
    sendRequest(url);
}

void APIConnection::decreasePlayerRate(const QString &token, int player_id)
{
    m_operationName["decrease_player_rate"] = Operation::Send_Message;//increase_player_dislike_rate
    //s_apiUrl/?action=update_message_status&news_id=84&token=Z2s1NDU0NTQ1ZnNkZlVFc2Rmc2JEc2RoXzEzXzE1NTA4MjE3MTk=
    auto url = QString("%1/?action=increase_player_dislike_rate&token=%2&player_id=%3").arg(s_apiUrl).arg(token).arg(player_id);
    sendRequest(url);
}

void APIConnection::likeplayerComment(const QString &token, int player_id, int commentID)
{
    qDebug()<<"like player comment";
    m_operationName["like_player_announcement"] = Operation::Send_Message;
    //s_apiUrl/?action=increase_comment_rate&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&comment_id=8
    auto url = QString("%1/?action=increase_comment_rate&token=%2&&comment_id=%3").arg(s_apiUrl)
            .arg(token).arg(commentID);//.arg(player_id)
    sendRequest(url);
}

void APIConnection::setPlayerComment(const QString &token, int player_id, const QString &comment)
{
    m_operationName["create_player_comment"] = Operation::Send_Message;
    //s_apiUrl/?action=create_player_comment&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&player_id=11252&player_comment=comment2
    auto url = QString("%1/?action=create_player_comment&token=%2&player_id=%3&player_comment=%4").arg(s_apiUrl)
            .arg(token).arg(player_id).arg(comment);
    sendRequest(url);
}

void APIConnection::getPlayerComment(const QString &token, int player_id)
{
    qDebug()<<"get player comment";
    m_operationName["get_player_comment"] = Operation::Get_Player_Comment;
    //s_apiUrl/?action=update_message_status&news_id=84&token=Z2s1NDU0NTQ1ZnNkZlVFc2Rmc2JEc2RoXzEzXzE1NTA4MjE3MTk=
    auto url = QString("%1/?action=get_player_comment&token=%2&player_id=%3").arg(s_apiUrl)
            .arg(token).arg(player_id);
    sendRequest(url);
}

void APIConnection::getBulletText(const QString &token)
{
    m_operationName["get_bullet"] = Operation::Get_Bullet;
    //s_apiUrl/?action=update_message_status&news_id=84&token=Z2s1NDU0NTQ1ZnNkZlVFc2Rmc2JEc2RoXzEzXzE1NTA4MjE3MTk=
    auto url = QString("%1/?action=get_bullet&token=%2").arg(s_apiUrl).arg(token);
    sendRequest(url);
}

void APIConnection::createBullet(const QString &token, int user_id, const QString &comment)
{
    m_operationName["create_bullet"] = Operation::Send_Message;
    //s_apiUrl/?action=update_message_status&news_id=84&token=Z2s1NDU0NTQ1ZnNkZlVFc2Rmc2JEc2RoXzEzXzE1NTA4MjE3MTk=
    auto url = QString("%1/?action=create_bullet&token=%2&user_id=%3&comment=%4").arg(s_apiUrl)
            .arg(token).arg(user_id).arg(comment);
    sendRequest(url);
}

void APIConnection::getGameClock(const QString &token)
{
    //s_apiUrl/?action=get_game_clock&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf
    m_operationName["get_game_clock"] = Operation::Get_Game_Clock;
    auto url = QString("%1/?action=get_game_clock&token=%2").arg(s_apiUrl).arg(token);
    sendRequest(url);
}

void APIConnection::likeUserComment(const QString &token, int user_id, int commentID)
{
    qDebug()<<"like user comment";
    m_operationName["like_user_announcement"] = Operation::Send_Message;
    //s_apiUrl/?action=increase_comment_rate&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&comment_id=8
    auto url = QString("%1/?action=increase_user_comment_rate&token=%2&&comment_id=%3").arg(s_apiUrl)
            .arg(token).arg(commentID);//.arg(player_id)
    sendRequest(url);
}

void APIConnection::setUserComment(const QString &token, int user_id, const QString &comment)
{
    m_operationName["create_user_comment"] = Operation::Send_Message;
    //s_apiUrl/?action=create_player_comment&token=DpYfshD2Ck49YrGkB5EkVCpYctG7dSmf&player_id=11252&player_comment=comment2
    auto url = QString("%1/?action=create_user_comment&token=%2&user_id=%3&comment=%4").arg(s_apiUrl)
            .arg(token).arg(user_id).arg(comment);
    sendRequest(url);
}

void APIConnection::getUserComment(const QString &token, int user_id)
{
    qDebug()<<"get user comment";
    m_operationName["get_user_comment"] = Operation::Get_User_Comment;
    //s_apiUrl/?action=update_message_status&news_id=84&token=Z2s1NDU0NTQ1ZnNkZlVFc2Rmc2JEc2RoXzEzXzE1NTA4MjE3MTk=
    auto url = QString("%1/?action=get_user_comment&token=%2&user_id=%3").arg(s_apiUrl).arg(token).arg(user_id);
    sendRequest(url);
}

void APIConnection::setPlayerValue(const QString &token, int player_id, int value)
{
    m_operationName["set_player_value"] = Operation::Send_Message;
    auto url = QString("%1/?action=set_player_value&token=%2&player_id=%3&value=%4").arg(s_apiUrl).arg(token).arg(player_id).arg(value);
    sendRequest(url);
}

void APIConnection::createTransferOfferContract(const QString &token, int offer_id, QString squad_status,
                                                QString job,int wage,QString contract_type, int contract_length, int signing_on_fee)
{
    m_operationName["create_transfer_offer_contract"] = Operation::Create_Transfer_Offer_Contract;
    auto url = QString("%1/?action=create_transfer_offer_contract&token=%2&offer_id=%3&squad_status=%4"
                       "&job=%5&wage=%6&contract_type=%7&contract_length=%8&signing_on_fee=%9")
            .arg(s_apiUrl).arg(token).arg(offer_id).arg(squad_status).arg(job).arg(wage).arg(contract_type)
            .arg(contract_length).arg(signing_on_fee);
    sendRequest(url);
}

void APIConnection::acceptTransferContractOffer(const QString &token, int offer_id)
{
    m_operationName["accept_transfer_contract_offer"] = Operation::Send_Message;
    auto url = QString("%1/?action=accept_transfer_contract_offer&token=%2&offer_id=%3").arg(s_apiUrl).arg(token).arg(offer_id);
    sendRequest(url);
}

void APIConnection::terminateTransferContractOffer(const QString &token, int offer_id)
{
    m_operationName["terminate_transfer_contract_offer"] = Operation::Send_Message;
    auto url = QString("%1/?action=terminate_transfer_contract_offer&token=%2&offer_id=%3").arg(s_apiUrl).arg(token).arg(offer_id);
    sendRequest(url);
}

void APIConnection::createFreeOfferContract(const QString &token, int player_id,int bidding_club_id, QString squad_status,
                                            int wage,QString contract_type, int contract_length, int signing_on_fee)
{
    m_operationName["create_free_offer_contract"] = Operation::Send_Message;
    auto url = QString("%1/?action=create_free_offer_contract&token=%2&player_id=%3&bidding_club_id=%4"
                       "&squad_status=%5&wage=%6&contract_type=%7&contract_length=%8&signing_on_fee=%9")
            .arg(s_apiUrl).arg(token).arg(player_id).arg(bidding_club_id).arg(squad_status).arg(wage)
            .arg(contract_type).arg(contract_length).arg(signing_on_fee);
    sendRequest(url);
}

void APIConnection::acceptFreePlayerContractOffer(const QString &token, int contract_id)
{
    m_operationName["accept_free_player_contract_offer"] = Operation::Send_Message;
    auto url = QString("%1/?action=accept_free_player_contract_offer&token=%2&offer_id=%3").arg(s_apiUrl).arg(token).arg(contract_id);
    sendRequest(url);
}

void APIConnection::terminateFreePlayerContractOffer(const QString &token, int contract_id)
{
    m_operationName["terminate_free_player_contract_offer"] = Operation::Send_Message;
    auto url = QString("%1/?terminate_free_player_contract_offer&token=%2&offer_id=%3").arg(s_apiUrl).arg(token).arg(contract_id);
    sendRequest(url);
}

void APIConnection::startMatchServerCmd(int homeClubId, int awayClubId )
{
    using namespace ClientConstants;

    SimpleCrypt crypto(key); //some random number
    QFile file( "polo" );
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return;
    QString encrypted = file.readLine();

    QString decrypted = crypto.decryptToString(encrypted);

    // TODO: start server with different parameters;
    QString startServerCmd = "./startserver.sh 0 " + QString::number(homeClubId) + " " + QString::number(awayClubId) + " 0 0";
    QString cmd = "plink -ssh -no-antispoof " + user + "@" + serverHost +  " -pw " + decrypted +  " \"cd " + matchServerSrcPath + " ; "  + startServerCmd + "\"";
    m_background_process->start( cmd );
}
