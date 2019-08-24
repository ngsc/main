#ifndef NEWS_H
#define NEWS_H

#include <QObject>
#include <QDateTime>

/*
offer_id => 55
brief => Himanshu'Club make Messi bid
full_message => Himanshu'Club had made an offer of $9000000 for Messi
message2=>
stage=>OfferCreated
status=>Active
role=>OwnerClub
*/

class News : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int id READ id NOTIFY idChanged)
    Q_PROPERTY(NewsType newsType READ newsType CONSTANT)
    Q_PROPERTY(QString brief READ brief NOTIFY briefChanged)
    Q_PROPERTY(QString message READ message NOTIFY messageChanged)
    Q_PROPERTY(int offerId READ offerId NOTIFY offerIdChanged)
    Q_PROPERTY(int ownerClubId READ ownerClubId NOTIFY ownerClubIdChanged)
    Q_PROPERTY(int biddingClubId READ biddingClubId NOTIFY biddingClubIdChanged)
    Q_PROPERTY(bool read READ read WRITE setRead NOTIFY readChanged)
    Q_PROPERTY(bool active READ active NOTIFY activeChanged)
    Q_PROPERTY(Role role READ role NOTIFY roleChanged)
    Q_PROPERTY(Stage stage READ stage NOTIFY stageChanged)
    Q_PROPERTY(QDateTime dateTime READ dateTime NOTIFY dateTimeChanged)
    Q_PROPERTY(OfferType offerType READ offerType NOTIFY offerTypeChanged)

public:

    enum class NewsType {
        Offer,
        Invitation
    };

    enum class Role {
        OwnerClub,
        BiddingClub
    };

    enum class Stage {
        OfferCreated,
        OfferAccepted,
        OfferRejected,
        OfferNegotiated,
        OfferWithdrawn,
        OwnerClubDemandPrice,
        BidingClubMakeNewBid,
        OfferContract
    };

    enum class OfferType {
        Transfer,
        Loan
    };

    Q_ENUM(NewsType)
    Q_ENUM(Role)
    Q_ENUM(Stage)
    Q_ENUM(OfferType)

    explicit News(QObject *parent = nullptr);

    int id() const;
    void setId(int id);

    QString brief() const;
    void setBrief(const QString &brief);

    QString message() const;
    void setMessage(const QString &message);

    int offerId() const;
    void setOfferId(int offerId);

    bool read() const;
    void setRead(bool read);

    bool active() const;
    void setActive(bool active);

    Role role() const;
    void setRole(const Role &role);
    void setRole(const QString& role);

    Stage stage() const;
    void setStage(const Stage &stage);
    void setStage(const QString &stage);

    QDateTime dateTime() const;
    void setDateTime(const QDateTime &dateTime);

    int ownerClubId() const;
    void setOwnerClubId(int ownerClubId);

    int biddingClubId() const;
    void setBiddingClubId(int biddingClubId);

    OfferType offerType() const;
    void setOfferType(const OfferType &type);
    void setOfferType(const QString &type);

    NewsType newsType() const;
    void setNewsType(const NewsType &newsType);
    void setNewsType(const QString &newsType);

signals:
    void idChanged(int id);
    void briefChanged(QString brief);
    void messageChanged(QString message);
    void offerIdChanged(int offerId);
    void ownerClubIdChanged(int ownerClubId);
    void biddingClubIdChanged(int biddingClubId);
    void readChanged(bool read);
    void activeChanged(bool active);
    void roleChanged(Role role);
    void stageChanged(Stage stage);
    void dateTimeChanged(QDateTime dt);
    void offerTypeChanged(OfferType type);

public slots:

    /*
    offer_id => 55
    brief => Himanshu'Club make Messi bid
    full_message => Himanshu'Club had made an offer of $9000000 for Messi
    message2=>
    stage=>OfferCreated
    status=>Active
    role=>OwnerClub
    */

private:
    int m_id;
    QString m_brief;
    QString m_message;
    int m_offerId;
    int m_ownerClubId;
    int m_biddingClubId;
    bool m_read;
    bool m_active;
    Role m_role;
    Stage m_stage;
    OfferType m_offerType;
    QDateTime m_dateTime;
    NewsType m_newsType;
};

#endif // NEWS_H
