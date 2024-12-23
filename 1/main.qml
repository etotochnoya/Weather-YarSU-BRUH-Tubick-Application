import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 400
    height: 600
    title: "Weather Forecast"
    color: "#000000"

    property var selectedWeather: null


    StackLayout {
        id: stackLayout
        anchors.fill: parent


        WeatherSummaryPage {
            id: summaryPage
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