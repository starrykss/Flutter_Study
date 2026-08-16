import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  // 위치 정보 가져오기
  Future<void> getCurrentLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception('기기 위치 서비스가 꺼져 있습니다. 위치를 켜주세요.');
    }

    // (1) 위치 권한 확인
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('위치 권한이 영구적으로 거부되었습니다. 앱 설정에서 허용해주세요.');
    }

    if (permission == LocationPermission.denied) {
      throw Exception('위치 권한이 거부되었습니다.');
    }

    // (2) 현재 위치 가져오기
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
      ),
    );

    latitude = position.latitude;
    longitude = position.longitude;
  }
}
