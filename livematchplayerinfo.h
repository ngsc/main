#ifndef LIVEMATCHPLAYERINFO_H
#define LIVEMATCHPLAYERINFO_H

#include <QObject>
#include <QPoint>

class LiveMatchPlayerInfo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int number READ number WRITE setPlayerNumber NOTIFY playerNumberChanged)
    Q_PROPERTY(QString playerColor READ playerColor WRITE setPlayerColor NOTIFY playerColorChanged)
    Q_PROPERTY(QPoint playerPosition READ playerPosition WRITE setPlayerPosition  NOTIFY playerPositionChanged)
    Q_PROPERTY(int bodyAngle READ bodyAngle WRITE setBodyAngle NOTIFY bodyAngleChanged)
    Q_PROPERTY(int neckAngle READ neckAngle WRITE setNeckAngle NOTIFY neckAngleChanged)

public:
    explicit LiveMatchPlayerInfo(QObject *parent = nullptr);
    int number();
    void setPlayerNumber(int number);
    QString playerColor();
    void setPlayerColor(const QString& a_color);
    QPoint playerPosition();
    void setPlayerPosition(const QPoint& point);
    int bodyAngle();
    void setBodyAngle(int aBodyAngle);
    int neckAngle();
    void setNeckAngle(int aNeckAngle);

signals:
    void playerNumberChanged();
    void playerColorChanged();
    void playerPositionChanged();
    void bodyAngleChanged();
    void neckAngleChanged();

public slots:
private:
    int m_number;
    QString m_player_color;
    QPoint m_player_position;
    int m_body_angle;
    int m_neck_angle;
};

#endif // LIVEMATCHPLAYERINFO_H
