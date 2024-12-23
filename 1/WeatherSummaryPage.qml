import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    id: weatherSummaryPage
    signal daySelected(var weatherData)

    Column {
        spacing: 10
        anchors.fill: parent
        padding: 20

        Text {
            text: "Прогноз погоды"
            font.pixelSize: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
    id: root
    width: 300
    height: 50
    color: "white" // Начальный цвет фона
    property bool isBlack: false // Состояние фона (черный/белый)

    Button {
        id: themeButton
        text: 'Switch to dark'
        anchors.centerIn: parent
        onClicked: {
            isBlack = !isBlack;
            root.color =  "black";
            themeButton.text = isBlack ? "Switch to White" : "Switch to Black"
        }
    }
}
TextField {
            id: cityInput
            width: parent.width * 0.8
            placeholderText: "Например, Moscow"
            font.pixelSize: 16
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Button {
            text: "Загрузить"
            onClicked: {
                console.log("Loading weather data...");
                loadWeatherData(cityInput.text);
            }
            anchors.horizontalCenter: parent.horizontalCenter
        }

        ListView {
            id: weatherListView
            model: weatherModel
            width: parent.width
            height: parent.height - 100

            delegate: Item {
                width: parent.width
                height: 120

                Column {
                    spacing: 5

                    Text {
                        text: 'Дата: ' + date
                        font.pixelSize: 14
                    }
                    Text {
                        text: 'Температура: ' + tempMin + "°C / " + tempMax + "°C"
                        font.pixelSize: 14
                    }
                    Text {
                        text: 'Пояснение: "' + description + '"'
                        font.pixelSize: 14
                    }

                    Button {
                        text: "Подробнее"
                        onClicked: daySelected(model);
                    }
                }

                Rectangle {
                    height: 1
                    color: "#000000"
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }

    ListModel {
        id: weatherModel
    }

    function loadWeatherData(city) {
    var apiKey = "735723593fa68b5cc5c23d4638109c41";
    var url = "https://api.openweathermap.org/data/2.5/forecast?q=" + city + "&appid=" + apiKey + "&units=metric&lang=ru";

    var xhr = new XMLHttpRequest();
    xhr.open("GET", url);
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                var data = JSON.parse(xhr.responseText);
                parseWeatherData(data);
            } else {
                console.log("Failure: " + xhr.status);
            }
        }
    };
    xhr.send();
}

    function parseWeatherData(data) {
    weatherModel.clear();
    var dailyData = {};


    data.list.forEach(function(item) {
        var date = item.dt_txt.split(" ")[0];
        if (!dailyData[date]) {
            dailyData[date] = {
                tempMin: item.main.temp_min,
                tempMax: item.main.temp_max,
                description: item.weather[0].description,
                windSpeed: item.wind.speed,
                windDirection: item.wind.deg,
                humidity: item.main.humidity,
                pressure: item.main.pressure,
                rain: item.rain ? item.rain["3h"] : 0,
                snow: item.snow ? item.snow["3h"] : 0,
                hourlyData: [],
                icon: item.weather[0].icon
            };
        } else {
            dailyData[date].tempMin = Math.min(dailyData[date].tempMin, item.main.temp_min);
            dailyData[date].tempMax = Math.max(dailyData[date].tempMax, item.main.temp_max);
            dailyData[date].rain += item.rain ? item.rain["3h"] : 0;
            dailyData[date].snow += item.snow ? item.snow["3h"] : 0;
        }
        dailyData[date].hourlyData.push({
            time: item.dt_txt.split(" ")[1],
            temperature: item.main.temp,
            description: item.weather[0].description
        });
    });

    Object.keys(dailyData).forEach(function(date) {
        var day = dailyData[date];
        weatherModel.append({
            date: date,
            tempMin: day.tempMin,
            tempMax: day.tempMax,
            description: day.description,
            windSpeed: day.windSpeed,
            windDirection: day.windDirection,
            humidity: day.humidity,
            pressure: day.pressure,
            rain: day.rain,
            snow: day.snow,
            icon: day.icon,
            hourlyData: day.hourlyData
        });
    });
}
}