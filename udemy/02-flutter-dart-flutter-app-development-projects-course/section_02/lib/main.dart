import 'package:flutter/material.dart';

import 'package:section_02/constants.dart';
import 'package:section_02/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Grade Calculator',
      theme: ThemeData(
        primarySwatch: Constants.mainColor, // 앱 전체 색상 테마 설정
        visualDensity:
            VisualDensity.adaptivePlatformDensity, // 플랫폼 별 밀도 자동 최적화 작업 진행
      ),
      home: MainPage(),
    );
  }
}
