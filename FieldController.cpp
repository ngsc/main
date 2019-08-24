#include "FieldController.h"

// void FieldControl::drawField(QPainter & painter)
// {
// 	FieldPainter field_painter;
// 	field_painter.draw(QPainter & painter);
// }
FieldControl::FieldControl()
{};

double FieldControl::getCoeff()const
{
	return coeff;
}

void FieldControl::setCoeff(double coeff_)
{
	coeff = coeff_;
}

//void FieldControl::addStatistic(QString &statistic_)
//{
//	statistic = statistic_;
//}
//
//QString FieldControl::getStatistic()
//{
//	return statistic;
//}
