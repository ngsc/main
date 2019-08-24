#ifndef CURRENCYFORMATTER_H
#define CURRENCYFORMATTER_H

#include <QObject>

class CurrencyFormatter : public QObject
{
    Q_OBJECT
public:
    explicit CurrencyFormatter(QObject *parent = nullptr);

public slots:
    QString currencyString(int number);
    int currencyValue(QString currency);
signals:

public slots:
};

#endif // CURRENCYFORMATTER_H
