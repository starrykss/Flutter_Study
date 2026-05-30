import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  static const mainColor = Colors.deepPurple;
  // static -> 인스턴스를 만들지 않아도 접근 가능
  // 예1) Constants.mainColor [static이 있는 경우]
  // 예2) final mainColor = Colors.deepPurple;
  //     print(c.mainColor); [static이 없는 경우]

  static const String title = 'Calculate Average';

  static BorderRadius radius = BorderRadius.circular(20);

  static final TextStyle textStyle = GoogleFonts.lato(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: mainColor,
  );

  static final TextStyle lessonStyle = GoogleFonts.lato(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Colors.deepPurple,
  );

  static final TextStyle averageStyle = GoogleFonts.lato(
    fontSize: 50,
    fontWeight: FontWeight.w700,
    color: Colors.deepPurple,
  );
}
