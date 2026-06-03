import 'package:location/location.dart';

class LocationHelper {
  double? longitude;
  double? latitude;

  Future<void> getCurrentLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionStatus;
    LocationData locationData;

    // [1] 서비스 허용 여부, 권한 여부 확인
    // <1> 서비스가 활성화 됐는지 체크
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      // 서비스 요청
      serviceEnabled = await location.requestService();

      // 서비스가 허용되지 않았을 경우 -> 종료
      if (!serviceEnabled) {
        return;
      }
    }

    // <2> 권한이 허용 됐는지 체크
    permissionStatus = await location.hasPermission();

    // 권한 요청이 거부 상태인 경우 -> 다시 권한 요청
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }

    // 권한이 허용되지 않았을 경우 -> 종료
    if (permissionStatus != PermissionStatus.granted) {
      return;
    }

    // [2] 작업 시작
    locationData = await location.getLocation();

    longitude = locationData.longitude;
    latitude = locationData.latitude;
  }
}
