import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  // 생성자 생성
  const StyledText(this.text, {super.key});

  final String text;

  @override
  Widget build(context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 28,
      ),
    );
  }
}
