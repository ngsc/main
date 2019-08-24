#include "announcementmodel.h"
#include <QtQml>

AnnouncementModel::AnnouncementModel(QObject *parent)
    : QAbstractListModel(parent)
{

}

int AnnouncementModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_Announcement.size ();
}

QVariant AnnouncementModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_Announcement.size())
        return QVariant();

    auto& announcement = m_Announcement.at(index.row());

    switch (role)
    {
    case IdRole:
        return QVariant(announcement->id ());
    case FontStyleRole:
        return QVariant(announcement->fontStyle ());
    case FontSizeRole:
        return QVariant(announcement->fontSize ());
    case FontBackGroundRole:
        return QVariant(announcement->fontBackGround ());
    case FontDifferenceRole:
        return QVariant(announcement->fontDifference ());
    case FontColorRole :
        return QVariant(announcement->fontColor ());
    case MessageTypeRole:
        return QVariant(announcement->messageType ());
    case MessageRole:
        return QVariant(announcement->message ());
    }
    return QVariant();
}

bool AnnouncementModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if(index.isValid() || index.row() < 0 || index.row() >= m_Announcement.size())
        return false;

    auto& announcement = m_Announcement.at(index.row());
    switch(role)
    {
    case FontStyleRole:
        announcement->setFontStyle (value.toString().toInt ());
        break;
    case FontSizeRole:
        announcement->setFontSize (value.toString().toInt ());
        break;
    case FontBackGroundRole:
        announcement->setFontbackGround (value.toString());
        break;
    case FontDifferenceRole:
        announcement->setFontDifference (value.toString());
        break;
    case FontColorRole:
        announcement->setFontColor (value.toString());
        break;
    case MessageTypeRole:
        announcement->setMessageType (value.toString());
        break;
    case MessageRole:
        announcement->setMessage (value.toString());
        break;
    }

    emit dataChanged(index, index, { role } );
    return true;
}

QHash<int, QByteArray> AnnouncementModel::roleNames() const
{
    return {
        {IdRole, "id"},
        {FontStyleRole, "fontStyle"},
        {FontSizeRole, "fontSize"},
        {FontBackGroundRole, "fontBackground"},
        {FontDifferenceRole, "fontDifference"},
        {FontColorRole,"fontColor"},
        {MessageTypeRole, "messageType"},
        {MessageRole, "message"}
    };
}

int AnnouncementModel::count() const
{
    return m_count;
}

void AnnouncementModel::setCount(int count)
{
    m_count = count;
//    emit countChanged(count);
}

QList<Announcement *> AnnouncementModel::announcement() const
{
    return m_Announcement;
}

void AnnouncementModel::setAnnouncement( QList<Announcement *> announcement)
{
    qDebug() << "Announcement: " << announcement.size();
    beginResetModel();
    clear();
    beginInsertRows(QModelIndex(), 0, 0);

    for(int i = 0 ; i < announcement.count () ; i++){
        auto n = this->announcement (announcement.at (i)->id ());
        if(n){
            n->checkAnnouncementContent (announcement.at (i));
            announcement.removeAt (i);
            i--;
        }else{
            announcement.at (i)->setAnnouncementNew (true);
            m_Announcement.append (announcement.at (i));
        }
    }

    for(int i = 0 ; i < m_Announcement.count () ; i++) {
        if(m_Announcement.at (i)->isChanged ()||m_Announcement.at (i)->isNewAnnouncement ()){
            m_Announcement.at (i)->setParent(this);
            m_Announcement.at (i)->setAnnouncementNew (false);
        }else{
            m_Announcement.removeAt (i);
            i--;
        }

//        qDebug()<<"-----------------------";
//        qDebug()<<"id : "<<m_Announcement.at (i)->id ();
//        qDebug()<<"messageType : "<<m_Announcement.at (i)->messageType ();
//        qDebug()<<"message : "<<m_Announcement.at (i)->message ();
//        qDebug()<<"font Style : "<<m_Announcement.at (i)->fontStyle ();
//        qDebug()<<"font Color: "<<m_Announcement.at (i)->fontColor ();
//        qDebug()<<"font Size: "<<m_Announcement.at (i)->fontSize ();
//        qDebug()<<"font Difference: "<<m_Announcement.at (i)->fontDifference ();
//        qDebug()<<"font BackGround: "<<m_Announcement.at (i)->fontBackGround ();


    }
    qDebug()<<m_Announcement.count ()<<" : ann count";
    endInsertRows();
    endResetModel();
    setCount(m_Announcement.count());
}

void AnnouncementModel::clear()
{
    if(m_Announcement.isEmpty())
        return;

    beginRemoveRows(QModelIndex(), 0, m_Announcement.count()-1);
    m_Announcement.clear();
    endRemoveRows();
}

Announcement *AnnouncementModel::announcement(int id)
{
    auto itr = std::find_if(m_Announcement.begin(), m_Announcement.end(), [=](const Announcement* announcement) {
        return announcement->id() == id;
    });

    if(itr != m_Announcement.end())
        return *itr;
    return nullptr;
}

Announcement *AnnouncementModel::at(int index)
{
    if(index <0 || index > m_Announcement.size())
        return nullptr;
    return m_Announcement.at(index);
}
