#ifndef _PLAYER_CONTROLLER__
#define _PLAYER_CONTROLLER__
#include <QObject>
#include <QDebug>
#include <QDate>
#include <QString>
#include <QAbstractListModel>
#include <QSortFilterProxyModel>
#include "player_painter.h"
#include "options.h"

class PlayerControl : public QObject
{
	Q_OBJECT
private:
	struct PlayerProperties
	{
		QColor m_color;
		int m_neck_angle;
		QVector<double> m_point;
	};
	static QVector<PlayerProperties> m_players;
	static QVector<double> m_ball_position;
	static QColor m_ball_color;
	static QString m_pitch_info;
	static QString m_foul_card_info;
public:
	//PlayerControl();
public slots:
	//QVector<int> step(int id) const;

	//color
    static QColor getPlayerColor(int player_id);
    static void setPlayerColor(int player_id, const QColor & color );

    //position
    static QVector<double> getPlayerPoint(int player_id);
    static void setPlayerPoint(int player_id, double x, double y);

    //neck angle
    static int getPlayerNeckAngle(int player_id);
    static void setPlayerNeckAngle(int player_id, int neck_angle);

    //ball position
    static QVector<double> getBallPoint();
    static void setBallPoint(double x, double y);

    //pitch_info
    static QString getPitchInfo();
    static void setPitchInfo(QString pitch_info);

	static QString getFoulCardInfo();
	static void setFoulCardInfo(QString foul_card_info);



};
#endif // _PLAYER_CONTROLLER
