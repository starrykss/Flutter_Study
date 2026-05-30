import 'package:flutter/material.dart';

import 'package:section_02/model/lesson.dart';

class DataHelper {
  static List<Lesson> allAddedLessons = [];
  static List<String> letterGrade = [
    'A+',
    'A0',
    'B+',
    'B0',
    'C+',
    'C0',
    'D+',
    'D0',
    'F',
  ];

  static double numberGrade(String letter) {
    switch (letter) {
      case "A+":
        return 4.5;
      case "A0":
        return 4.0;
      case "B+":
        return 3.5;
      case "B0":
        return 3.0;
      case "C+":
        return 2.5;
      case "C0":
        return 2.0;
      case "D+":
        return 1.5;
      case "D0":
        return 1.0;
      case "F":
        return 0;
      default:
        return 0;
    }
  }

  static List<DropdownMenuItem<double>> allLessonLetter() {
    return letterGrade
        .map(
          (e) => DropdownMenuItem(
            child: Text(e),
            value: numberGrade(e),
          ),
        )
        .toList();
  }

  static List<int> allCredits() {
    return List.generate(15, (index) => index + 1).toList();
  }

  static List<DropdownMenuItem<double>> allCreditsList() {
    return allCredits()
        .map(
          (e) => DropdownMenuItem(
            child: Text(e.toString()),
            value: e.toDouble(),
          ),
        )
        .toList();
  }

  // 수업 아이템 추가 처리
  static addLesson(Lesson lesson) {
    allAddedLessons.add(lesson);
  }

  // 평균값 구하기
  static calculateAverage() {
    double totalGrade = 0;
    double totalCredit = 0;

    allAddedLessons.forEach((element) {
      totalGrade = totalGrade + (element.credit * element.letterGrade);
      totalCredit = totalCredit + element.credit;
    });

    return totalGrade / totalCredit;
  }
}
