import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

Page {
    id: weatherDetailsPage
    property var weather: null
    signal back()
    Rectangle {
            id: rectrect
            width: parent.width
            height: parent.height
            color: summaryPage.colorbac // Начальный цвет фона
            property bool isBlack: false // Состояние фона (черный/белый)



    Column {
        spacing: 10
        anchors.fill: parent
        padding: 20

        Button {
            text: "ВЗАД"
            onClicked: back()
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: weather ? "Детальный прогноз для " + weather.date : "Нет данных"
            font.pixelSize: 20
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            color: summaryPage.colort
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
            color: summaryPage.colort
        }




        Text {
            text: weather ? "Ощущается как: " + weather.feelsLike : "Нет описания."
            font.pixelSize: 16
            color: summaryPage.colort
        }




        Text {
            text: weather ? "Температура: " + weather.tempMin + "°C / " + weather.tempMax + "°C" : ""
            font.pixelSize: 16
            color: summaryPage.colort
        }

        Text {
            text: weather ? "Скорость ветра: " + weather.windSpeed + " м/с" : ""
            font.pixelSize: 16
            color: summaryPage.colort
        }

        Text {
            text: weather ? "Направление ветра: " + weather.windDirection + "°" : ""
            font.pixelSize: 16
            color: summaryPage.colort
        }

        Text {
            text: weather ? "Влажность: " + weather.humidity + "%" : ""
            font.pixelSize: 16
            color: summaryPage.colort
        }

        Text {
            text: weather ? "Давление: " + weather.pressure + " гПа" : ""
            font.pixelSize: 16
            color: summaryPage.colort
        }



        // Данные об осадках (дождь и снег)
        Row {
            spacing: 20
            Text {
                text: weather ? "Дождь: " + weather.rain + " мм" : "Нет данных"
                font.pixelSize: 16
                color: summaryPage.colort
            }
            Text {
                text: weather ? "Снег: " + weather.snow + " мм" : "Нет данных"
                font.pixelSize: 16
                color: summaryPage.colort
            }
            Text {
                text: "ТЕСТ ТЕСТ  " + parseFloat(weather.hourlyData.get(1).temperature)
                font.pixelSize: 16
                color: summaryPage.colort
            }
        }
        ChartView {
            id: temperatureChart
            width: parent.width
            height: 200
            visible: weather


            DateTimeAxis {
                id: xAxis
                format: "hh:mm:ss"
                tickCount: 5
            }

            ValueAxis {
                id: yAxis
                titleText: "Температура, °C"
                min: weather ? Math.floor(weather.tempMin)  : 0
                max: weather ? Math.ceil(weather.tempMax)  : 30
            }

            LineSeries {
                name: "Температура"
                color: "#2980b9"
                XYPoint {x: 0; y: parseFloat(weather.hourlyData.get(0).temperature)}
                XYPoint {x: 1; y: parseFloat(weather.hourlyData.get(1).temperature)}
                XYPoint {x: 2; y: weather.hourlyData.get(2).temperature}
                XYPoint {x: 4; y: weather.hourlyData.get(3).temperature}
            }
        }


    }
   }
}
