import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:section_06/quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(const Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  // 정답 확인
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();

    setState(() {
      // 퀴즈가 끝났을 경우
      if (quizBrain.isQuizFinished()) {
        Alert(
          context: context,
          type: AlertType.success,
          title: "Finished!",
          desc: "You've reached the end of quiz.",
          style: const AlertStyle(
            descStyle: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
          buttons: [
            DialogButton(
              color: Colors.blue,
              radius: BorderRadius.circular(8),
              child: const Text(
                'CANCEL',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  // 초기화
                  scoreKeeper.clear();
                  quizBrain.resetQuestionNumber();
                });
              },
            ),
          ],
        ).show();
      }

      // 정답이 맞을 경우
      if (correctAnswer == userPickedAnswer) {
        scoreKeeper.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        scoreKeeper.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }

      quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                checkAnswer(true);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green, // 배경 색상
                foregroundColor: Colors.white, // 텍스트 색상
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),

        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                checkAnswer(false);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red, // 배경 색상
              ),
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),

        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
