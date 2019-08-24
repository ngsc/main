#ifndef _FIELD_CONTROLLER_H__
#define _FIELD_CONTROLLER_H__
#include <QObject>
#include <QDebug>
#include <QDate>
#include <QAbstractListModel>
#include <QSortFilterProxyModel>
#include <QPainter>
#include <QString>

#include "field_painter.h"
#include "options.h"

class FieldControl : public QObject
{
	Q_OBJECT

	Q_PROPERTY(int q_left_x MEMBER left_x)
	Q_PROPERTY(int q_right_x MEMBER right_x)
	Q_PROPERTY(int q_top_y MEMBER top_y)
	Q_PROPERTY(int q_bottom_y MEMBER bottom_y)

	Q_PROPERTY(int q_pitch_length MEMBER pitch_length)
	Q_PROPERTY(int q_pitch_width MEMBER pitch_width)
	Q_PROPERTY(int q_pitch_half_length MEMBER pitch_half_length)
	Q_PROPERTY(int q_pitch_half_width MEMBER pitch_half_width)
	Q_PROPERTY(int q_pitch_margin MEMBER pitch_margin)
	Q_PROPERTY(int q_centre_circle_r MEMBER centre_circle_r)
	Q_PROPERTY(int q_penalty_area_height MEMBER penalty_area_height)
	Q_PROPERTY(int q_penalty_area_width MEMBER penalty_area_width)
	Q_PROPERTY(int q_penalty_circle_r MEMBER penalty_circle_r)
	Q_PROPERTY(int q_penalty_spot_dist MEMBER penalty_spot_dist)
	Q_PROPERTY(int q_goal_width MEMBER goal_width)
	Q_PROPERTY(int q_goal_half_width MEMBER goal_half_width)
	Q_PROPERTY(int q_goal_area_length MEMBER goal_area_length)
	Q_PROPERTY(int q_goal_area_width MEMBER goal_area_width)
	Q_PROPERTY(int q_goal_depth MEMBER goal_depth)
	Q_PROPERTY(int q_pcorner_arc_r MEMBER corner_arc_r)
	Q_PROPERTY(int q_goal_post_radius MEMBER goal_post_radius)

	Q_PROPERTY(QColor q_field_color MEMBER field_color)
	Q_PROPERTY(QColor q_line_color MEMBER line_color)
	Q_PROPERTY(QColor q_measure_line_color MEMBER measure_line_color)
	Q_PROPERTY(QColor q_measure_mark_color MEMBER measure_mark_color)
	Q_PROPERTY(QColor q_measure_font_color MEMBER measure_font_color)
	Q_PROPERTY(QColor q_measure_font_color2 MEMBER measure_font_color2)
	Q_PROPERTY(QColor q_score_board_pen_color MEMBER score_board_pen_color)
	Q_PROPERTY(QColor q_score_board_brush_color MEMBER score_board_brush_color)
	Q_PROPERTY(QColor q_ball_color MEMBER ball_color)

private:
	// QString statistics;
	double coeff = 3;
public:
	FieldControl();

	void addStatistic(QString &statistic_);
	QString getStatistic();
	double getCoeff() const;
	void setCoeff(double coeff_);
	//void drawField(QPainter & painter);
//public slots: 
	double center_x = 200;
	double center_y = 200;
	double left_x = center_x - Options::PITCH_LENGTH;
	double right_x = center_x + Options::PITCH_LENGTH;
	double top_y = center_y - Options::PITCH_WIDTH;
	double bottom_y = center_y + Options::PITCH_WIDTH;

	double pitch_length = Options::PITCH_LENGTH * coeff;
	double pitch_width = Options::PITCH_WIDTH * coeff;
	double pitch_half_length = pitch_length / 2;
	double pitch_half_width = pitch_width / 2;
	double pitch_margin = Options::PITCH_MARGIN;
	double centre_circle_r = Options::CENTER_CIRCLE_R * coeff;
	double penalty_area_height = Options::PENALTY_AREA_LENGTH * coeff;
	double penalty_area_width = Options::PENALTY_AREA_WIDTH * coeff;
	double penalty_circle_r = Options::PENALTY_CIRCLE_R * coeff;
	double penalty_spot_dist = Options::PENALTY_SPOT_DIST * coeff;
	double goal_width = Options::GOAL_WIDTH * coeff;
	double goal_half_width = Options::GOAL_HALF_WIDTH * coeff;
	double goal_area_length = Options::GOAL_AREA_LENGTH * coeff;
	double goal_area_width = Options::GOAL_AREA_WIDTH * coeff;
	double goal_depth = Options::GOAL_DEPTH * coeff;
	double corner_arc_r = Options::CORNER_ARC_R * coeff;
	double goal_post_radius = Options::GOAL_POST_RADIUS * coeff;

	QColor field_color = Options::FIELD_COLOR;
	QColor line_color = Options::LINE_COLOR;
	QColor measure_line_color = Options::MEASURE_LINE_COLOR;
	QColor measure_mark_color = Options::MEASURE_MARK_COLOR;
	QColor measure_font_color = Options::MEASURE_FONT_COLOR;
	QColor measure_font_color2 = Options::MEASURE_FONT_COLOR2;
	QColor score_board_pen_color = Options::SCORE_BOARD_PEN_COLOR;
	QColor score_board_brush_color = Options::SCORE_BOARD_BRUSH_COLOR;
	QColor ball_color = Options::BALL_COLOR;
	QColor ball_vel_color = Options::BALL_VEL_COLOR;
	QColor player_pen_color = Options::PLAYER_PEN_COLOR;
	QColor left_team_color = Options::LEFT_TEAM_COLOR;
	QColor left_goalie_color = Options::LEFT_GOALIE_COLOR;
	QColor right_team_color = Options::RIGHT_TEAM_COLOR;
	QColor right_goalie_color = Options::RIGHT_GOALIE_COLOR;
	QColor player_number_color = Options::PLAYER_NUMBER_COLOR;
	QColor player_number_inner_color = Options::PLAYER_NUMBER_INNER_COLOR;
	QColor neck_color = Options::NECK_COLOR;
	QColor view_area_color = Options::VIEW_AREA_COLOR;
	QColor large_view_area_color = Options::LARGE_VIEW_AREA_COLOR;
	QColor ball_collide_color = Options::BALL_COLLIDE_COLOR;
	QColor player_collide_color = Options::PLAYER_COLLIDE_COLOR;
	QColor effort_decayed_color = Options::EFFORT_DECAYED_COLOR;
	QColor recovery_decayed_color = Options::RECOVERY_DECAYED_COLOR;
	QColor kick_color = Options::KICK_COLOR;
	QColor kick_fault_color = Options::KICK_FAULT_COLOR;
	QColor kick_accel_color = Options::KICK_ACCEL_COLOR;
	QColor catch_color = Options::CATCH_COLOR;
	QColor catch_fault_color = Options::CATCH_FAULT_COLOR;
	QColor tackle_color = Options::TACKLE_COLOR;
	QColor tackle_fault_color = Options::TACKLE_FAULT_COLOR;
	QColor foul_charged_color = Options::FOUL_CHARGED_COLOR;
	QColor pointto_color =Options::POINTTO_COLOR;

};

#endif //_FIELD_CONTROLLER_H__
