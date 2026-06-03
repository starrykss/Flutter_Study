import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:section_04/screens/main_screen.dart';

import "package:section_04/utils/location.dart";
import 'package:section_04/utils/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LocationHelper locationData;
  String? errorMessage;

  // 현재 위치 정보 가져오기
  Future<void> getLocationData() async {
    locationData = LocationHelper();

    // 현재 위치 정보 가져오기
    await locationData.getCurrentLocation();

    if (locationData.latitude == null || locationData.longitude == null) {
      debugPrint("Location information not coming");
    } else {
      debugPrint('Latitude: ${locationData.latitude}');
      debugPrint('Longitude: ${locationData.longitude}');
    }
  }

  // 날씨 데이터 가져오기
  Future<void> getWeatherData() async {
    if (errorMessage != null) {
      setState(() {
        errorMessage = null;
      });
    }

    try {
      // 위치 데이터 가져오기 (위도, 경도)
      await getLocationData();

      if (locationData.latitude == null || locationData.longitude == null) {
        throw Exception('Location information not coming');
      }

      WeatherData weatherData = WeatherData(
        locationHelper: locationData,
      );

      // 현재 날씨 정보 가져오기
      await weatherData.getCurrentTemperature();

      if (weatherData.currentTemperature == null ||
          weatherData.currentCondition == null) {
        throw Exception('No value from api.');
      }

      if (!mounted) {
        return;
      }

      // 페이지 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return MainScreen(
              weatherData: weatherData, // 파라미터로 넘기기
            );
          },
        ),
      );
    } catch (e) {
      debugPrint('Failed to load weather data: $e');

      if (!mounted) {
        return;
      }

      setState(() {
        errorMessage =
            'Could not load weather.\nCheck location permission and API key.';
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // 위치 정보 가져오기
    // getLocationData();

    // 날씨 정보 가져오기
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Colors.pink.shade200, Colors.purple.shade600],
          ),
        ),
        child: Center(
          child: errorMessage == null
              ? SpinKitFadingCircle(
                  color: Colors.blue.shade300,
                  size: 170,
                  duration: Duration(milliseconds: 1500),
                )
              : Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        errorMessage!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: getWeatherData,
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
