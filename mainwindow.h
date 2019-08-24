#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QTranslator>

//#include "user.h"
#include "tournament.h"

class MainWindow : public QMainWindow
{
    Q_OBJECT
public:
    explicit MainWindow(QWidget *parent = nullptr);

    ~MainWindow();
    void StartConnection();
    void loadSettings(const QString& ini_fname);

    // loads a language by the given language shortcur (e.g. de, en)
    void loadLanguage(const QString& rLanguage);


    QString getCurrLang() const;
    void setCurrLang(const QString &currLang);

    QString getLangPath() const;
    void setLangPath(const QString &langPath);

private:

    bool g_language;
    bool g_skin;
    int Abuse_Filter;
    int MusicSwitch;

    QTranslator m_translator;
    QString m_currLang;// = "English"; // contains the currently loaded language
    QString m_langPath; // Path of language files. This is always fixed to /languages.

signals:

public slots:
    bool setLang();
    bool setSkin();
    int setAbuse_Filter();
    int setMusicSwitch();
    void saveSettings(const QString& ini_fname);
    void getConfig(bool lan, bool skin, int AbuseFilter, int Music);

};

#endif // MAINWINDOW_H
