#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QTranslator>
#include "tournament.h"

class MainWindow : public QMainWindow
{
    Q_OBJECT
public:
    explicit MainWindow(QWidget *parent = nullptr);

    ~MainWindow();

protected:

    void readSettings();
    void getLangFiles();
    void loadLanguage(const QString& rLanguage);
    void writeSettings();

signals:

public slots:

    bool getSkin();
    bool getAbuse_Filter();
    bool getMusicSwitch();
    void setConfig(QString lan, bool skin, bool AbuseFilter, bool Music);

    QString getCurrLang() const;
    void setCurrLang(const QString &currLang);

    QStringList getLangList()const;

private:

    bool g_language;
    bool g_skin;
    bool Abuse_Filter;
    bool MusicSwitch;

    QString m_currLang;
    QString m_langPath;
    QString m_ini_fname;
    QStringList m_LangList;
    QTranslator m_translator;
    QTranslator m_translatorQt; // contains the translations for qt

};

#endif // MAINWINDOW_H
