import 'package:flutter/material.dart';

import 'package:section_08/screens/input_page.dart';

void main() {
  runApp(const BMICalculator());
}

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF0A0E21),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF0A0E21),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0A0E21), // 배경색
          foregroundColor: Colors.white, // 텍스트색
          centerTitle: true,
        ),
      ),
      home: const InputPage(),
    );
  }
}
