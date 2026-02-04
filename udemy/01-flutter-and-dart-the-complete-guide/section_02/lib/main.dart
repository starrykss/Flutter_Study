import 'package:flutter/material.dart';
import 'package:section_02/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          Color.fromARGB(255, 33, 5, 109),
          Color.fromARGB(255, 61, 25, 161),
        ), // 생성자
      ),
    ),
  );
}
