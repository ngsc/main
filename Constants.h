#ifndef CONSTANTS_H
#define CONSTANTS_H

#include "qstring.h"
#include "qglobal.h"
namespace ClientConstants {
    // old kansas server IP 192.168.43.119
    // other IPs used in the past 192.168.44.129
    // China server 106.54.22.63
    //host = "127.0.0.1";/*"106.54.22.63";*///"192.168.44.129";"127.0.0.1";

    const QString serverHost = "9.0.0.2";
    const QString matchServerSrcPath = "football/customserver/server/src";
    const QString user = "root";
    const quint64 key = 0x0c2ad4b4acb9f023;
}
#endif // CONSTANTS_H
