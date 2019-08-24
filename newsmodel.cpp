#include "newsmodel.h"
#include <QDebug>
#include <QtQml>

NewsModel::NewsModel(QObject *parent)
    : QAbstractListModel(parent)
{
    laodChineseFile();
    laodJapaniesFile();
    //    qDebug()<<m_ChineseTranslation.value("value");
}

int NewsModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_news.size();
}

QVariant NewsModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_news.size())
        return QVariant();

    auto news = m_news.at(index.row());

    switch(role)
    {
        case IdRole:
            return QVariant(news->id());
        case BriefRole:
            return QVariant(news->brief());
        case MessageRole:
            return QVariant(news->message());
        case OfferIdRole:
            return QVariant(news->offerId());
        case OwnerClubIdRole:
            return QVariant(news->ownerClubId());
        case BiddingClubIdRole:
            return QVariant(news->biddingClubId());
        case ReadRole:
            return QVariant(news->read());
        case ActiveRole:
            return QVariant(news->active());
        case RoleRole:
            return QVariant::fromValue(news->role());
        case StageRole:
            return QVariant::fromValue(news->stage());
        case DateTimeRole:
            return QVariant(news->dateTime().toString("yyy-MM-dd hh:mm:ss"));
        case InvitationIdRole:
            return QVariant(news->invitationId ());
    }
    return QVariant();
}

bool NewsModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if(!index.isValid())
        return false;

    auto& news = m_news.at(index.row());
    switch(role)
    {
        case ReadRole:
            news->setRead(value.toBool());
            break;
    }

    emit dataChanged(index, index, {role});
    return true;
}

QHash<int, QByteArray> NewsModel::roleNames() const
{
    return {
        {IdRole, "id"},
        {BriefRole, "brief"},
        {MessageRole, "message"},
        {OfferIdRole, "offerId"},
        {OwnerClubIdRole, "ownerClubId"},
        {BiddingClubIdRole, "biddingClubId"},
        {ReadRole, "read"},
        {ActiveRole, "active"},
        {RoleRole, "role"},
        {StageRole, "stage"},
        {DateTimeRole, "dateTime"},
        {InvitationIdRole , "invitationId"}
    };
}

QJSValue NewsModel::get(int idx) const
{
    QJSEngine *engine = qmlEngine(this);
    QJSValue value = engine->newObject();
    if (idx >= 0 && idx < m_news.size()) {
        QHash<int, QByteArray> roles = roleNames();
        QHashIterator<int, QByteArray> it(roles);
        while (it.hasNext()) {
            it.next();
            value.setProperty(QString::fromUtf8(it.value()), data(index(idx, 0), it.key()).toString());
        }
    }
    return value;
}

QList<News *> NewsModel::news() const
{
    return m_news;
}

void NewsModel::setNews(QList<News *> news)
{
    //    qDebug() << "News : " << news.size();
    //    beginResetModel();
    //    clear();
    //    beginInsertRows(QModelIndex(), 0, 0);

    //    for(int i = 0 ; i < news.count () ; i++){
    //        auto n = this->publicNews(news.at (i)->id ());
    //        if(n){
    //            n->checkNewsContent (news.at (i));///////
    //            news.removeAt (i);
    //            i--;
    //        }else{
    //            m_news.append (news.at (i));
    //        }
    //    }

    //    for(int i = 0 ; i < m_news.count () ; i++) {
    //        if(m_news.at (i)->isStillAlive ()){
    //            m_news.at (i)->setParent(this);
    //        }else{
    //            m_news.removeAt (i);
    //            i--;
    //        }
    //    }
    //    qDebug() << "m_News : " << m_news.size();
    //    endInsertRows();
    //    endResetModel();
    //    setCount(m_news.count());

}

void NewsModel::setpublicNews(QList<News *> news)
{

    beginResetModel();
    clear();
    beginInsertRows(QModelIndex(), 0, 0);

    for(int i = 0 ; i < news.count () ; i++){
        auto newsElement = this->publicNews(news.at(i)->id());
        if(newsElement){
            //check read only
            if(newsElement->read()!=news.at(i)->read()){
                newsElement->setRead(news.at(i)->read());
            }
        }else{
            //add+translate
            m_publicnews.append(news.at(i));
            news.at (i)->setNewstypePublic (true);
            news.at (i)->setParent(this);
//                        qDebug()<<news.at (i)->message();

//            news.at(i)->setBrief(translate(m_currentLang, news.at(i)->brief(),NewsType::Public_News));
            news.at(i)->setMessage(translate(m_currentLang, news.at(i)->message(),NewsType::Public_News));
            news.at(i)->setBrief(TranslatePublicBreif( news.at(i)->brief()));
            //            qDebug()<<news.at (i)->message();
            //translate function
        }
    }

    m_news.append (m_publicnews);
    m_news.append (m_Generalnews);

    qSort(m_news.begin(), m_news.end(), variantLessThan);

    endInsertRows();
    endResetModel();

    setCount(m_news.count());
}

void NewsModel::setGeneralNews(QList<News *> news)
{
    //    qDebug() << "re General News : " << news.size();
    beginResetModel();
    clear();
    beginInsertRows(QModelIndex(), 0, 0);

    for(int i = 0 ; i < news.count () ; i++){
        auto newsElement = this->generalNews(news.at(i)->id());
        if(newsElement){
            //check read only
            if(newsElement->read()!=news.at(i)->read()){
                newsElement->setRead(news.at(i)->read());
            }
        }else{
            //add+translate
            m_Generalnews.append(news.at(i));
            news.at (i)->setNewstypePublic (false);
            news.at (i)->setParent(this);

//            qDebug()<<news.at (i)->brief();
//            qDebug()<<news.at (i)->message();
            news.at(i)->setBrief(translate(m_currentLang, news.at(i)->brief(),NewsType::General_News));
            news.at(i)->setMessage(translate(m_currentLang,news.at (i)->message(),NewsType::General_News));
            //            qDebug()<<news.at (i)->message();
            //translate function
        }
    }
    m_news.append (m_publicnews);
    m_news.append (m_Generalnews);

    qSort(m_news.begin(), m_news.end(), variantLessThan);

    endInsertRows();
    endResetModel();

    setCount(m_news.count());
}

bool NewsModel::variantLessThan(const News *v1, const News *v2)
{
    return v1->dateTime() > v2->dateTime();
}

void NewsModel::clear()
{
    if(m_news.isEmpty())
        return;

    beginRemoveRows(QModelIndex(), 0, m_news.count()-1);
    m_news.clear();
    endRemoveRows();
}

void NewsModel::setLanguage(QString language)
{
    m_currentLang = language;
}

News *NewsModel::publicNews(int id)
{
    auto itr = std::find_if(m_publicnews.begin(), m_publicnews.end(), [=](const News* news) {
        return news->id() == id;
    });

    if(itr != m_publicnews.end())
        return *itr;
    return nullptr;
}

News *NewsModel::generalNews(int id){
    auto itr = std::find_if(m_Generalnews.begin(), m_Generalnews.end(), [=](const News* news) {
        return news->id() == id;
    });

    if(itr != m_Generalnews.end())
        return *itr;
    return nullptr;
}

News *NewsModel::at(int index)
{
    if(index <0 || index > m_news.size())
        return nullptr;
    return m_news.at(index);
}

bool NewsModel::containsUnread()
{
    auto itr = std::find_if(m_news.begin(), m_news.end(), [=](const News* news) {
        return news->read() == false;
    });
    return (itr != m_news.end());
}

QString NewsModel::translate(QString Language, QString Message,bool NewsType)
{
    if(Language == "Chinese_Simplified"){
        return GetChineseTranslation(Message,NewsType);
    }else if(Language == "Japanies") {
        return GetJapaniesTranslation(Message,NewsType);
    }else {
        return Message;
    }
}

QString NewsModel::GetJapaniesTranslation(QString Message, bool newsType)
{
    QString translatedMessage;

    switch (newsType) {
        case NewsType::Public_News: {
                GetUserNameForPublicNews(Message);
                Message.replace(m_userNameInMessage,'%'+QString::number(1));
                if(m_JapaniesTranslation.contains(Message)){
                    translatedMessage = m_JapaniesTranslation.value(Message);
                }
                translatedMessage.replace('%'+QString::number(1),m_userNameInMessage);
                break;
            }
        case NewsType::General_News: {
                GeLinksInMessage(Message);
                translatedMessage = Replacelinks(Message);
                if(m_JapaniesTranslation.contains(translatedMessage)){
                    translatedMessage = m_JapaniesTranslation.value(translatedMessage);
                }
                translatedMessage = setlinksInMessage(translatedMessage);
                break;
            }
    }

    //    QStringList splitLine = Message.split(' ');
    //    QString sentence;

    //    GeLinksInMessage(Message);

    //    for(int i = 0 ; i < splitLine.count() ; i++){
    //        if(checkMessageIfStartLink(splitLine.at(i))){
    //            translatedMessage.append(splitLine.at(i)+' ');
    //            for(int j = i + 1 ; j < splitLine.count() ; j++ ){
    //                if(!checkMessageIfEndLink(splitLine.at(j))){
    //                    translatedMessage.append(splitLine.at(j)+' ');
    //                }else{
    //                    translatedMessage.append(splitLine.at(j)+' ');
    //                    i = j;
    //                    j = splitLine.count();
    //                }
    //            }
    //        }else {
    //            if(m_JapaniesTranslation.contains(splitLine.at(i))){
    //                translatedMessage.append(m_JapaniesTranslation.value(splitLine.at(i))+' ');
    //            }else{
    //                sentence = splitLine.at(i);
    //                for(int j = i + 1 ; j < splitLine.count() ; j++ ){
    //                    sentence.append(' '+splitLine.at(j));
    //                    if(m_JapaniesTranslation.contains(sentence)){
    //                        translatedMessage.append(m_JapaniesTranslation.value(sentence));
    //                        i = j;
    //                        j = splitLine.count();
    //                    }
    //                }
    //            }
    //        }
    //    }
    return translatedMessage;
}

QString NewsModel::GetChineseTranslation(QString Message,bool newsType)
{
    QString translatedMessage;

    switch (newsType) {
        case NewsType::Public_News: {
                GetUserNameForPublicNews(Message);
//                qDebug()<<m_userNameInMessage;
                if(m_userNameInMessage!=""){
                    Message.replace(m_userNameInMessage,'%'+QString::number(1));
                }else{
                    m_userNameInMessage = "User Name";
                    Message.replace(", ,",", %1,");//'%'+QString::number(1));
                }

                GetClubNameForPublicNews(Message);
                if(m_clubNameInMessage!=""){
                    Message.replace(m_clubNameInMessage,'%'+QString::number(2));
                }

//                qDebug()<<m_userNameInMessage;
                qDebug()<<Message;

                translatedMessage = Message;
                if(m_ChineseTranslation.contains(Message)){
                    translatedMessage = m_ChineseTranslation.value(Message);
                }
                 qDebug()<<translatedMessage;
                translatedMessage.replace('%'+QString::number(1),m_userNameInMessage);
                translatedMessage.replace('%'+QString::number(2),m_clubNameInMessage);
                 qDebug()<<translatedMessage;
                break;
            }
        case NewsType::General_News: {
                GeLinksInMessage(Message);
                translatedMessage = Replacelinks(Message);
//                qDebug()<<translatedMessage;
                if(m_ChineseTranslation.contains(translatedMessage)){
                    translatedMessage = m_ChineseTranslation.value(translatedMessage);
                }
                translatedMessage = setlinksInMessage(translatedMessage);
                break;
            }
    }


    //    for(int i = 0 ; i < splitLine.count() ; i++){
    //        if(checkMessageIfStartLink(splitLine.at(i))){
    //            translatedMessage.append(splitLine.at(i)+' ');
    //            for(int j = i + 1 ; j < splitLine.count() ; j++ ){
    //                if(!checkMessageIfEndLink(splitLine.at(j))){
    //                    translatedMessage.append(splitLine.at(j)+' ');
    //                }else{
    //                    translatedMessage.append(splitLine.at(j)+' ');
    //                    i = j;
    //                    j = splitLine.count();
    //                }
    //            }
    //        }else {
    //            if(m_ChineseTranslation.contains(splitLine.at(i))){
    //                translatedMessage.append(m_ChineseTranslation.value(splitLine.at(i))+' ');
    //            }else{
    //                sentence = splitLine.at(i);
    //                for(int j = i + 1 ; j < splitLine.count() ; j++ ){
    //                    sentence.append(' '+splitLine.at(j));
    //                    if(m_ChineseTranslation.contains(sentence)){
    //                        translatedMessage.append(m_ChineseTranslation.value(sentence));
    //                        i = j;
    //                        j = splitLine.count();
    //                    }
    //                }
    //            }
    //        }
    //    }
    return translatedMessage;
}

bool NewsModel::checkMessageIfStartLink(QString Message)
{
    if((Message.at(0)=='<')&&(Message.at(1)=='a')){
        return true;
    }else{
        return false;
    }
}

bool NewsModel::checkMessageIfEndLink(QString Message)
{
    if(((Message.at(Message.count()-2)=='a')&&(Message.at(Message.count()-1)=='>'))||
            ((Message.at(Message.count()-4)=='a')&&(Message.at(Message.count()-3)=='>')&&
             (Message.at(Message.count()-2)=='\'')&&(Message.at(Message.count()-1)=='s'))){
        return true;
    }else{
        return false;
    }
}

void NewsModel::laodChineseFile()
{
    QFile file(QString("./languages/ChineseTranslation.txt"));

    if (file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        QByteArray encodedString =file.readAll();
        QTextCodec *codec = QTextCodec::codecForName("GB2312");
        QString string = codec->toUnicode(encodedString);
//        qDebug()<<string;
        QTextStream in(&string);

        while (!in.atEnd())
        {
            QString line = in.readLine();
            QStringList splitLine = line.split(":");

            m_ChineseTranslation.insert(splitLine.at(0),splitLine.at(1));
        }

        file.close();
        file.flush();
    }
}

void NewsModel::laodJapaniesFile()
{
    QFile file(QString(":/languages/JapaniesTranslation.txt"));


    if (file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        QByteArray encodedString =file.readAll();
        QTextCodec *codec = QTextCodec::codecForName("Shift-JIS");
        QString string = codec->toUnicode(encodedString);
//        qDebug()<<string;

        QTextStream in(&string);

        while (!in.atEnd())
        {
            QString line = in.readLine();
            QStringList splitLine = line.split(":");

            m_JapaniesTranslation.insert(splitLine.at(0),splitLine.at(1));
        }

        file.close();
        file.flush();
    }
}

void NewsModel::GeLinksInMessage(QString Message)
{
//    qDebug()<<Message;
    QStringList splitLine = Message.split(' ');
    m_Links.clear();
    for(int i = 0 ; i < splitLine.count() ; i++){
        if(splitLine.at(i).at(0) == '$'){
            m_Links.append(splitLine.at(i));
        }
        if(checkMessageIfStartLink(splitLine.at(i))){
            m_Links.append(splitLine.at(i));
            qDebug()<<splitLine.at(i);
            for(int j = i + 1 ; j < splitLine.count() ; j++ ){
                m_Links.replace(m_Links.count()-1,m_Links.at(m_Links.count()-1)+' '+splitLine.at(j));
                if(checkMessageIfEndLink(splitLine.at(j))){
                    qDebug()<<splitLine.at(j);
                    i = j;
                    j = splitLine.count();
                }
            }
        }
    }
}

QString NewsModel::Replacelinks(QString Message)
{
    QStringList splitLine = Message.split(' ');

    for(int i = 0 ; i < m_Links.count() ; i++){
        Message.replace(m_Links.at(i),'%'+QString::number(i+1));
    }

    if(Message == (splitLine.at(0) + " invites %1 as a friendly opponent")){
        m_Links.append(splitLine.at(0));
        Message = "%2 invites %1 as a friendly opponent";
    }

//    qDebug()<<Message <<" : message ";
    return Message;
}

QString NewsModel::setlinksInMessage(QString Message)
{
    for(int i = 0 ; i < m_Links.count() ; i++){
        Message.replace('%'+QString::number(i+1),QString(m_Links.at(i)));
    }
    return Message;
}

void NewsModel::GetClubNameForPublicNews(QString Message)
{
    QStringList splitLine = Message.split(' ');
    bool start = false;
    m_clubNameInMessage.clear();
    QString LeftClub;
    QString RightClub;
    if(splitLine.at(0)=="From"){
        LeftClub = "from";RightClub="and";
    }else if(splitLine.at(0)=="To"){
        LeftClub = "of";RightClub="from";
    }

    for(int i = 0 ; i < splitLine.count() ; i++){
        if(splitLine.at(i) == RightClub){
            start = false;
        }
        if(start){
            m_clubNameInMessage.append(splitLine.at(i)+" ");
        }
//        qDebug()<<m_clubNameInMessage << " : " << splitLine.at(i);

        if(splitLine.at(i) == LeftClub){
            start = true;
        }
    }
    if(m_clubNameInMessage!="")
        m_clubNameInMessage.chop (1);

    if(m_clubNameInMessage == ""){
        m_clubNameInMessage = m_userNameInMessage+"'s club";
    }

}

QString NewsModel::TranslatePublicBreif(QString Breif)
{
    QString translatedMessage;
    if(m_currentLang == "Chinese_Simplified"){
        if(m_userNameInMessage!="User Name"){
            Breif.replace(m_userNameInMessage,'%'+QString::number(1));
        }else{
//            QStringList splitLine = Breif.split(' ');
//            if(splitLine.at(0)==" "){
                Breif = "%1"+Breif;
//            }
//            m_userNameInMessage = "User Name";
//            Breif.replace(", ,",", %1,");//'%'+QString::number(1));
        }
//        qDebug()<<Breif;
        GetClubNameForPublicNews(Breif);
        if(m_clubNameInMessage!=""){
            Breif.replace(m_clubNameInMessage,'%'+QString::number(2));
        }
//        qDebug()<<Breif;
        translatedMessage = Breif;
        if(m_ChineseTranslation.contains(Breif)){
            translatedMessage = m_ChineseTranslation.value(Breif);
        }
        translatedMessage.replace('%'+QString::number(1),m_userNameInMessage);
        translatedMessage.replace('%'+QString::number(2),m_clubNameInMessage);
        return translatedMessage;
    }else if(m_currentLang == "Japanies") {
//        return GetJapaniesTranslation(Breif);
    }else {
        return Breif;
    }
}

void NewsModel::GetUserNameForPublicNews(QString Message)
{
    QStringList splitLine = Message.split(',');
    m_userNameInMessage = splitLine.at(1);
    if(m_userNameInMessage.at(0) == " "){
        m_userNameInMessage.remove(0,1);
    }
//    qDebug()<<m_userNameInMessage<<" user name";
}

int NewsModel::count() const
{
    return m_count;
}

void NewsModel::setCount(int count)
{
    m_count = count;
    emit countChanged(count);
}

bool NewsModel::checkMessageWord(QString mesg)
{
    if(mesg.at (mesg.count ()-1)== 'C'){
        return true;
    }else if(mesg.at (mesg.count ()-1) == 'P')
    {
        return false;
    }
}

QString NewsModel::getLinkID(QString mesg)
{
    mesg.chop (1);
    return mesg;
}


