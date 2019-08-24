#include "mainwindow.h"
#include <QSettings>
//#include <QTextStream>
#include <QDebug>
#include <QDir>
#include <QApplication>

MainWindow::MainWindow(QWidget *parent) : QMainWindow(parent)
{
    m_ini_fname = "GameSetting.ini";
    readSettings();
}

MainWindow::~MainWindow()
{
    writeSettings();
}

void MainWindow::readSettings()
{
    getLangFiles();
    QString ini_file_path = QDir(QApplication::applicationDirPath()).filePath(m_ini_fname);
    QSettings settings(ini_file_path, QSettings::IniFormat);

    m_currLang =  settings.value("Lang/myLang","English").toString();
    loadLanguage(m_currLang);
    g_skin = settings.value("Skin/mySkin",0).toBool();
    Abuse_Filter = settings.value("Abuse_Filter/Abuse_Filter",0).toBool();
    MusicSwitch = settings.value("MusicSwitch/MusicSwitch",0).toBool();
}

void MainWindow::getLangFiles()
{
    m_langPath.append("./languages");
    QDir dir(m_langPath);
    QStringList fileNames = dir.entryList(QStringList("snarky_*.qm"));
    for (int i = 0; i < fileNames.size(); ++i) {
        QString locale;
        locale = fileNames[i];
        locale.truncate(locale.lastIndexOf('.'));
        locale.remove(0, locale.indexOf('_') + 1);
        //        QString lang = QLocale::languageToString(QLocale(locale).language());
        m_LangList.append(locale);//fileNames.at(i).fileName());
    }
}

void MainWindow::loadLanguage(const QString &rLanguage)
{
    QString langPath =  QString("./languages/snarky_%1.qm").arg(rLanguage);//m_langPath +
    if(m_translator.load(langPath))
        qApp->installTranslator(&m_translator);
}

void MainWindow::writeSettings()
{
    QString ini_file_path = QDir(QApplication::applicationDirPath()).filePath(m_ini_fname);
    QSettings settings(ini_file_path, QSettings::IniFormat);

    settings.clear();
    settings.beginGroup("Lang");
    settings.setValue("myLang", m_currLang);
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

QString MainWindow::getCurrLang() const
{
    return m_currLang;
}

void MainWindow::setCurrLang(const QString &currLang)
{
    m_currLang = currLang;
}

QStringList MainWindow::getLangList() const
{
    return m_LangList;
}

void MainWindow::setConfig(QString lan, bool skin, bool AbuseFilter, bool Music){

    m_currLang = lan;

    loadLanguage(m_currLang);

    g_skin = skin;

    Abuse_Filter = AbuseFilter;

    MusicSwitch = Music;

    writeSettings();
}

bool MainWindow::getSkin(){

    return g_skin ;
}

bool MainWindow::getAbuse_Filter(){

    return Abuse_Filter ;
}

bool MainWindow::getMusicSwitch(){

    return MusicSwitch ;
}
