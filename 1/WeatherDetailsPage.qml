import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

Page {
    id: weatherDetailsPage
    property var weather: null
    signal back()

    Column {
        spacing: 10
        anchors.fill: parent
        padding: 20

        Button {
            text: "Back"
            onClicked: back()
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: weather ? "Детальный прогноз для " + weather.date : "Нет данных"
            font.pixelSize: 20
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#000000"
        }
        Rectangle{
            width: 50
            height: 50
            color: "#808080"
            radius: 15
            Image {
                id: weatherIcon
                source: weather ? "http://openweathermap.org/img/wn/" + weather.icon + "@2x.png" : ""
                width: 50
                height: 50
                anchors.centerIn: parent
            }
        }

        Text {
            text: weather ? "Описание: " + weather.description : "Нет описания."
            font.pixelSize: 16
            color: "#555"
        }

        Text {
            text: weather ? "Температура: " + weather.tempMin + "°C / " + weather.tempMax + "°C" : ""
            font.pixelSize: 16
            color: "#555"
        }

        Text {
            text: weather ? "Скорость ветра: " + weather.windSpeed + " м/с" : ""
            font.pixelSize: 16
            color: "#555"
        }

        Text {
            text: weather ? "Направление ветра: " + weather.windDirection + "°" : ""
            font.pixelSize: 16
            color: "#555"
        }

        Text {
            text: weather ? "Влажность: " + weather.humidity + "%" : ""
            font.pixelSize: 16
            color: "#555"
        }

        Text {
            text: weather ? "Давление: " + weather.pressure + " гПа" : ""
            font.pixelSize: 16
            color: "#555"
        }

        // Данные об осадках (дождь и снег)
        Row {
            spacing: 20
            Text {
                text: weather ? "Дождь: " + weather.rain + " мм" : "Нет данных"
                font.pixelSize: 16
                color: "#555"
            }
            Text {
                text: weather ? "Снег: " + weather.snow + " мм" : "Нет данных"
                font.pixelSize: 16
                color: "#555"
            }
        }
}}