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
    //ChartView {
    //width: parent.width
    //height: 150
    //
    //
    //LineSeries {
    //    name: "Temperature"
    //    axisX: ValueAxis {
    //        titleText: "Time"
    //        min: 0
    //        max: 24
    //        labelFormat: "%.0f ч"
    //    }
    //    axisY: ValueAxis {
    //        titleText: "Temp (°C)"
    //    }
    //
    //    Component.onCompleted: {
    //        try {
    //
    //            clear();
    //
    //            if (weather && weather.hourlyData && weather.hourlyData.length > 0) {
    //                console.log("Hourly data length: " + weather.hourlyData.length);
    //                for (var i = 0; i < weather.hourlyData.length; i++) {
    //                    var item = weather.hourlyData[i];
    //
      //                  if (item && item.time && item.temperature !== undefined) {
      //                     var timeParts = item.time.split(":"); // "12:00:00"
      //                      var hour = parseInt(timeParts[0], 10); // Час в виде числа
      //                      var temperature = parseFloat(item.temperature);
        //
        //                    if (!isNaN(hour) && !isNaN(temperature)) {
        //                        append(hour, temperature);
        //                    } else {
        //                        console.log("Invalid data at index " + i + ": " + JSON.stringify(item));
        //                    }
        //                } else {
        //                    console.log("Incomplete data at index " + i);
         //               }
         //           }
         //       } else {
         //           console.log("No valid hourly data available.");
         //       }
         //   } catch (e) {
         //       console.log("Error while populating chart: " + e);
         //   }
       // }
    //}
//}
}}