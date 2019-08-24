#include "player.h"

#include <QDebug>

int PlayerInfo::id() const
{
    return m_id;
}

void PlayerInfo::setId(int id)
{
    m_id = id;
}

QString PlayerInfo::name() const
{
    return m_name;
}

void PlayerInfo::setName(const QString &name)
{
    m_name = name;
}

int PlayerInfo::clubId() const
{
    return m_clubId;
}

void PlayerInfo::setClubId(int clubId)
{
    m_clubId = clubId;
}

QString PlayerInfo::nation() const
{
    return m_nation;
}

void PlayerInfo::setNation(const QString &nation)
{
    m_nation = nation;
}

QString PlayerInfo::proposedPosition() const
{
    return m_proposedPosition;
}

void PlayerInfo::setProposedPosition(const QString &proposedPosition)
{
    if(proposedPosition != m_proposedPosition)
        m_proposedPosition = proposedPosition;
}

int PlayerInfo::age() const
{
    return m_age;
}

void PlayerInfo::setAge(int age)
{
    m_age = age;
}

int PlayerInfo::intCaps() const
{
    return m_intCaps;
}

void PlayerInfo::setIntCaps(int intCaps)
{
    m_intCaps = intCaps;
}

int PlayerInfo::intGoals() const
{
    return m_intGoals;
}

void PlayerInfo::setIntGoals(int intGoals)
{
    m_intGoals = intGoals;
}

int PlayerInfo::curA() const
{
    return m_curA;
}

void PlayerInfo::setCurA(int curA)
{
    m_curA = curA;
}

int PlayerInfo::potA() const
{
    return m_potA;
}

void PlayerInfo::setPotA(int potA)
{
    m_potA = potA;
}

int PlayerInfo::aDiff() const
{
    return m_aDiff;
}

void PlayerInfo::setADiff(int aDiff)
{
    m_aDiff = aDiff;
}

QString PlayerInfo::based() const
{
    return m_based;
}

void PlayerInfo::setBased(const QString &based)
{
    m_based = based;
}

int PlayerInfo::homeRep() const
{
    return m_homeRep;
}

void PlayerInfo::setHomeRep(int homeRep)
{
    m_homeRep = homeRep;
}

int PlayerInfo::currentRep() const
{
    return m_currentRep;
}

void PlayerInfo::setCurrentRep(int currentRep)
{
    m_currentRep = currentRep;
}

int PlayerInfo::worldRep() const
{
    return m_worldRep;
}

void PlayerInfo::setWorldRep(int worldRep)
{
    m_worldRep = worldRep;
}

QDate PlayerInfo::dob() const
{
    return m_dob;
}

void PlayerInfo::setDob(const QDate &dob)
{
    m_dob = dob;
}

QString PlayerInfo::foreground1Value() const
{
    return m_foreground1Value;
}

void PlayerInfo::setForeground1Value(const QString &foreground1Value)
{
    m_foreground1Value = foreground1Value;
}

QString PlayerInfo::background1Value() const
{
    return m_background1Value;
}

void PlayerInfo::setBackground1Value(const QString &background1Value)
{
    m_background1Value = background1Value;
}

QString PlayerInfo::assignedPosition() const
{
    return m_assignedPosition;
}

bool PlayerInfo::setAssignedPosition(const QString &assignedPosition)
{
    if(m_assignedPosition == assignedPosition)
        return false;
    m_assignedPosition = assignedPosition;
    return true;
}

int PlayerInfo::offerId() const
{
    return m_offerId;
}

void PlayerInfo::setOfferId(int offerId)
{
    m_offerId = offerId;
}

int PlayerInfo::number() const
{
    return m_number;
}

bool PlayerInfo::setNumber(int number)
{
    if(number == m_number)
        return false;

    if(number < 0) number = 0;
    	m_number = number;
	return true;
}

QString PlayerInfo::clubName() const
{
    return m_clubName;
}

void PlayerInfo::setClubName(const QString &clubName)
{
    m_clubName = clubName;
}


//--------------------------------------------
// player contracts
QString PlayerContracts::division() const
{
    return m_division;
}

void PlayerContracts::setDivision(const QString &division)
{
    m_division = division;
}

QString PlayerContracts::squad() const
{
    return m_squad;
}

void PlayerContracts::setSquad(const QString &squad)
{
    m_squad = squad;
}

int PlayerContracts::squadRep() const
{
    return m_squadRep;
}

void PlayerContracts::setSquadRep(int squadRep)
{
    m_squadRep = squadRep;
}

QString PlayerContracts::joinedClub() const
{
    return m_joinedClub;
}

void PlayerContracts::setJoinedClub(const QString &joinedClub)
{
    m_joinedClub = joinedClub;
}

QString PlayerContracts::contractEnd() const
{
    return m_contractEnd;
}

void PlayerContracts::setContractEnd(const QString &contractEnd)
{
    m_contractEnd = contractEnd;
}

int PlayerContracts::leavingOnBosman() const
{
    return m_leavingOnBosman;
}

void PlayerContracts::setLeavingOnBosman(int leavingOnBosman)
{
    m_leavingOnBosman = leavingOnBosman;
}

int PlayerContracts::minimumFee() const
{
    return m_minimumFee;
}

void PlayerContracts::setMinimumFee(int minimumFee)
{
    m_minimumFee = minimumFee;
}

int PlayerContracts::relegationFee() const
{
    return m_relegationFee;
}

void PlayerContracts::setRelegationFee(int relegationFee)
{
    m_relegationFee = relegationFee;
}

int PlayerContracts::nonPromotionFee() const
{
    return m_nonPromotionFee;
}

void PlayerContracts::setNonPromotionFee(int nonPromotionFee)
{
    m_nonPromotionFee = nonPromotionFee;
}

int PlayerContracts::squadStatus() const
{
    return m_squadStatus;
}

void PlayerContracts::setSquadStatus(int squadStatus)
{
    m_squadStatus = squadStatus;
}

QString PlayerContracts::perceivedSquadStatus() const
{
    return m_perceivedSquadStatus;
}

void PlayerContracts::setPerceivedSquadStatus(const QString &perceivedSquadStatus)
{
    m_perceivedSquadStatus = perceivedSquadStatus;
}

int PlayerContracts::transferStatus() const
{
    return m_transferStatus;
}

void PlayerContracts::setTransferStatus(int transferStatus)
{
    m_transferStatus = transferStatus;
}

int PlayerContracts::wage() const
{
    return m_wage;
}

void PlayerContracts::setWage(int wage)
{
    m_wage = wage;
}

int PlayerContracts::value() const
{
    return m_value;
}

void PlayerContracts::setValue(int value)
{
    m_value = value;
}

int PlayerContracts::saleValue() const
{
    return m_saleValue;
}

void PlayerContracts::setSaleValue(int saleValue)
{
    m_saleValue = saleValue;
}

int PlayerContracts::happinessLevel() const
{
    return m_happinessLevel;
}

void PlayerContracts::setHappinessLevel(int happinessLevel)
{
    m_happinessLevel = happinessLevel;
}


//--------------------------------------------

Player::Player(QObject *parent) : QObject(parent)
{
    
}

Player::Player(QObject* parent, const PlayerInfo &info, const PlayerAttributes& attr, const PlayerContracts &contracts)
    : QObject (parent), m_info(info), m_attributes(attr), m_contracts(contracts)
{
    
}

void Player::setInfo(const PlayerInfo &info)
{
    m_info = info;
}

void Player::setAttributes(const PlayerAttributes &attr)
{
    m_attributes = attr;
}

void Player::setContracts(const PlayerContracts &contracts)
{
    m_contracts = contracts;
}

PlayerInfo &Player::info()
{
    return m_info;
}

PlayerAttributes &Player::attributes()
{
    return m_attributes;
}

PlayerContracts &Player::contracts()
{
    return m_contracts;
}

//Player info properties
int Player::id() const
{
    return m_info.id();
}

QString Player::name() const
{
    return m_info.name();
}

int Player::number() const
{
    return m_info.number();
}

void Player::setNumber(int number)
{
    if(m_info.setNumber(number))
		emit numberChanged(number);
}

int Player::clubId() const
{
    return m_info.clubId();
}

QString Player::clubName() const
{
    return m_info.clubName();
}

QString Player::nation() const
{
    return m_info.nation();
}

QString Player::proposedPosition() const
{
    return m_info.proposedPosition();
}

QString Player::assignedPosition() const
{
    return m_info.assignedPosition();
}

void Player::setAssignedPosition(QString position)
{
    if(m_info.setAssignedPosition(position))
    	emit assignedPositionChanged(position);
}

int Player::age() const
{
    return m_info.age();
}

int Player::caps() const
{
    return m_info.intCaps();
}

int Player::goals() const
{
    return m_info.intGoals();
}

int Player::curA() const
{
    return m_info.curA();
}

int Player::potA() const
{
    return m_info.potA();
}

int Player::aDiff() const
{
    return m_info.aDiff();
}

QString Player::based() const
{
    return m_info.based();
}

int Player::homeRep() const
{
    return m_info.homeRep();
}

int Player::currentRep() const
{
    return m_info.currentRep();
}

int Player::worldRep() const
{
    return m_info.worldRep();
}

QDate Player::dob() const
{
    return m_info.dob();
}

QString Player::foreground1Value() const
{
    return m_info.foreground1Value();
}

QString Player::background1Value() const
{
    return m_info.background1Value();
}

int Player::offerId() const
{
    return m_info.offerId();
}

void Player::setOfferId(int offerId)
{
    m_info.setOfferId(offerId);
    emit offerIdChanged(m_info.offerId());
}

//Player attributes properties
int Player::acceleration() const
{
    return m_attributes.m_acceleration;
}

int Player::adaptability() const
{
    return m_attributes.m_adaptability;
}

int Player::aerialAbility() const
{
    return m_attributes.m_aerialAbility;
}

int Player::aggression() const
{
    return m_attributes.m_aggression;
}

int Player::agility() const
{
    return m_attributes.m_agility;
}

int Player::ambition() const
{
    return m_attributes.m_ambition;
}

int Player::anticipation() const
{
    return m_attributes.m_anticipation;
}

int Player::balance() const
{
    return m_attributes.m_balance;
}

int Player::bravery() const
{
    return m_attributes.m_bravery;
}

int Player::commandOfArea() const
{
    return m_attributes.m_commandOfArea;
}

int Player::communication() const
{
    return m_attributes.m_communication;
}

int Player::composure() const
{
    return m_attributes.m_composure;
}

int Player::fr() const
{
    return m_attributes.m_fr;
}

int Player::concentration() const
{
    return m_attributes.m_concentration;
}

int Player::consistency() const
{
    return m_attributes.m_consistency;
}

int Player::controversy() const
{
    return m_attributes.m_controversy;
}

int Player::corners() const
{
    return m_attributes.m_corners;
}

int Player::vision() const
{
    return m_attributes.m_vision;
}

int Player::crossing() const
{
    return m_attributes.m_crossing;
}

int Player::decisions() const
{
    return m_attributes.m_decisions;
}

int Player::determination() const
{
    return m_attributes.m_determination;
}

int Player::dirtiness() const
{
    return m_attributes.m_dirtiness;
}

int Player::dribbling() const
{
    return m_attributes.m_dribbling;
}

int Player::eccentricity() const
{
    return m_attributes.m_eccentricity;
}

int Player::finishing() const
{
    return m_attributes.m_finishing;
}

int Player::firstTouch() const
{
    return m_attributes.m_firstTouch;
}

int Player::flair() const
{
    return m_attributes.m_flair;
}

int Player::handling() const
{
    return m_attributes.m_handling;
}

int Player::heading() const
{
    return m_attributes.m_heading;
}

int Player::importantMatches() const
{
    return m_attributes.m_importantMatches;
}

int Player::leadership() const
{
    return m_attributes.m_leadership;
}

int Player::injuryProneness() const
{
    return m_attributes.m_injuryProneness;
}

int Player::jumping() const
{
    return m_attributes.m_jumping;
}

int Player::kicking() const
{
    return m_attributes.m_kicking;
}

int Player::longShots() const
{
    return m_attributes.m_longShots;
}

int Player::longThrows() const
{
    return m_attributes.m_longThrows;
}

int Player::loyalty() const
{
    return m_attributes.m_loyalty;
}

int Player::marking() const
{
    return m_attributes.m_marking;
}

int Player::naturalFitness() const
{
    return m_attributes.m_naturalFitness;
}

int Player::offTheBall() const
{
    return m_attributes.m_offTheBall;
}

int Player::oneOnOnes() const
{
    return m_attributes.m_oneOnOnes;
}

int Player::pace() const
{
    return m_attributes.m_pace;
}

int Player::passing() const
{
    return m_attributes.m_passing;
}

int Player::penalties() const
{
    return m_attributes.m_penalties;
}

int Player::positioning() const
{
    return m_attributes.m_positioning;
}

int Player::pressure() const
{
    return m_attributes.m_pressure;
}

int Player::professionalism() const
{
    return m_attributes.m_professionalism;
}

int Player::reflexes() const
{
    return m_attributes.m_reflexes;
}

int Player::rushingOut() const
{
    return m_attributes.m_rushingOut;
}

int Player::freeKicks() const
{
    return m_attributes.m_freeKicks;
}

int Player::sportsmanship() const
{
    return m_attributes.m_sportsmanship;
}

int Player::stamina() const
{
    return m_attributes.m_stamina;
}

int Player::strength() const
{
    return m_attributes.m_strength;
}

int Player::tackling() const
{
    return m_attributes.m_tackling;
}

int Player::teamwork() const
{
    return m_attributes.m_teamwork;
}

int Player::technique() const
{
    return m_attributes.m_technique;
}

int Player::temperament() const
{
    return m_attributes.m_temperament;
}

int Player::throwing() const
{
    return m_attributes.m_throwing;
}

int Player::versatility() const
{
    return m_attributes.m_versatility;
}

int Player::workRate() const
{
    return m_attributes.m_workRate;
}

int Player::tendencyToPunch() const
{
    return m_attributes.m_tendencyToPunch;
}

int Player::leftFoot() const
{
    return m_attributes.m_leftFoot;
}

int Player::rightFoot() const
{
    return m_attributes.m_rightFoot;
}

//------------------------------------------------
// player contracts

QString Player::division() const
{
    return m_contracts.division();
}

QString Player::squad() const
{
    return m_contracts.squad();
}

int Player::squadRep() const
{
    return m_contracts.squadRep();
}

QString Player::joinedClub() const
{
    return m_contracts.joinedClub();
}

QString Player::contractEnd() const
{
    return m_contracts.contractEnd();
}

int Player::leavingOnBosman() const
{
    return m_contracts.leavingOnBosman();
}

int Player::minimumFee() const
{
    return m_contracts.minimumFee();
}

int Player::relegationFee() const
{
    return m_contracts.relegationFee();
}

int Player::nonPromotionFee() const
{
    return m_contracts.nonPromotionFee();
}

int Player::squadStatus() const
{
    return m_contracts.squadStatus();
}

QString Player::perceivedSquadStatus() const
{
    return m_contracts.perceivedSquadStatus();
}

int Player::transferStatus() const
{
    return m_contracts.transferStatus();
}

int Player::wage() const
{
    return m_contracts.wage();
}

int Player::value() const
{
    return m_contracts.value();
}

int Player::saleValue() const
{
    return m_contracts.saleValue();
}

int Player::happinessLevel() const
{
    return m_contracts.happinessLevel();
}

//------------------------------------------------
// extra player checks

bool Player::isGoalkeeper() const
{
    return proposedPosition().toUpper() == "GK";
}

bool Player::isDefender() const
{
    auto pos = proposedPosition().toUpper();
    return pos == "SW" || pos == "D C" || pos== "D R" || pos == "D L"
            || pos == "D RC" || pos == "D LC" || pos == "D RL"
            || pos == "D RLC" || pos == "WB R" || pos == "WB L" || pos == "WB RL";
}

bool Player::isMidfielder() const
{
    auto pos = proposedPosition().toUpper();
    return pos == "DM" || pos == "M C" || pos == "M R" || pos == "M L" ||
            pos == "M RC" || pos == "M LC" || pos == " M RL" || pos == "M RLC" ||
            pos == "AM C" || pos == "AM R" || pos == "AM L" || pos == "AM RC" ||
            pos == "AM LC" || pos == "AM RLC" || pos == "AM RL";
}

bool Player::isAttacker() const
{
    auto pos = proposedPosition().toUpper();
    return pos == "AM C" || pos == "AM R" || pos == "AM L" || pos == "AM RC" ||
            pos == "AM LC" || pos == "AM RLC" || pos == "AM RL" || pos == "ST";
}

int Player::running() const
{
    return acceleration() + pace() + dribbling();
}

int Player::challenging() const
{
    return aggression() + bravery() + marking() + tackling() + decisions();
}

int Player::body() const
{
    return agility() + balance() + strength() + naturalFitness();
}

int Player::setPiece() const
{
    return freeKicks() + penalties();
}

int Player::shooting() const
{
    return finishing() + longShots() + anticipation() + offTheBall() + composure();
}

int Player::goalkeeping() const
{
    //9.	Goalkeeping :including Handling;OneOnOnes;Positioning;Reflexes;Kicking;Rusing out;Communication;Eccentricity; Tendency to punch;Command of area; Aerial ability
    return heading() + oneOnOnes() + positioning() + reflexes() + kicking() + rushingOut() +
            communication() + eccentricity() + tendencyToPunch() + commandOfArea() + aerialAbility();

}

int Player::hidden() const
{
    //10.	Hidden :including Consistency;ImportantMatches;Leadership;Teamwork;Versatility,
    //WorkRate;Controversay; Determination;Pressure;Professionalism;Sportsmanship; Teamwork;Temperament; Versatility
    return consistency() + importantMatches() + leadership() + teamwork() + versatility() + workRate() +
            controversy() + determination() + pressure() + professionalism() + sportsmanship() + temperament();
}

