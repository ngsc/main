import QtQuick 2.0

import com.Game.APIConnection 1.0
import com.Game.SortFilterProxyModel 1.0
import com.Game.News 1.0


Rectangle {
    id: root
    property string titleBar: qsTr("News Page")

    color: "transparent"

    property News currentNews
    property alias newsModel: newsModel
    property int newsCount: 0

    onCurrentNewsChanged: {
        console.log("news changed: " + currentNews.stage + "\n" + currentNews.brief)
    }

    Component {
        id: newsDelegate
        Item {
            id: news
            width: listView.width
            height: 30

            Rectangle {
                id: background
                x: 2; y: 2; width: parent.width - x*2; height: parent.height - y*2
                color: "transparent"
                radius: 5

                Text {
                    text: brief
                    color: "red"
                    font.pointSize: 14
                    font.family: "Comic Sans MS"
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                }
            }
        }
    }

    NewsModel {
        id: newsModel
    }

    CustomGroupBox {
        id: inbox_box
        anchors.left: parent.left
        anchors.top: parent.top
        //width: 400
        anchors.right: parent.right
        height: parent.height/3
        title_text: qsTr("Inbox")
        border_color: "#55aaff"
        border_width: 1
        box_content_item: Rectangle
        {
            anchors.fill: parent
            color: "transparent"
            radius: parent.radius
            clip: true
            ListView {
                id: listView
                anchors.fill: parent
                model: newsModel
                highlight: Rectangle { color:"lightblue" /*"lightsteelblue"*/; radius: 5 }
                focus: true
                highlightFollowsCurrentItem: true
                highlightRangeMode: ListView.NoHighlightRange
                snapMode: ListView.SnapToItem

                delegate: Item {
                    id: news

                    width: listView.width
                    height: 30

                    Rectangle {
                        id: background
                        color: "transparent"
                        anchors.fill: parent
                        Text {
                            id: bid
                            anchors.top: parent.top
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom

                            text: brief
                            color: read === true ? "white" : "red"
                            font.pointSize: 11
                            font.family: "Comic Sans MS"
                            verticalAlignment: Text.AlignVCenter
                            z : listView.z
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                listView.currentIndex = index
                                root.currentNews = listView.model.at(index)
                                details_box.showDetails = true
                                bid.color = "white"
                                if(root.currentNews.read !== true) {
                                    APIConnection.updateNewsReadStatus(managerUser.token, root.currentNews.id)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    CustomGroupBox {
        id: details_box
        anchors.top: inbox_box.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        property bool showDetails: false

        title_text: qsTr("Details")
        box_content_item: Rectangle{
            anchors.fill: parent
            color: "transparent"
            radius: parent.radius
            clip: true
            visible: details_box.showDetails
            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: respond_button.top
                color: "transparent"

                Text {
                    id: did
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.right: parent.right

                    text: qsTr("Date: %1").arg(Qt.formatDateTime(currentNews.dateTime, "yyyy-MM-dd hh:mm:ss"))
                    color: "white"
                    font.pointSize: 11
                    font.family: "Comic Sans MS"
                    verticalAlignment: Text.AlignVCenter
                }

                Text {
                    id: msg
                    anchors.top: did.bottom
                    anchors.topMargin: 30
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    anchors.bottom: parent.bottom

                    text: currentNews.message
                    color: "white"
                    font.pointSize: 13
                    font.family: "Comic Sans MS"
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                }
            }

            MyButtonNormal {
                id: respond_button
                anchors { bottom: parent.bottom; bottomMargin: 20; right: parent.right; rightMargin: 10 }
                visible: currentNews.newsType === News.Offer && currentNews.active && details_box.showDetails
                text: currentNews.stage === News.OfferContract ? qsTr("Offer Contract") : qsTr("Respond")
                width: 120
                onClicked: {
                    if(currentNews.stage === News.OfferContract)
                    {
                        submitContract.news = currentNews
                        app.callinsidepage2(submitContract);
                        app.busyIndicator.running = true
                        APIConnection.getOfferWithPlayerDetails(managerUser.token, currentNews.offerId)
                    }
                    else
                    {
                        viewOffer.news = currentNews;
                        app.callinsidepage2(viewOffer);
                        app.busyIndicator.running = true
                        APIConnection.getOfferWithPlayerDetails(managerUser.token, currentNews.offerId)
                    }
                }
            }

            MyButtonNormal {
                id: close_button
                anchors { top: parent.top; topMargin: 20; right: parent.right; rightMargin: 10 }
                visible: details_box.showDetails
                text: qsTr("Close")
                onClicked: {
                    did.text = ""
                    msg.text = ""
                    details_box.showDetails = false
                }
            }
        }
    }

    Connections {
        target: APIConnection

        onGetNewsFinished: {
            newsModel.setNews(news);
            newsflashanimation.running = stackView.__currentItem !== newsPage && newsModel.containsUnread() && newsModel.count != root.newsCount

            if(stackView.__currentItem === newsPage) {
                root.newsCount = newsModel.count
            }
        }
    }
}
