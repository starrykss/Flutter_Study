import 'package:flutter/material.dart';
import 'package:section_02/dice_roller.dart';

// 변수 선언
const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;
const tmpValue = '231';

class GradientContainer extends StatelessWidget {
  // 생성자 생성
  const GradientContainer(this.color1, this.color2, {super.key});

  const GradientContainer.purple({super.key})
    : color1 = Colors.deepPurple,
      color2 = Colors.indigo;

  final Color color1;
  final Color color2;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color1,
            color2,
          ],
          begin: startAlignment,
          end: endAlignment,
        ),
      ),
      child: Center(
        child: DiceRoller(),
      ),
    );
  }
}
