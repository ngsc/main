#include "mainwindow.h"
#include <QSettings>
#include <QTextStream>
#include <QDebug>
#include <QDir>
#include <QApplication>

void switchTranslator(QTranslator& translator, const QString& filename)
{
    qApp->removeTranslator(&translator);
    if(translator.load(filename))
        qApp->installTranslator(&translator);
}

MainWindow::MainWindow(QWidget *parent) : QMainWindow(parent)
{
    loadSettings("GameSetting.ini");
}

MainWindow::~MainWindow()
{
    saveSettings("GameSetting.ini");
}

void MainWindow::loadSettings(const QString& ini_fname)
{
    QString ini_file_path = QDir(QApplication::applicationDirPath()).filePath(ini_fname);
    QSettings settings(ini_file_path, QSettings::IniFormat);

    g_language =  settings.value("Lang/myLang",0).toBool();
    g_skin = settings.value("Skin/mySkin",0).toBool();
    Abuse_Filter = settings.value("Abuse_Filter/Abuse_Filter",0).toInt();
    MusicSwitch = settings.value("MusicSwitch/MusicSwitch",0).toInt();

}

void MainWindow::loadLanguage(const QString &rLanguage)
{
    if(m_currLang != rLanguage) {
        m_currLang = rLanguage;
        QLocale locale = QLocale(m_currLang);
        QLocale::setDefault(locale);
        QString languageName = QLocale::languageToString(locale.language());
        auto langPath = m_langPath + QString("snarky_%1.qm").arg(rLanguage);
        switchTranslator(m_translator, langPath);
    }
}

QString MainWindow::getCurrLang() const
{
    return m_currLang;
}

void MainWindow::setCurrLang(const QString &currLang)
{
    m_currLang = currLang;
}

QString MainWindow::getLangPath() const
{
    return m_langPath;
}

void MainWindow::setLangPath(const QString &langPath)
{
    m_langPath = langPath;
}

void MainWindow::saveSettings(const QString& ini_fname)
{
    QString ini_file_path = QDir(QApplication::applicationDirPath()).filePath(ini_fname);
    QSettings settings(ini_file_path, QSettings::IniFormat);

    settings.clear();
    settings.beginGroup("Lang");
    settings.setValue("myLang", g_language);
    settings.endGroup();

    settings.beginGroup("Skin");
    settings.setValue("mySkin", g_skin);
    settings.endGroup();

    settings.beginGroup("Abuse_Filter");
    settings.setValue("Abuse_Filter", Abuse_Filter);
    settings.endGroup();

    settings.beginGroup("MusicSwitch");
    settings.setValue("MusicSwitch", MusicSwitch);
    settings.endGroup();
}

void MainWindow::getConfig(bool lan, bool skin, int AbuseFilter, int Music){

    g_language = lan;

    g_skin = skin;

    Abuse_Filter = AbuseFilter;

    MusicSwitch = Music;

}

bool MainWindow::setLang(){

    return g_language ;
}

bool MainWindow::setSkin(){

    return g_skin ;
}

int MainWindow::setAbuse_Filter(){

    return Abuse_Filter ;
}

int MainWindow::setMusicSwitch(){

    return MusicSwitch ;
}

