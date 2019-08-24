#ifndef ANNOUNCEMENT_H
#define ANNOUNCEMENT_H
/*
"id":"1"
"font_type":"Bold"
"message_type":"Warning"
"message":"Test"
*/
#include <QObject>

class Announcement : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int id READ id NOTIFY idChanged)
    Q_PROPERTY(int fontStyle READ fontStyle NOTIFY fontStyleChanged)
    Q_PROPERTY(int fontSize READ fontSize NOTIFY fontSizeChanged)
    Q_PROPERTY(QString fontDifference READ fontDifference NOTIFY fontDifferenceChanged)
    Q_PROPERTY(QString fontBackGround READ fontBackGround NOTIFY fontBackGroundChanged)
    Q_PROPERTY(QString fontColor READ fontColor NOTIFY fontColorChanged)
    Q_PROPERTY(QString messageType READ messageType NOTIFY messageTypeChanged)
    Q_PROPERTY(QString message READ message NOTIFY messageChanged)


public:
    explicit Announcement(QObject *parent = nullptr);

    void setId(int id);
    int id() const;

    void setFontStyle(int fontStyle);
    int fontStyle() const;

    void setFontSize(int fontSize);
    int fontSize() const;

    void setFontDifference(const QString &fontDifference);
    QString fontDifference() const;

    void setFontbackGround(const QString &backGround);
    QString fontBackGround() const;

    void setFontColor(const QString &fontColor);
    QString fontColor() const;

    void setMessageType(const QString &messageType);
    QString messageType()const;

    void setMessage(const QString &message);
    QString message()const;

    void checkAnnouncementContent(Announcement *announcement);
    void setAnnouncementNew(bool newAnnouncement);
    void setAnnouncementAlive(bool live);
    void setAnnouncementChange(bool change);

    bool isAnnouncementStillAlive()const;
    bool isNewAnnouncement()const;
    bool isChanged()const;
    std::string splitInLines(std::string source, std::size_t width);

signals:
    void idChanged(int id);
    void fontStyleChanged(int fonttype);
    void fontSizeChanged(int fontsize);
    void fontDifferenceChanged(QString fontdifference);
    void fontBackGroundChanged(QString fontbackGround);
    void fontColorChanged(QString fontcolor);
    void messageTypeChanged(QString messagetype);
    void messageChanged(QString message);

public slots:

private:
    bool m_AnnouncementLive;
    bool m_AnnouncementChanged;
    bool m_AnnouncementNew;
    int m_id;
    int m_FontStyle;
    int m_FontSize;
    QString m_BackGround;
    QString m_FontDifference;
    QString m_FontColor;
    QString m_MessageType;
    QString m_message;

};

#endif // ANNOUNCEMENT_H
