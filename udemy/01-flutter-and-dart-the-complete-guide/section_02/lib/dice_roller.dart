import 'dart:math';
import 'package:flutter/material.dart';

// 랜덤 숫자 생성
final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var currentDiceRoll = 2;

  // 함수 선언
  void rollDice() {
    // setState는 상태가 변경되면 build를 다시 수행하도록 한다.
    setState(() {
      currentDiceRoll = randomizer.nextInt(6) + 1; // 1 ~ 6
    });
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          "assets/images/dice-$currentDiceRoll.png",
          width: 200,
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
            // padding: const EdgeInsets.only(
            //   top: 20,
            // ),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 28,
            ),
          ),
          child: Text("Roll Dice"),
        ),
      ],
    );
  }
}
