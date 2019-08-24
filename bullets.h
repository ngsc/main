#ifndef BULLETS_H
#define BULLETS_H

#include "bullettext.h"
#include <QObject>

class Bullets : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString getbulletText READ getbulletText  CONSTANT)
    Q_PROPERTY(int getbulletTextSize READ getbulletTextSize CONSTANT)
public:
    explicit Bullets(QObject *parent = nullptr);

    QString getbulletText();
    int getbulletTextSize();

signals:
    void getbullets(QString bullets,int size);

public slots:
    void setBulletText(QList<BulletText*> bulletText);

private:
    QList <BulletText*> m_BulletText;
    QString m_BulletTextString;
    int m_BulletTextSize;
};

#endif // BULLETS_H
