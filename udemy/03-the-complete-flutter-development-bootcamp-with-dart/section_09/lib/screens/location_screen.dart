import 'package:flutter/material.dart';

import 'package:section_09/utilities/constants.dart';
import 'package:section_09/services/weather.dart';
import 'package:section_09/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int? temperature;
  String? weatherIcon;
  String? weatherMessage;
  String? cityName;

  @override
  void initState() {
    super.initState();

    // 전달 받은 인자값을 이용하여 UI 업데이트
    updateUI(widget.locationWeather);
  }

  /// UI 수정하기
  void updateUI(dynamic weatherData) {
    setState(() {
      // 날씨 데이터가 없을 경우
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data.';
        cityName = '';

        return;
      }

      double temp = weatherData['main']['temp'];
      temperature = temp.toInt(); // 정수형으로 변환

      var condition = weatherData['weather'][0]['id'];

      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature ?? 0);

      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withValues(
                alpha: 0.8,
              ),
              BlendMode.dstATop,
            ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      // 현재 위치 정보 가져와서 반영하기
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      // 페이지 이동하기
                      // - 다음 페이지에서 pop 하면서, 변수를 넘겼을 경우
                      //   해당 값을 가져올 수 있음.
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );

                      // UI 업데이트
                      if (typedName != null) {
                        var weatherData = await weather.getCityWeather(
                          typedName,
                        );
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon!,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
