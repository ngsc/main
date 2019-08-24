#ifndef PLAYER_H
#define PLAYER_H

#include <QObject>
#include <QDate>


/*

  `id` int(11) NOT NULL,
  `club_id` int(11) NOT NULL,
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `nation` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `country` varchar(2) NOT NULL,
  `position` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `age` int(11) DEFAULT NULL,
  `int_caps` int(11) DEFAULT NULL,
  `int_goals` int(11) DEFAULT NULL,
  `cur_a` int(11) DEFAULT NULL,
  `pot_a` int(11) DEFAULT NULL,
  `a_diff` int(11) DEFAULT NULL,
  `based` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `home_rep` int(11) DEFAULT NULL,
  `current_rep` int(11) DEFAULT NULL,
  `world_rep` int(11) DEFAULT NULL,
  `date_of_birth` date NOT NULL

*/

class PlayerInfo {
public:
    int id() const;
    void setId(int id);

    QString name() const;
    void setName(const QString &name);

    int number() const;
    bool setNumber(int number);

    int clubId() const;
    void setClubId(int clubId);

    QString clubName() const;
    void setClubName(const QString &clubName);

    QString nation() const;
    void setNation(const QString &nation);

    QString proposedPosition() const;
    void setProposedPosition(const QString &position);

    int age() const;
    void setAge(int age);

    int intCaps() const;
    void setIntCaps(int intCaps);

    int intGoals() const;
    void setIntGoals(int intGoals);

    int curA() const;
    void setCurA(int curA);

    int potA() const;
    void setPotA(int potA);

    int aDiff() const;
    void setADiff(int aDiff);

    QString based() const;
    void setBased(const QString &based);

    int homeRep() const;
    void setHomeRep(int homeRep);

    int currentRep() const;
    void setCurrentRep(int currentRep);

    int worldRep() const;
    void setWorldRep(int worldRep);

    QDate dob() const;
    void setDob(const QDate &dob);

    QString foreground1Value() const;
    void setForeground1Value(const QString &foreground1Value);

    QString background1Value() const;
    void setBackground1Value(const QString &background1Value);

    QString assignedPosition() const;
    bool setAssignedPosition(const QString &assignedPosition);

    int offerId() const;
    void setOfferId(int offerId);

private:
    int m_id = 0;
    QString m_name;
    int m_number = 0;
    int m_clubId = 0;
    QString m_clubName;
    QString m_nation;
    QString m_proposedPosition;
    QString m_assignedPosition;
    int m_age = 0;
    int m_intCaps = 0;
    int m_intGoals = 0;
    int m_curA = 0;
    int m_potA = 0;
    int m_aDiff = 0;
    QString m_based;
    int m_homeRep = 0;
    int m_currentRep = 0;
    int m_worldRep = 0;
    QDate m_dob;
    QString m_foreground1Value;
    QString m_background1Value;
    int m_offerId;
};


/*

  `id` int(11) DEFAULT NULL,
  `division` varchar(45) DEFAULT NULL,
  `squad` varchar(45) DEFAULT NULL,
  `squad_rep` int(11) DEFAULT NULL,
  `joined_club` varchar(45) DEFAULT NULL,
  `contract_end` varchar(45) DEFAULT NULL,
  `leaving_on_bosman` tinyint(1) DEFAULT NULL,
  `minimum_fee` int(11) DEFAULT NULL,
  `relegation_fee` int(11) DEFAULT NULL,
  `non_promotion_fee` int(11) DEFAULT NULL,
  `squad_status` tinyint(1) NOT NULL,
  `perceived_squad_status` varchar(45) DEFAULT NULL,
  `transfer_status` int(11) NOT NULL,
   wage 	int(11) 			No 	None 			Change Change 	Drop Drop
   value 	int(11) 			No 	None 			Change Change 	Drop Drop
   sale_value 	int(11) 			No 	None 			Change Change 	Drop Drop
   happiness_level

*/
class PlayerContracts
{
public:

    QString division() const;
    void setDivision(const QString &division);

    QString squad() const;
    void setSquad(const QString &squad);

    int squadRep() const;
    void setSquadRep(int squadRep);

    QString joinedClub() const;
    void setJoinedClub(const QString &joinedClub);

    QString contractEnd() const;
    void setContractEnd(const QString &contractEnd);

    int leavingOnBosman() const;
    void setLeavingOnBosman(int leavingOnBosman);

    int minimumFee() const;
    void setMinimumFee(int minimumFee);

    int relegationFee() const;
    void setRelegationFee(int relegationFee);

    int nonPromotionFee() const;
    void setNonPromotionFee(int nonPromotionFee);

    int squadStatus() const;
    void setSquadStatus(int squadStatus);

    QString perceivedSquadStatus() const;
    void setPerceivedSquadStatus(const QString &perceivedSquadStatus);

    int transferStatus() const;
    void setTransferStatus(int transferStatus);

    int wage() const;
    void setWage(int wage);

    int value() const;
    void setValue(int value);

    int saleValue() const;
    void setSaleValue(int saleValue);

    int happinessLevel() const;
    void setHappinessLevel(int happinessLevel);

private:
    QString m_division;
    QString m_squad;
    int m_squadRep;
    QString m_joinedClub;
    QString m_contractEnd;
    int m_leavingOnBosman;
    int m_minimumFee;
    int m_relegationFee;
    int m_nonPromotionFee;
    int m_squadStatus;
    QString m_perceivedSquadStatus;
    int m_transferStatus;
    int m_wage;
    int m_value;
    int m_saleValue;
    int m_happinessLevel;
};

/*
 *
 * id : "915351"
acceleration : "13"
adaptability : "14"
aerial_ability : "2"
aggression : "14"
agility : "13"
ambition : "13"
anticipation : "14"
balance : "13"
bravery : "16"
command_of_area : "3"
communication : "2"
composure : "12"
fr : "0"
concentration : "14"
consistency : "14"
controversy : "8"
corners : "8"
vision : "12"
crossing : "12"
decisions : "13"
determination : "15"
dirtiness : "14"
dribbling : "12"
eccentricity : "2"
finishing : "8"
first_touch : "12"
flair : "11"
handling : "3"
heading : "13"
important_matches : "14"
leadership : "12"
injury_proneness : "14"
jumping : "12"
kicking : "3"
long_shots : "9"
long_throws : "12"
loyalty : "13"
marking : "14"
natural_fitness : "12"
off_the_ball : "13"
one_on_ones : "2"
pace : "13"
passing : "11"
penalties : "8"
positioning : "15"
pressure : "14"
professionalism : "16"
reflexes : "1"
rushing_out : "3"
free_kicks : "7"
sportsmanship : "13"
stamina : "13"
strength : "11"
tackling : "15"
teamwork : "14"
technique : "11"
temperament : "12"
throwing : "2"
versatility : "16"
work_rate : "14"
tendency_to_punch : "2"
left_foot : "9"
right_foot : "20"
1
 * */
class PlayerAttributes
{
public:
    int m_acceleration;
    int m_adaptability;
    int m_aerialAbility;
    int m_aggression;
    int m_agility;
    int m_ambition;
    int m_anticipation;
    int m_balance;
    int m_bravery;
    int m_commandOfArea;
    int m_communication;
    int m_composure;
    int m_fr;
    int m_concentration;
    int m_consistency;
    int m_controversy;
    int m_corners;
    int m_vision;
    int m_crossing;
    int m_decisions;
    int m_determination;
    int m_dirtiness;
    int m_dribbling;
    int m_eccentricity;
    int m_finishing;
    int m_firstTouch;
    int m_flair;
    int m_handling;
    int m_heading;
    int m_importantMatches;
    int m_leadership;
    int m_injuryProneness;
    int m_jumping;
    int m_kicking;
    int m_longShots;
    int m_longThrows;
    int m_loyalty;
    int m_marking;
    int m_naturalFitness;
    int m_offTheBall;
    int m_oneOnOnes;
    int m_pace;
    int m_passing;
    int m_penalties;
    int m_positioning;
    int m_pressure;
    int m_professionalism;
    int m_reflexes;
    int m_rushingOut;
    int m_freeKicks;
    int m_sportsmanship;
    int m_stamina;
    int m_strength;
    int m_tackling;
    int m_teamwork;
    int m_technique;
    int m_temperament;
    int m_throwing;
    int m_versatility;
    int m_workRate;
    int m_tendencyToPunch;
    int m_leftFoot;
    int m_rightFoot;
};

class Player : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int id READ id  CONSTANT/*WRITE setId NOTIFY idChanged*/)
    Q_PROPERTY(QString name READ name  CONSTANT/*WRITE setName NOTIFY nameChanged*/)
    Q_PROPERTY(int clubId READ clubId CONSTANT)
    Q_PROPERTY(int number READ number WRITE setNumber NOTIFY numberChanged)
    Q_PROPERTY(QString clubName READ clubName CONSTANT)
    Q_PROPERTY(QString proposedPosition READ proposedPosition CONSTANT)
    Q_PROPERTY(QString assignedPosition READ assignedPosition WRITE setAssignedPosition NOTIFY assignedPositionChanged)
    Q_PROPERTY(QString nation READ nation CONSTANT)
    Q_PROPERTY(int age READ age CONSTANT CONSTANT)
    Q_PROPERTY(int caps READ caps CONSTANT)
    Q_PROPERTY(int goals READ goals CONSTANT)
    Q_PROPERTY(int curA READ curA CONSTANT)
    Q_PROPERTY(int potA READ potA CONSTANT)
    Q_PROPERTY(int aDiff READ aDiff CONSTANT)
    Q_PROPERTY(QString based READ based CONSTANT)
    Q_PROPERTY(int homeRep READ homeRep CONSTANT)
    Q_PROPERTY(int currentRep READ currentRep CONSTANT)
    Q_PROPERTY(int worldRep READ worldRep CONSTANT)
    Q_PROPERTY(QDate dob READ dob CONSTANT)
    Q_PROPERTY(QString foreground1Value READ foreground1Value CONSTANT)
    Q_PROPERTY(QString background1Value READ background1Value CONSTANT)

    //attributes
    Q_PROPERTY(int acceleration READ acceleration CONSTANT)
    Q_PROPERTY(int adaptability READ adaptability CONSTANT)
    Q_PROPERTY(int aerialAbility READ aerialAbility CONSTANT)
    Q_PROPERTY(int aggression READ aggression CONSTANT)
    Q_PROPERTY(int agility READ agility CONSTANT)
    Q_PROPERTY(int ambition READ ambition CONSTANT)
    Q_PROPERTY(int anticipation READ anticipation CONSTANT)
    Q_PROPERTY(int balance READ balance CONSTANT)
    Q_PROPERTY(int bravery READ bravery CONSTANT)
    Q_PROPERTY(int commandOfArea READ commandOfArea CONSTANT)
    Q_PROPERTY(int communication READ communication CONSTANT)
    Q_PROPERTY(int composure READ composure CONSTANT)
    Q_PROPERTY(int fr READ fr CONSTANT)
    Q_PROPERTY(int concentration READ concentration CONSTANT)
    Q_PROPERTY(int consistency READ consistency CONSTANT)
    Q_PROPERTY(int controversy READ controversy CONSTANT)
    Q_PROPERTY(int corners READ corners CONSTANT)
    Q_PROPERTY(int vision READ vision CONSTANT)
    Q_PROPERTY(int crossing READ crossing CONSTANT)
    Q_PROPERTY(int decisions READ decisions CONSTANT)
    Q_PROPERTY(int determination READ determination CONSTANT)
    Q_PROPERTY(int dirtiness READ dirtiness CONSTANT)
    Q_PROPERTY(int dribbling READ dribbling CONSTANT)
    Q_PROPERTY(int eccentricity READ eccentricity CONSTANT)
    Q_PROPERTY(int finishing READ finishing CONSTANT)
    Q_PROPERTY(int firstTouch READ firstTouch CONSTANT)
    Q_PROPERTY(int flair READ flair CONSTANT)
    Q_PROPERTY(int handling READ handling CONSTANT)
    Q_PROPERTY(int heading READ heading CONSTANT)
    Q_PROPERTY(int importantMatches READ importantMatches CONSTANT)
    Q_PROPERTY(int leadership READ leadership CONSTANT)
    Q_PROPERTY(int injuryProneness READ injuryProneness CONSTANT)
    Q_PROPERTY(int jumping READ jumping CONSTANT)
    Q_PROPERTY(int kicking READ kicking CONSTANT)
    Q_PROPERTY(int longShots READ longShots CONSTANT)
    Q_PROPERTY(int longThrows READ longThrows CONSTANT)
    Q_PROPERTY(int loyalty READ loyalty CONSTANT)
    Q_PROPERTY(int marking READ marking CONSTANT)
    Q_PROPERTY(int naturalFitness READ naturalFitness CONSTANT)
    Q_PROPERTY(int offTheBall READ offTheBall CONSTANT)
    Q_PROPERTY(int oneOnOnes READ oneOnOnes CONSTANT)
    Q_PROPERTY(int pace READ pace CONSTANT)
    Q_PROPERTY(int passing READ passing CONSTANT)
    Q_PROPERTY(int penalties READ penalties CONSTANT)
    Q_PROPERTY(int positioning READ positioning CONSTANT)
    Q_PROPERTY(int pressure READ pressure CONSTANT)
    Q_PROPERTY(int professionalism READ professionalism CONSTANT)
    Q_PROPERTY(int reflexes READ reflexes CONSTANT)
    Q_PROPERTY(int rushingOut READ rushingOut CONSTANT)
    Q_PROPERTY(int freeKicks READ freeKicks CONSTANT)
    Q_PROPERTY(int sportsmanship READ sportsmanship CONSTANT)
    Q_PROPERTY(int stamina READ stamina CONSTANT)
    Q_PROPERTY(int strength READ strength CONSTANT)
    Q_PROPERTY(int tackling READ tackling CONSTANT)
    Q_PROPERTY(int teamwork READ teamwork CONSTANT)
    Q_PROPERTY(int technique READ technique CONSTANT)
    Q_PROPERTY(int temperament READ temperament CONSTANT)
    Q_PROPERTY(int throwing READ throwing CONSTANT)
    Q_PROPERTY(int versatility READ versatility CONSTANT)
    Q_PROPERTY(int workRate READ workRate CONSTANT)
    Q_PROPERTY(int tendencyToPunch READ tendencyToPunch CONSTANT)
    Q_PROPERTY(int leftFoot READ leftFoot CONSTANT)
    Q_PROPERTY(int rightFoot READ rightFoot CONSTANT)

    //contract
    Q_PROPERTY(QString division READ division CONSTANT)
    Q_PROPERTY(QString squad READ squad CONSTANT)
    Q_PROPERTY(int squadRep READ squadRep CONSTANT)
    Q_PROPERTY(QString joinedClub READ joinedClub CONSTANT)
    Q_PROPERTY(QString contractEnd READ contractEnd CONSTANT)
    Q_PROPERTY(int leavingOnBosman READ leavingOnBosman CONSTANT)
    Q_PROPERTY(int minimumFee READ minimumFee CONSTANT)
    Q_PROPERTY(int relegationFee READ relegationFee CONSTANT)
    Q_PROPERTY(int nonPromotionFee READ nonPromotionFee CONSTANT)
    Q_PROPERTY(int squadStatus READ squadStatus CONSTANT)
    Q_PROPERTY(QString perceivedSquadStatus READ perceivedSquadStatus CONSTANT)
    Q_PROPERTY(int transferStatus READ transferStatus CONSTANT)
    Q_PROPERTY(int wage READ wage CONSTANT)
    Q_PROPERTY(int value READ value CONSTANT)
    Q_PROPERTY(int saleValue READ saleValue CONSTANT)
    Q_PROPERTY(int happinessLevel READ happinessLevel CONSTANT)


    //extra attributes
    Q_PROPERTY(int running READ running CONSTANT)
    Q_PROPERTY(int challenging READ challenging CONSTANT)
    Q_PROPERTY(int body READ body CONSTANT)
    Q_PROPERTY(int setPiece READ setPiece CONSTANT)
    Q_PROPERTY(int shooting READ shooting CONSTANT)
    Q_PROPERTY(int goalkeeping READ goalkeeping CONSTANT)
    Q_PROPERTY(int hidden READ hidden CONSTANT)

    Q_PROPERTY(bool isGoalkeeper READ isGoalkeeper CONSTANT)
    Q_PROPERTY(bool isDefender READ isDefender CONSTANT)
    Q_PROPERTY(bool isMidfielder READ isMidfielder CONSTANT)
    Q_PROPERTY(bool isAttacker READ isAttacker CONSTANT)

    Q_PROPERTY(int offerId READ offerId WRITE setOfferId NOTIFY offerIdChanged)

public:
    explicit Player(QObject *parent = nullptr);
    explicit Player(QObject* parent, const PlayerInfo& info, const PlayerAttributes& attr, const PlayerContracts& contracts);

    void setInfo(const PlayerInfo& info);
    void setAttributes(const PlayerAttributes& attr);
    void setContracts(const PlayerContracts& contracts);

    PlayerInfo& info();
    PlayerAttributes& attributes();
    PlayerContracts& contracts();

    int id() const;
    QString name() const;
    int number() const;
    void setNumber(int number);
    int clubId() const;
    QString clubName() const;
    QString nation() const;
    QString proposedPosition() const;
    QString assignedPosition() const;
    void setAssignedPosition(QString position);
    int age() const;
    int caps() const;
    int goals() const;
    int curA() const;
    int potA() const;
    int aDiff() const;
    QString based() const;
    int homeRep() const;
    int currentRep() const;
    int worldRep() const;
    QDate dob() const;
    QString foreground1Value() const;
    QString background1Value() const;
    int offerId() const;
    void setOfferId(int offerId);
    //----------------------------------------------
    // player attributes
    int acceleration() const;
    int adaptability() const;
    int aerialAbility() const;
    int aggression() const;
    int agility() const;
    int ambition() const;
    int anticipation() const;
    int balance() const;
    int bravery() const;
    int commandOfArea() const;
    int communication() const;
    int composure() const;
    int fr() const;
    int concentration() const;
    int consistency() const;
    int controversy() const;
    int corners() const;
    int vision() const;
    int crossing() const;
    int decisions() const;
    int determination() const;
    int dirtiness() const;
    int dribbling() const;
    int eccentricity() const;
    int finishing() const;
    int firstTouch() const;
    int flair() const;
    int handling() const;
    int heading() const;
    int importantMatches() const;
    int leadership() const;
    int injuryProneness() const;
    int jumping() const;
    int kicking() const;
    int longShots() const;
    int longThrows() const;
    int loyalty() const;
    int marking() const;
    int naturalFitness() const;
    int offTheBall() const;
    int oneOnOnes() const;
    int pace() const;
    int passing() const;
    int penalties() const;
    int positioning() const;
    int pressure() const;
    int professionalism() const;
    int reflexes() const;
    int rushingOut() const;
    int freeKicks() const;
    int sportsmanship() const;
    int stamina() const;
    int strength() const;
    int tackling() const;
    int teamwork() const;
    int technique() const;
    int temperament() const;
    int throwing() const;
    int versatility() const;
    int workRate() const;
    int tendencyToPunch() const;
    int leftFoot() const;
    int rightFoot() const;

    //------------------------------------------------
    // player contracts
    QString division() const;
    QString squad() const;
    int squadRep() const;
    QString joinedClub() const;
    QString contractEnd() const;
    int leavingOnBosman() const;
    int minimumFee() const;
    int relegationFee() const;
    int nonPromotionFee() const;
    int squadStatus() const;
    QString perceivedSquadStatus() const;
    int transferStatus() const;
    int wage() const;
    int value() const;
    int saleValue() const;
    int happinessLevel() const;

    bool isGoalkeeper() const;
    bool isDefender() const;
    bool isMidfielder() const;
    bool isAttacker() const;
//signals:


    int running() const;
    int challenging() const;
    int body() const;
    int setPiece() const;


    //position
    int shooting() const;
    int goalkeeping() const;
    int hidden() const;

//public slots:

signals:
    void assignedPositionChanged(QString position);
    void numberChanged(int number);
    void offerIdChanged(int offerId);

private:

    PlayerInfo m_info;
    PlayerAttributes m_attributes;
    PlayerContracts m_contracts;
};

#endif // PLAYER_H
