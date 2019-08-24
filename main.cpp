#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <mainwindow.h>
#include <QApplication>
#include <QQmlContext>
#include <QLoggingCategory>

#include "apiconnection.h"
#include "playermodel.h"
#include "clubmodel.h"
#include "searchingpoolmodel.h"
#include "sortfilterproxymodel.h"
#include "currencyformatter.h"
#include "user.h"
#include "notificationmodel.h"
#include "matchmodel.h"
#include "simpleusermodel.h"
#include "invitationmodel.h"
#include "newsmodel.h"
#include "MonitorController.h"
#include "FieldController.h"
#include "PlayerController.h"

static QObject* createApiConnection(QQmlEngine*, QJSEngine*) {
    return new APIConnection();
}

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication::setAttribute(Qt::AA_UseOpenGLES);
    QApplication a(argc, argv);

    MainWindow* myGlobal = new MainWindow();

    CurrencyFormatter cf;

    QLoggingCategory::setFilterRules(QStringLiteral("qt.qml.binding.removal.info=true"));

    qmlRegisterSingletonType<APIConnection>("com.Game.APIConnection", 1, 0, "APIConnection", createApiConnection);
    qmlRegisterType<Player>("com.Game.Player", 1, 0, "Player");
    qmlRegisterType<PlayerModel>("com.Game.Player", 1, 0, "PlayerModel");

    qmlRegisterType<MonitorControl>("com.Game.Player", 1, 0, "MonitorControl");
    qmlRegisterType<PlayerControl>("com.Game.Player", 1, 0, "PlayerControl");
    qmlRegisterType<FieldControl>("com.Game.Player", 1, 0, "FieldControl");

    qmlRegisterType<Club>("com.Game.Club", 1, 0, "Club");
    qmlRegisterType<ClubModel>("com.Game.Club", 1, 0, "ClubModel");
    qmlRegisterType<SearchingPoolModel>("com.Game.SearchingPool", 1, 0, "SearchingPoolModel");
    qmlRegisterType<SearchingPoolPlayer>("com.Game.SearchingPool", 1, 0, "SearchingPoolPlayer");
    qmlRegisterType<SortFilterProxyModel>("com.Game.SortFilterProxyModel", 1, 0, "SortFilterProxyModel");
    qmlRegisterType<Notification>("com.Game.Notification", 1, 0, "Notification");
    qmlRegisterType<NotificationModel>("com.Game.Notification", 1, 0, "NotificationModel");
    qmlRegisterType<User>("com.Game.User", 1, 0, "User");
    qmlRegisterType<Match>("com.Game.Match", 1, 0, "Match");
    qmlRegisterType<MatchModel>("com.Game.Match", 1, 0, "MatchModel");
    qmlRegisterType<SimpleUser>("com.Game.SimpleUser", 1, 0, "SimpleUser");
    qmlRegisterType<SimpleUserModel>("com.Game.SimpleUser", 1, 0, "SimpleUserModel");
    qmlRegisterType<Invitation>("com.Game.Invitation", 1, 0, "Invitation");
    qmlRegisterType<InvitationModel>("com.Game.Invitation", 1, 0, "InvitationModel");
    qmlRegisterType<News>("com.Game.News", 1, 0, "News");
    qmlRegisterType<NewsModel>("com.Game.News", 1, 0, "NewsModel");

    QQmlApplicationEngine engine;
    engine.clearComponentCache();
    engine.rootContext()->setContextProperty("applicationPath", qApp->applicationDirPath()+ "/");
    engine.rootContext()->setContextProperty("currencyFormatter", &cf);
    engine.rootContext()->setContextProperty("myGlobalObject", myGlobal);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return a.exec();
}
