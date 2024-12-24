import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 1280
    height: 720
    title: "Weather YARSU. uniYAR bruh tubick application"
    color: "#000000"

    property var selectedWeather: null


    StackLayout {
        id: stackLayout
        anchors.fill: parent


        WeatherSummaryPage {
            id: summaryPage
            property color colorbac: "#FCF9E6"
            property color colort: "#242526"
            onDaySelected: {
                selectedWeather = weatherData;
                stackLayout.currentIndex = 1;
            }
        }

        WeatherDetailsPage {
            id: detailsPage
            weather: selectedWeather
            onBack: stackLayout.currentIndex = 0
        }
    }
}