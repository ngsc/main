#include "bullets.h"
#include <QDebug>
Bullets::Bullets(QObject *parent) : QObject(parent)
{

}

void Bullets::setBulletText(QList<BulletText *> bulletText)
{
    m_BulletText = bulletText;
    m_BulletTextString.clear();
    for(int i = 0 ; i < m_BulletText.count() ; i++){
        m_BulletTextString.append(m_BulletText.at(i)->comment()+"   ");//+"<-"+m_BulletText.at(i)->dateTime().toString("yyyy-MM-dd hh:mm")+"   ");
    }
    m_BulletTextSize = getbulletText().count();
    qDebug()<<m_BulletTextString;

}

QString Bullets::getbulletText()
{
    return m_BulletTextString;
}

int Bullets::getbulletTextSize()
{
    return m_BulletTextSize;
}
