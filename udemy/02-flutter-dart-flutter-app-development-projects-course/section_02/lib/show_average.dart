import 'package:flutter/material.dart';

import 'package:section_02/constants.dart';

class ShowAverage extends StatelessWidget {
  final double average;
  final int numberOfLesson;

  const ShowAverage({
    super.key,
    required this.average,
    required this.numberOfLesson,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          numberOfLesson > 0 ? '$numberOfLesson Lesson' : 'Please Enter Lesson',
          style: Constants.lessonStyle,
        ),
        Text(
          average >= 0 ? '${average.toStringAsFixed(2)}' : '0.0',
          style: Constants.averageStyle,
        ),
        Text(
          'Average',
          style: Constants.lessonStyle,
        ),
      ],
    );
  }
}
