import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

import 'package:section_04/utils/location.dart';

// OpenWeather API Key
const apiKey = "YOUR_API_KEY";

class WeatherDisplayData {
  WeatherDisplayData({
    required this.weatherIcon,
    required this.weatherImage,
  });

  Widget? weatherIcon;
  AssetImage? weatherImage;
}

class WeatherData {
  WeatherData({required this.locationHelper});

  late LocationHelper locationHelper;
  double? currentTemperature;
  int? currentCondition;

  // 현재 온도 가져오기
  Future<void> getCurrentTemperature() async {
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'lat': locationHelper.latitude.toString(),
      'lon': locationHelper.longitude.toString(),
      'units': 'metric',
      'appid': apiKey,
    });

    try {
      Response response = await get(url).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        String data = response.body;

        var currentWeather = jsonDecode(data);

        currentTemperature = (currentWeather['main']?['temp'] as num?)
            ?.toDouble();
        currentCondition = (currentWeather['weather']?[0]?['id'] as num?)
            ?.toInt();
      } else {
        debugPrint(
          'No value from api. Status: ${response.statusCode}, Body: ${response.body}',
        );
      }
    } on TimeoutException catch (e) {
      debugPrint('OpenWeather request timed out: $e');
    } catch (e) {
      debugPrint('OpenWeather request failed: $e');
    }
  }

  // 날씨 표시 데이터 가져오기
  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition! < 600) {
      return WeatherDisplayData(
        weatherIcon: FaIcon(
          FontAwesomeIcons.cloud,
          size: 60,
          color: Colors.white,
        ),
        weatherImage: AssetImage("assets/images/rainy.jpg"),
      );
    } else {
      var now = DateTime.now();

      if (now.hour >= 19) {
        return WeatherDisplayData(
          weatherIcon: FaIcon(
            FontAwesomeIcons.moon,
            size: 60,
            color: Colors.white,
          ),
          weatherImage: AssetImage("assets/images/night.jpg"),
        );
      } else {
        return WeatherDisplayData(
          weatherIcon: FaIcon(
            FontAwesomeIcons.sun,
            size: 60,
            color: Colors.white,
          ),
          weatherImage: AssetImage("assets/images/sunny.jpg"),
        );
      }
    }
  }
}
