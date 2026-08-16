import 'package:section_09/services/location.dart';
import 'package:section_09/services/networking.dart';

const apiKey = 'YOUR_OPENWEATHER_API_KEY';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  /// 특정 도시의 날씨 정보 가져오기
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
      Uri.parse('$openWeatherMapURL?q=$cityName&appId=$apiKey&units=metric'),
    );

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  /// 현재 위치 날씨 정보 가져오기
  Future<dynamic> getLocationWeather() async {
    final location = Location();

    // (1) 현재 위치 정보 가져오기
    await location.getCurrentLocation();

    // (2) 날씨 데이터 가져오기
    final weatherUrl = Uri.parse(
      '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric',
    );
    final networkHelper = NetworkHelper(weatherUrl);

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  /// 날씨 아이콘 가져오기
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  /// 날씨 메시지 가져오기
  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
