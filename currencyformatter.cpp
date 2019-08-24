#include "currencyformatter.h"
#include <QLocale>

CurrencyFormatter::CurrencyFormatter(QObject *parent) : QObject(parent)
{

}

QString CurrencyFormatter::currencyString(int number)
{
    return QLocale(QLocale::AnyLanguage, QLocale::AnyScript, QLocale::EuropeanUnion).toCurrencyString(number);
}

int CurrencyFormatter::currencyValue(QString currency)
{
    //pound symbol is U+00A3
    return QString(currency).replace(QString::fromWCharArray(L"\u00A3"), "").replace(",", "").toInt();
}
