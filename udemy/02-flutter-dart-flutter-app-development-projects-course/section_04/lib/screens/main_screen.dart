import 'package:flutter/material.dart';

import 'package:section_04/utils/weather.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.weatherData});

  final WeatherData weatherData;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int? temperature;
  AssetImage? backgroundImage;
  Widget? weatherDisplayIcon;

  // 디스플레이 정보 업데이트
  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.currentTemperature!.round();

      WeatherDisplayData weatherDisplayData = weatherData
          .getWeatherDisplayData();

      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }

  @override
  void initState() {
    super.initState();

    // 디스플레이 표시 정보 업데이트
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backgroundImage!,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 50),
                Container(
                  alignment: Alignment.center,
                  child: weatherDisplayIcon,
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    '$temperature°',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
