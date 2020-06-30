// -*-c++-*-

/*!
  \file monitor_client.cpp
  \brief Monitor Client class Source File.
*/

/*
 *Copyright:

 Copyright (C) The RoboCup Soccer Server Maintenance Group.
 Hidehisa AKIYAMA

 This code is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; either version 3, or (at your option)
 any later version.

 This code is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this code; see the file COPYING.  If not, write to
 the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.

 *EndCopyright:
 */

/////////////////////////////////////////////////////////////////////

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <QtNetwork>

#include "monitor_client.h"

#include "disp_holder.h"
#include "options.h"
#include "Constants.h"

#include <sstream>
#include <iostream>
#include <cassert>


namespace {
const int POLL_INTERVAL_MS = 1000;
}

/*-------------------------------------------------------------------*/
/*!

*/
MonitorClient::MonitorClient( QObject * parent,
                              DispHolder & disp_holder,
                              const char * hostname,
                              const int port,
                              const int version )

    : QObject( parent )
    , M_disp_holder( disp_holder )
    , M_server_port( static_cast< quint16 >( port ) )
    , M_socket( new QTcpSocket( this ) )
    , M_timer( new QTimer( this ) )
    , M_version( version )
    , M_waited_msec( 0 )
    , M_recomposedPackage()
{
    assert( parent );
    connect(
        M_socket, &QAbstractSocket::hostFound,
        []() { std::cerr << "M_socket::hostFound" << std::endl;}
    );
    connect(
        M_socket, &QAbstractSocket::stateChanged,
        [this](QAbstractSocket::SocketState a_state)
            {
                std::cerr << "M_socket::stateChanged " << a_state << std::endl;
            }
    );
    connect(
        M_socket, &QAbstractSocket::connected,
        [this]()
        {
            std::cerr << "M_socket::connected" << std::endl;
            M_server_port = M_socket->peerPort();
            M_tcp_connection = connect( M_socket, SIGNAL( readyRead() ),
                     this, SLOT( handleTcpRecevied() ) );
            sendDispInit();
        }
    );
    connect(
        M_socket, &QAbstractSocket::disconnected,
        [this]()
        {
            std::cerr << "M_socket::disconnected" << std::endl;
            QObject::disconnect(M_tcp_connection);
            //M_socket->close();
        }
    );
    // check protocl versin range
    if ( version < 1 )
    {
        M_version = 1;
    }

    if ( 4 < version )
    {
        M_version = 4;
    }
    M_socket->connectToHost( ClientConstants::serverHost, M_server_port );
    if( M_socket->waitForConnected(300) )
    {
        qInfo() << "TCP socket conneted";
    }
    else
    {
        qInfo() << "Did not connect in 300ms second";
    }
    std::cerr << "MonitorClient serverPort " << M_server_port << std::endl;

    connect( M_timer, SIGNAL( timeout() ),
             this, SLOT( handleTimer() ) );
    //QCoreApplication::sendPostedEvents();

}

void MonitorClient::error(QAbstractSocket::SocketError aError)
{
    std::cerr << "aError" << aError << std::endl;
}

void MonitorClient::initSocket() {
//    WSADATA wsa;

//    //Initialise winsock
//    printf("\nInitialising Winsock...");
//    if (WSAStartup(MAKEWORD(2,2),&wsa) != 0)
//    {
//        qDebug() << "Error: Could not init socket!!!!!!!!!!!!!!!!!!!!!";
//        exit(EXIT_FAILURE);
//    }
//    printf("Initialised.\n");

//    //Create a socket
//    if((m_sock = socket(AF_INET , SOCK_DGRAM , IPPROTO_UDP )) == INVALID_SOCKET)
//    {
//        qDebug() << "Error: Could not create socket!!!!!!!!!!!!!!!!!!";
//    }
}

void MonitorClient::startSocket() {
//    struct sockaddr_in si_other;

//    //Prepare the sockaddr_in structure
//    si_other.sin_family = AF_INET;
//    si_other.sin_addr.s_addr = inet_addr(ClientConstants::serverHost.toUtf8().constData());;
//    si_other.sin_port = htons( 6000 );
//    int slen = sizeof(si_other);

//    const char* message =  "(dispinit version 4)";
//    //send the message
//
//    if (sendto(m_sock, message, strlen(message) , 0 , (struct sockaddr *)&si_other, slen) == SOCKET_ERROR)
//    {
//        qDebug() << "Error: Can not send message!!!!!!!!!!!!!!!!!!!!!!!";
//        exit(EXIT_FAILURE);
//    }
//    char buf[512];
//    //receive a reply and print it
//    //clear the buffer by filling null, it might have previously received data
//    memset(buf,'&#92;&#48;', 512);
//
//    //try to receive some data, this is a blocking call
//    if (recvfrom(m_sock, buf, 512, 0, (struct sockaddr *)&si_other, &slen) == SOCKET_ERROR)
//    {
//        qDebug()<<QString::number(WSAGetLastError());
//        qDebug() << "Error: Can not get message from server!!!!!!!!!!!!!!!!!!!!!!!!";
//        exit(EXIT_FAILURE);
//    }
//    qDebug() << buf;
//
}

/*-------------------------------------------------------------------*/
/*!

*/
MonitorClient::~MonitorClient()
{
    disconnect();

    //std::cerr << "delete MonitorClient" << std::endl;
}

/*-------------------------------------------------------------------*/
/*!

*/
void
MonitorClient::disconnect()
{
    if ( M_timer )
    {
        M_timer->stop();
    }

    if ( isConnected() )
    {
        std::cerr << "MonitorClient::disconnectMonitor when connected ..." << std::endl;
        sendDispBye();
        M_socket->close();
    }
}

/*-------------------------------------------------------------------*/
/*!

*/
bool
MonitorClient::isConnected() const
{
    //std::cerr << "MonitorClient::isConnected() " << M_socket->state() << (M_socket->socketDescriptor() != -1) << std::endl;
    return ( M_socket->socketDescriptor() != -1 );
}


std::string getCurrentTimestamp()
{
    using std::chrono::system_clock;
    auto currentTime = std::chrono::system_clock::now();

    auto transformed = currentTime.time_since_epoch().count() / 1000000;

    auto millis = transformed % 1000;

    std::time_t tt;
    tt = system_clock::to_time_t ( currentTime );
    auto timeinfo = gmtime (&tt);
    char buf[40];
    sprintf(buf, "%02ld:%02ld:%02ld.%03ld",
    timeinfo->tm_hour, timeinfo->tm_min, timeinfo->tm_sec, millis);
    return buf;
}

void
/*-------------------------------------------------------------------*/
/*!

*/
MonitorClient::handleTcpRecevied()
{

    std::cerr << "[" << getCurrentTimestamp() << "]" << "MonitorClient::::handleTcpRecevied begin" << std::endl;
    std::cerr << "MonitorClient::::handleTcpRecevied bytes available " <<  M_socket->bytesAvailable() << std::endl;
    if( M_socket->peerPort() != M_server_port )
    {
        M_server_port = M_socket->peerPort();
    }
    QByteArray dataFragment = M_socket->readAll();
    char endChar = '\0';
    int index = 0;
    while( dataFragment.indexOf(endChar) != -1 )
    {
        index = dataFragment.indexOf(endChar);
        M_recomposedPackage += dataFragment.left(index+1); // including endChar
        dataFragment = dataFragment.right( dataFragment.size() - (index + 1) );
        std::cerr << "MonitorClient::::handleTcpRecevied endChar detected at " << index << " M_recomposedPackage " << M_recomposedPackage.length() << std::endl;
        bool ok(false);
        switch(M_version)
        {
            case 1:
                //TODO: convert to dispinfo format
                //ok = M_disp_holder.addDispInfoV1( M_recomposedPackage.data() );
                break;
            case 2:
                //ok = M_disp_holder.addDispInfoV2( M_recomposedPackage.data() );
                break;
            case 3:
            default:
                ok = M_disp_holder.addDispInfoV3( M_recomposedPackage );
        }
        if(ok)
        {
            emit received();
        }
        else
        {
            std::cerr << " Error when proccessing message: " << M_recomposedPackage.data() << std::endl;
        }
        M_recomposedPackage = QByteArray();


    }
    if(dataFragment.length() > 0)
    {
        //dataFragment has not endChar, dataFragment is the beginning of unfinished message
        M_recomposedPackage = dataFragment;
    }
    std::cerr << "MonitorClient::::handleTcpRecevied end" << std::endl;
}

/*-------------------------------------------------------------------*/
/*!

*/
void
MonitorClient::handleTimer()
{
    M_waited_msec += POLL_INTERVAL_MS;

     if (M_waited_msec % 5000 == 0)
     {
        std::cerr << "handleTimer waited = " << M_waited_msec << std::endl;
     }
    //sendDispInit();

    if ( Options::instance().bufferingMode() )
    {
        //std::cerr << "disp current index=" << M_disp_holder.currentIndex() << '\n'
        //          << "     container size=" << M_disp_holder.dispCont().size() << std::endl;
        DispConstPtr disp = M_disp_holder.currentDisp();
        if ( M_disp_holder.dispCont().empty()
             || ( disp && disp->pmode_ == rcss::rcg::PM_TimeOver )
             || M_disp_holder.currentIndex() >= M_disp_holder.dispCont().size() - 2 )
        {

        }
        else
        {
            //std::cerr << "now, playing buffered data" << std::endl;
            M_waited_msec -= POLL_INTERVAL_MS;
        }
    }

    if ( Options::instance().autoReconnectMode() )
    {
        if ( M_waited_msec >= Options::instance().autoReconnectWait() * 1000 )
        {
            //std::cerr << "MonitorClient::handleTimer() waited=" << M_waited_msec << "[ms]"
            //          << " emit reconnectRequested()" << std::endl;
            //emit reconnectRequested();
        }
    }
    else if ( M_waited_msec >= 500 * 1000 )
    {
        std::cerr << "MonitorClient::handleTimer() waited=" << M_waited_msec << "[ms] and emmited disconnection";
        emit disconnectRequested();
    }
}

/*-------------------------------------------------------------------*/
/*!

*/
void
MonitorClient::sendCommand( const std::string & com )
{
    if ( ! isConnected() )
    {
        return;
    }
    std::cerr << "MonitorClient::sendCommand "<< com << std::endl;
    qint64 bytesWritten = M_socket->write( com.c_str(), com.length() + 1/*,
                             M_server_addr,
                             M_server_port*/ );
//    qint64 bytesWritten = M_socket->writeDatagram( com.c_str(), com.length() + 1,
//                             M_server_addr,
//                             M_server_port );
    std::cerr << "send: " << com << ", bytes written: " << bytesWritten << std::endl;
}

/*-------------------------------------------------------------------*/
/*!

*/
void
MonitorClient::sendDispInit()
{
    std::ostringstream ostr;
    if ( M_version )
    {
        ostr << "(dispinit version " << M_version << ")";
    }
    else
    {
        ostr << "(dispinit)";
    }

    sendCommand( ostr.str() );

    if ( M_timer )
    {
        M_timer->start( POLL_INTERVAL_MS );
    }
}

/*-------------------------------------------------------------------*/
/*!

*/
void
MonitorClient::sendDispBye()
{
    sendCommand( "(dispbye)" );
}

/*-------------------------------------------------------------------*/
/*!

*/
void
MonitorClient::sendKickOff()
{
    sendCommand( "(dispstart)" );
}

/*-------------------------------------------------------------------*/
/*!

*/
void
MonitorClient::sendFreeKick( const double & x,
                             const double & y,
                             const rcss::rcg::Side side )
{
    std::ostringstream ostr;
    ostr << "(dispfoul "
         << static_cast< int >( rint( x * rcss::rcg::SHOWINFO_SCALE ) ) << " "
         << static_cast< int >( rint( y * rcss::rcg::SHOWINFO_SCALE ) ) << " "
         << side << ")";

    sendCommand( ostr.str() );
}

/*-------------------------------------------------------------------*/
/*!

*/
void
MonitorClient::sendMove( const rcss::rcg::Side side,
                         const int unum,
                         const double & x,
                         const double & y,
                         const double & angle )
{
    if ( side == rcss::rcg::NEUTRAL )
    {
        std::cerr << __FILE__ << ":" << __LINE__
                  << " dispplayer invalid side" << std::endl;
        return;
    }

    if ( unum < 1 || 11 < unum )
    {
        std::cerr << __FILE__ << ":" << __LINE__
                  << " dispplayer invalid unum " << unum << std::endl;
        return;
    }

    std::ostringstream ostr;
    ostr << "(dispplayer "
         << side << " "
         << unum << " "
         << static_cast< int >( rint( x * rcss::rcg::SHOWINFO_SCALE ) ) << " "
         << static_cast< int >( rint( y * rcss::rcg::SHOWINFO_SCALE ) ) << " "
         << static_cast< int >( rint( angle * rcss::rcg::SHOWINFO_SCALE ) ) << ")";

    sendCommand( ostr.str() );
}

/*-------------------------------------------------------------------*/
/*!

*/
void
MonitorClient::sendDiscard( const rcss::rcg::Side side,
                            const int unum )
{
    if ( side == rcss::rcg::NEUTRAL )
    {
        std::cerr << __FILE__ << ":" << __LINE__
                  << " dispdiscard invalid side" << std::endl;
        return;
    }

    if ( unum < 1 || 11 < unum )
    {
        std::cerr << __FILE__ << ":" << __LINE__
                  << " dispdiscard invalid unum " << unum << std::endl;
        return;
    }

    std::ostringstream ostr;
    ostr << "(dispdiscard "
         << side << " "
         << unum << ")";

    sendCommand( ostr.str() );
}

/*-------------------------------------------------------------------*/
/*!

*/
void
MonitorClient::sendYellowCard( const rcss::rcg::Side side,
                               const int unum )
{
    if ( side == rcss::rcg::NEUTRAL )
    {
        std::cerr << __FILE__ << ":" << __LINE__
                  << " dispcard invalid side" << std::endl;
        return;
    }

    if ( unum < 1 || 11 < unum )
    {
        std::cerr << __FILE__ << ":" << __LINE__
                  << " dispscard invalid unum " << unum << std::endl;
        return;
    }

    std::ostringstream ostr;
    ostr << "(dispcard " << side << ' ' << unum  << " yellow)";

    sendCommand( ostr.str() );
}

/*-------------------------------------------------------------------*/
/*!

*/
void
MonitorClient::sendRedCard( const rcss::rcg::Side side,
                            const int unum )
{
    if ( side == rcss::rcg::NEUTRAL )
    {
        std::cerr << __FILE__ << ":" << __LINE__
                  << " dispcard invalid side" << std::endl;
        return;
    }

    if ( unum < 1 || 11 < unum )
    {
        std::cerr << __FILE__ << ":" << __LINE__
                  << " dispscard invalid unum " << unum << std::endl;
        return;
    }

    std::ostringstream ostr;
    ostr << "(dispcard " << side << ' ' << unum  << " red)";

    sendCommand( ostr.str() );
}
void
MonitorClient::sendTactic(const std::string& teamName,
	const int tactic)
{
	std::ostringstream ostr;
    ostr << "(disptactic "
        << teamName << " "
		<< tactic << ")";

	sendCommand(ostr.str());
}

/*-------------------------------------------------------------------*/
/*!

*/
void
MonitorClient::sendChangeMode( const rcss::rcg::PlayMode pmode )
{
    static const char * pmodes[] = PLAYMODE_STRINGS;

    std::ostringstream ostr;
    ostr << "(change_mode " << pmodes[pmode] << ")";

    sendCommand( ostr.str() );
}

/*-------------------------------------------------------------------*/
/*!

*/
void
MonitorClient::sendTrainerMoveBall( const double & x,
                                    const double & y )
{
    std::ostringstream ostr;

    ostr << "(move (ball) " << x << " " << y << ")";

    sendCommand( ostr.str() );
}

/*-------------------------------------------------------------------*/
/*!

*/
void
MonitorClient::sendTrainerMoveBall( const double & x,
                                    const double & y,
                                    const double & vx,
                                    const double & vy )
{
    std::ostringstream ostr;

    ostr << "(move (ball) "
         << x << " " << y
         << " 0 "
         << vx << " " << vy
         << ")";

    sendCommand( ostr.str() );
}

/*-------------------------------------------------------------------*/
/*!

*/
void
MonitorClient::sendTrainerMovePlayer( const std::string & team_name,
                                      const int unum,
                                      const double & x,
                                      const double & y )
{
    std::ostringstream ostr;

    ostr << "(move (player " << team_name << " " << unum << ") "
         << x << " " << y
         << ")";

    sendCommand( ostr.str() );
}

/*-------------------------------------------------------------------*/
/*!

*/
void
MonitorClient::sendTrainerMovePlayer( const std::string & team_name,
                                      const int unum,
                                      const double & x,
                                      const double & y,
                                      const double & angle )
{
    std::ostringstream ostr;

    ostr << "(move (player " << team_name << " " << unum << ") "
         << x << " " << y
         << " " << angle
         << ")";

    sendCommand( ostr.str() );
}

/*-------------------------------------------------------------------*/
/*!

*/
void
MonitorClient::sendTrainerMovePlayer( const std::string & team_name,
                                      const int unum,
                                      const double & x,
                                      const double & y,
                                      const double & angle,
                                      const double & vx,
                                      const double & vy )
{
    std::ostringstream ostr;

    ostr << "(move (player " << team_name << " " << unum << ") "
         << x << " " << y
         << " " << angle
         << " " << vx << " " << vy
         << ")";

    sendCommand( ostr.str() );
}

/*-------------------------------------------------------------------*/
/*!

*/
void
MonitorClient::sendRecover()
{
    sendCommand( "(recover)" );
}

/*-------------------------------------------------------------------*/
/*!

*/
void
MonitorClient::sencChangePlayerType( const std::string & team_name,
                                     const int unum,
                                     const int type )
{
    std::ostringstream ostr;

    ostr << "(change_player_type "
         << team_name << " "
         << unum << " "
         << type << ")";

    sendCommand( ostr.str() );
}

/*-------------------------------------------------------------------*/
/*!

*/
void
MonitorClient::sendCheckBal()
{
    sendCommand( "(check_ball)" );
}
