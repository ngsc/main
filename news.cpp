#include "news.h"
#include <QVariant>
#include <QDebug>

News::News(QObject *parent) : QObject(parent)
{

}

int News::id() const
{
    return m_id;
}

void News::setId(int id)
{
    m_id = id;
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
