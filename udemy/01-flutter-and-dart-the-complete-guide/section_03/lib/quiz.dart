import 'package:flutter/material.dart';

import 'package:section_03/questions_screen.dart';
import 'package:section_03/results_screen.dart';
import 'package:section_03/start_screen.dart';
import 'package:section_03/data/questions.dart';

class Quiz extends StatefulWidget {
  // 생성자
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState(); // private
  }
}

class _QuizState extends State<Quiz> {
  // 변수 선언
  List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';

  // 화면 바꾸기
  void switchScreen() {
    // 상태 변수 변경
    setState(() {
      activeScreen = "questions-screen";
    });
  }

  // 정답 선택 처리
  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    // 종료 조건
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  // 다시 시작 처리
  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = "questions-screen";
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(switchScreen);

    // activeScreen 값에 따라 다른 스크린 렌더링
    if (activeScreen == "questions-screen") {
      screenWidget = QuestionsScreen(
        onSelectAnswer: chooseAnswer,
      );
    }

    if (activeScreen == "results-screen") {
      screenWidget = ResultsScreen(
        chosenAnswers: selectedAnswers,
        onRestart: restartQuiz,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
