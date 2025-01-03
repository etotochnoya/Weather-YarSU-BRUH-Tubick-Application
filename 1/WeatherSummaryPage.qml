import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    id: weatherSummaryPage;
    signal daySelected(var weatherData);
    Rectangle {
            id: rectrect
            width: parent.width
            height: parent.height
            color: summaryPage.colorbac // Начальный цвет фона
            property bool isBlack: false // Состояние фона (черный/белый)
            property var isTheme: false


    Column {
        id: rect
        spacing: 10
        anchors.fill: parent
        padding: 20

        Text {
            color: summaryPage.colort
            text: "Прогноз погоды"
            font.pixelSize: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }




        Button {
            text: "Загрузить"
            onClicked: {
                console.log("Loading weather data...");
                loadWeatherData("Yaroslavl");
            }
            anchors.horizontalCenter: parent.horizontalCenter
        }

         Button {
                id: themeButton
                text: 'Switch to dark'
                x: 100
                y: -50
                onClicked: {
                        if (rectrect.isTheme == false) {
                            summaryPage.colorbac = "#3A3B3C"
                            summaryPage.colort = "#FFFDD0"
                            rectrect.isTheme = true
                        }
                        else {
                            summaryPage.colorbac = "#FCF9E6"
                            summaryPage.colort = "#242526"
                            rectrect.isTheme = false
                        }
                }

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
                        color: summaryPage.colort
                        text: 'Дата: ' + date
                        font.pixelSize: 14
                    }
                    Text {
                        color: summaryPage.colort
                        text: 'Температура: ' + tempMin + "°C / " + tempMax + "°C"
                        font.pixelSize: 14
                    }
                    Text {
                        color: summaryPage.colort
                        text: 'Погода: "' + description + '"'
                        font.pixelSize: 14
                    }

                    Button {
                        text: "Прогноз дня"
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

            Image {
            id: rotatingImage
            source: "img.jpg"
            width: 100
            height: 100
            x: 0

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    rotationAnimation.start()
                }
            }
            RotationAnimation {
                id: rotationAnimation
                target: rotatingImage
                property: "rotation"
                from: rotatingImage.rotation
                to: rotatingImage.rotation + 180
                duration: 250
            }
        }

        Image {
            id: treesLogo
            source: "trees.jpg"
            width: 400
            height: 400
            x: 880
        }

    ListModel {
        id: weatherModel
    }
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
                icon: item.weather[0].icon,
                feelsLike: item.main.feels_like
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
            hourlyData: day.hourlyData,
            feelsLike: day.feelsLike
        });
    });
}
}