#ifndef TEAMTACTIC_H
#define TEAMTACTIC_H

#include <QObject>
#include "MonitorController.h"

class TeamTactic : public QObject
{
    Q_OBJECT

    Q_PROPERTY( bool selected READ getSelected WRITE setSelected NOTIFY selectedChanged )
    Q_PROPERTY( QString name READ getName WRITE setName NOTIFY nameChanged )
    Q_PROPERTY( int type READ getType WRITE setType NOTIFY typeChanged )
public:
    explicit TeamTactic( QObject *parent = nullptr);

    void setSelected( bool selected );
    bool getSelected();

    void setType(int type);
    int getType();

    void setName( QString name );
    QString getName();

signals:
  void  selectedChanged();
void typeChanged();
  void nameChanged();


public slots:

private:
    bool m_selected;
    int m_tacticType;
    QString m_tacticName;
};

#endif // TEAMTACTIC_H
