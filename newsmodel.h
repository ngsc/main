#ifndef NEWSMODEL_H
#define NEWSMODEL_H

#include <QAbstractListModel>
#include <QJSValue>
#include "news.h"

class NewsModel : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(int count READ count NOTIFY countChanged)

    enum {
        IdRole = Qt::UserRole + 1,
        BriefRole,
        MessageRole,
        OfferIdRole,
        BiddingClubIdRole,
        OwnerClubIdRole,
        ReadRole,
        ActiveRole,
        RoleRole,
        StageRole,
        DateTimeRole,
        InvitationIdRole
    };

    enum NewsType{
      General_News,
        Public_News
    };


public:
    explicit NewsModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex& index, const QVariant& value, int role = Qt::EditRole) override;

    virtual QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE QJSValue get(int idx) const;

    int count() const;
    void setCount(int count);

    Q_INVOKABLE bool checkMessageWord(QString mesg);
    Q_INVOKABLE QString getLinkID(QString mesg);

public slots:
    QList<News *> news() const;
    void setNews(QList<News *> news);
    void setpublicNews(QList<News *> news);
    void setGeneralNews(QList<News *> news);
    void clear();
    void setLanguage(QString language);

    News *publicNews(int id);
    News *generalNews(int id);
    News *at(int index);

    bool containsUnread();

signals:
    void countChanged(int count);
private:

    static bool variantLessThan(const News *v1, const News *v2);
    QString translate(QString Language , QString Message, bool NewsType);
    QString GetJapaniesTranslation(QString Message,bool newsType);
    QString GetChineseTranslation(QString Message, bool newsType);
    bool checkMessageIfStartLink(QString Message);
    bool checkMessageIfEndLink(QString Message);
    void laodChineseFile();
    void laodJapaniesFile();
    void GeLinksInMessage(QString Message);
    QString Replacelinks(QString Message);
    QString setlinksInMessage(QString Message);
    void GetUserNameForPublicNews(QString Message);
    void GetClubNameForPublicNews(QString Message);
    QString TranslatePublicBreif(QString Breif);

    QString m_currentLang;
    QList <QString> m_Links;
    QString m_userNameInMessage;
    QString m_clubNameInMessage;
    QHash<QString, QString> m_JapaniesTranslation;
    QHash<QString, QString> m_ChineseTranslation;

    QList<News *> m_news;
    QList<News *> m_publicnews;
    QList<News *> m_Generalnews;

    int m_count;

};

#endif // NEWSMODEL_H
