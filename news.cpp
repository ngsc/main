#include "news.h"
#include <QVariant>
#include <QDebug>

News::News(QObject *parent) : QObject(parent)
{

}

Club *News::club() const
{
    return m_SelectedClub;
}

void News::setClub(Club *club)
{
    m_SelectedClub = club;
    emit clubChanged(club);
}

int News::id() const
{
    return m_id;
}

void News::setId(int id)
{
    m_id = id;
}

int News::invitationId() const
{
    return m_InvitationId;
}

void News::setInvitationId(int id)
{
    m_InvitationId = id ;
}

QString News::brief() const
{
    return m_brief;
}

void News::setBrief(const QString &brief)
{
    m_brief = brief;
}

QString News::message() const
{
    return m_message;
}

void News::setMessage(const QString &message)
{
    m_message = message;
    emit messageChanged(message);
}

int News::offerId() const
{
    return m_offerId;
}

void News::setOfferId(int offerId)
{
    m_offerId = offerId;
}

bool News::active() const
{
    return m_active;
}

void News::setActive(bool active)
{
    m_active = active;
}

News::Role News::role() const
{
    return m_role;
}

void News::setRole(const Role &role)
{
    m_role = role;
}

void News::setRole(const QString &role)
{
    if(role.toLower() == QVariant::fromValue(Role::OwnerClub).toString().toLower())
        m_role = Role::OwnerClub;
    else if(role.toLower() == QVariant::fromValue(Role::BiddingClub).toString().toLower())
        m_role = Role::BiddingClub;
}

News::Stage News::stage() const
{
    return m_stage;
}

void News::setStage(const Stage &stage)
{
    m_stage = stage;
}

void News::setStage(const QString &stage)
{
    if(stage.toLower() == QVariant::fromValue(Stage::OfferCreated).toString().toLower())
        m_stage = Stage::OfferCreated;
    else if(stage.toLower() == QVariant::fromValue(Stage::OfferAccepted).toString().toLower())
        m_stage = Stage::OfferAccepted;
    else if(stage.toLower() == QVariant::fromValue(Stage::OfferRejected).toString().toLower())
        m_stage = Stage::OfferRejected;
    else if(stage.toLower() == QVariant::fromValue(Stage::OfferWithdrawn).toString().toLower())
        m_stage = Stage::OfferWithdrawn;
    else if(stage.toLower() == QVariant::fromValue(Stage::OfferNegotiated).toString().toLower())
        m_stage = Stage::OfferNegotiated;
    else if(stage.toLower() == QVariant::fromValue(Stage::OwnerClubDemandPrice).toString().toLower())
        m_stage = Stage::OwnerClubDemandPrice;
    else if(stage.toLower() == QVariant::fromValue(Stage::BidingClubMakeNewBid).toString().toLower())
        m_stage = Stage::BidingClubMakeNewBid;
    else if(stage.toLower() == QVariant::fromValue(Stage::OfferContract).toString().toLower())
        m_stage = Stage::OfferContract;
}

QDateTime News::dateTime() const
{
    return m_dateTime;
}

void News::setDateTime(const QDateTime &dateTime)
{
    m_dateTime = dateTime;
}

int News::ownerClubId() const
{
    return m_ownerClubId;
}

void News::setOwnerClubId(int ownerClubId)
{
    m_ownerClubId = ownerClubId;
}

int News::biddingClubId() const
{
    return m_biddingClubId;
}

void News::setBiddingClubId(int biddingClubId)
{
    m_biddingClubId = biddingClubId;
}

News::OfferType News::offerType() const
{
    return m_offerType;
}

void News::setOfferType(const OfferType &type)
{
    m_offerType = type;
}

void News::setOfferType(const QString &type)
{
    if(type.toLower() == QVariant::fromValue(OfferType::Transfer).toString().toLower())
        m_offerType = OfferType::Transfer;
    else if(type.toLower() == QVariant::fromValue(OfferType::Loan).toString().toLower())
        m_offerType = OfferType::Loan;
}

News::NewsType News::newsType() const
{
    return m_newsType;
}

void News::setNewsType(const NewsType &newsType)
{
    m_newsType = newsType;
}

void News::setNewsType(const QString &newsType)
{
    if(newsType.toLower() == QVariant::fromValue(NewsType::Offer).toString().toLower())
        m_newsType = NewsType::Offer;
    else if(newsType.toLower() == QVariant::fromValue(NewsType::Invitation).toString().toLower())
        m_newsType = NewsType::Invitation;
}

bool News::read() const
{
    return m_read;
}

void News::setRead(bool read)
{
    m_read = read;
    emit readChanged(read);
}

void News::checkNewsContent(News *n)
{
    if(n->brief ()== m_brief ||
            n->offerId () == m_offerId||
            n->message () == m_message||
            n->read ()== m_read||
            n->active () == m_active||
            n->role () == m_role||
            n->dateTime () == m_dateTime||
            n->ownerClubId () == m_ownerClubId||
            n->biddingClubId () == m_biddingClubId||
            n->offerType () == m_offerType||
            n->newsType () == m_newsType||
            n->stage () == m_stage||
            n->invitationId () == m_InvitationId){

                setNewsAlive(true);
        //        setAnnouncementNew(false);
        //        setAnnouncementChange (false);
    }else{

        m_brief  = n->brief ();
        m_offerId = n->offerId ();
        m_message = n->message ();
        m_read = n->read ();
        m_active = n->active ();
        m_role = n->role ();
        m_dateTime = n->dateTime ();
        m_ownerClubId = n->ownerClubId ();
        m_biddingClubId = n->biddingClubId ();
        m_offerType = n->offerType ();
        m_newsType = n->newsType ();
        m_stage = n->stage ();
        m_InvitationId = n->invitationId ();

                setNewsAlive(true);
        //        setAnnouncementNew(false);
        //        setAnnouncementChange (true);
    }
}

void News::setNewsAlive(bool live)
{
    m_live = live;
}

bool News::isStillAlive() const
{
    return m_live;
}

void News::setNewstypePublic(bool type)
{
    m_isPublicNews = type;
}

bool News::isPublicNews() const
{
    return m_isPublicNews;
}
