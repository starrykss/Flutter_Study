import 'package:flutter/material.dart';

import 'package:section_01/route_generator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 우측 상단 DEBUG 배너 제거
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      // home: BookList(),
      onGenerateRoute: RouteGenerator.routeGenerator,
    );
  }
}
