#include "playercomment.h"

PlayerComment::PlayerComment(QObject *parent)
{

}

void PlayerComment::setId(int id)
{
    m_id = id;
}

int PlayerComment::id() const
{
    return m_id;
}

void PlayerComment::setPlayerId(int playerid)
{
    m_playerId = playerid;
}

int PlayerComment::playerId() const
{
    return m_playerId;
}

void PlayerComment::setmessageRate(int messageRate)
{
    m_messageRate = messageRate;
}

int PlayerComment::messageRate() const
{
    return m_messageRate;
}

void PlayerComment::setMessage(const QString &message)
{
    std::string current_locale_text = message.toLocal8Bit().constData();
    std::string result = splitInLines(current_locale_text, 30);
    m_message = QString::fromStdString(result);
}

QString PlayerComment::message() const
{
    return m_message;
}

QDateTime PlayerComment::dateTime() const
{
    return m_dateTime;
}

void PlayerComment::setDateTime(const QDateTime &dateTime)
{
    m_dateTime = dateTime;
}

std::string PlayerComment::splitInLines(std::string source, std::size_t width)
{
    std::string whitespace = " \t\r";
    std::size_t  currIndex = width - 1;
    std::size_t  sizeToElim;
    while ( currIndex < source.length() )
    {
        currIndex = source.find_last_of(whitespace,currIndex + 1);
        if (currIndex == std::string::npos)
            break;
        currIndex = source.find_last_not_of(whitespace,currIndex);
        if (currIndex == std::string::npos)
            break;
        sizeToElim = source.find_first_not_of(whitespace,currIndex + 1) - currIndex - 1;
        source.replace( currIndex + 1, sizeToElim , "\n");
        currIndex += (width + 1); //due to the recently inserted "\n"
    }
    return source;
}
