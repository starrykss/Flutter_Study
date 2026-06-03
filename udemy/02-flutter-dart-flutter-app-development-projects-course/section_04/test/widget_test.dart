import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:section_04/utils/location.dart';
import 'package:section_04/utils/weather.dart';

void main() {
  test('returns rainy display data for weather conditions below 600', () {
    final weatherData = WeatherData(locationHelper: LocationHelper())
      ..currentCondition = 500;

    final displayData = weatherData.getWeatherDisplayData();

    expect(displayData.weatherIcon, isA<Widget>());
    expect(displayData.weatherImage, isA<AssetImage>());
    expect(displayData.weatherImage!.assetName, 'assets/images/rainy.jpg');
  });
}
