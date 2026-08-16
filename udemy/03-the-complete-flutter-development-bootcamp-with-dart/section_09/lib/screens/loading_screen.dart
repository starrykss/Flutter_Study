import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:section_09/screens/location_screen.dart';
import 'package:section_09/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();

    getLocationData();
  }

  // 위치 + 날씨 정보 가져오기
  Future<void> getLocationData() async {
    try {
      // (1) 현재 위치 날씨 정보 가져오기
      final weatherData = await WeatherModel().getLocationWeather();

      if (!mounted) return;

      // (2) 페이지 이동
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LocationScreen(
              locationWeather: weatherData,
            );
          },
        ),
      );
    } catch (e) {
      debugPrint('위치 정보를 가져오지 못했습니다: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
