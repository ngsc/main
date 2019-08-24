#include "announcement.h"
#include <QVariant>
#include <QDebug>
#include <iostream>
#include <string>

Announcement::Announcement(QObject *parent) : QObject(parent)
{
    setAnnouncementNew(true);
    setAnnouncementAlive(true);

}

void Announcement::setId(int id)
{
    m_id = id;
}

int Announcement::id() const
{
    return m_id;
}

void Announcement::setFontStyle(int fontStyle)
{
    m_FontStyle = fontStyle;
}

int Announcement::fontStyle() const
{
    return m_FontStyle;
}

void Announcement::setFontSize(int fontSize)
{
    m_FontSize = fontSize;
}

int Announcement::fontSize() const
{
    return m_FontSize;
}

void Announcement::setFontDifference(const QString &fontDifference)
{
    m_FontDifference = fontDifference;
}

QString Announcement::fontDifference() const
{
    return m_FontDifference;
}

void Announcement::setFontbackGround(const QString &backGround)
{
    m_BackGround = backGround.toLower ();
}

QString Announcement::fontBackGround() const
{
    return m_BackGround;
}

void Announcement::setFontColor(const QString &fontColor)
{
    m_FontColor = fontColor.toLower ();
}

QString Announcement::fontColor() const
{
    return m_FontColor;
}

void Announcement::setMessageType(const QString &messageType)
{
    m_MessageType = messageType;
}

QString Announcement::messageType() const
{
    return m_MessageType;
}

void Announcement::setMessage(const QString &message)
{
    std::string current_locale_text = message.toLocal8Bit().constData();
    std::string result = splitInLines(current_locale_text, 30);
    m_message = QString::fromStdString(result);
}

QString Announcement::message() const
{
    return m_message;
}

void Announcement::checkAnnouncementContent(Announcement *announcement)
{
    if(announcement->fontStyle ()== m_FontStyle ||
            announcement->fontColor () == m_FontColor||
            announcement->messageType () == m_MessageType||
            announcement->message () == m_message||
            announcement->fontBackGround ()== m_BackGround||
            announcement->fontSize () == m_FontSize||
            announcement->fontDifference () == m_FontDifference){

        setAnnouncementAlive(true);
        setAnnouncementNew(false);
        setAnnouncementChange (false);
    }else{

        m_FontStyle = announcement->fontStyle ();
        m_FontColor = announcement->fontColor ();
        m_MessageType = announcement->messageType ();
        m_message = announcement->message ();
        m_FontDifference = announcement->fontDifference ();
        m_FontSize = announcement->fontSize ();
        m_BackGround = announcement->fontBackGround ();

        setAnnouncementAlive(true);
        setAnnouncementNew(false);
        setAnnouncementChange (true);
    }
}

void Announcement::setAnnouncementNew(bool newAnnouncement)
{
    m_AnnouncementNew = newAnnouncement;
}

void Announcement::setAnnouncementAlive(bool live)
{
    m_AnnouncementLive = live;
}

void Announcement::setAnnouncementChange(bool change)
{
    m_AnnouncementChanged = change;
}

bool Announcement::isAnnouncementStillAlive() const
{
    return m_AnnouncementLive;
}

bool Announcement::isNewAnnouncement() const
{
    return m_AnnouncementNew;
}

bool Announcement::isChanged() const
{
    return m_AnnouncementChanged;
}

std::string Announcement::splitInLines(std::string source, std::size_t width)
{
    std::string whitespace = " \t\r";
    std::size_t  currIndex = width - 1;
    std::size_t  sizeToElim;
    while ( currIndex < source.length() )
    {
        currIndex = source.find_last_of(whitespace,currIndex + 1);
        if (currIndex == std::string::npos)
            break;
        currIndex = source.find_last_not_of(whitespace,currIndex);
        if (currIndex == std::string::npos)
            break;
        sizeToElim = source.find_first_not_of(whitespace,currIndex + 1) - currIndex - 1;
        source.replace( currIndex + 1, sizeToElim , "\n");
        currIndex += (width + 1); //due to the recently inserted "\n"
    }
    return source;
}
