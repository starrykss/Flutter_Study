import 'package:flutter/material.dart';

import 'package:section_02/constants.dart';
import 'package:section_02/data.dart';
import 'package:section_02/lesson_list.dart';
import 'package:section_02/model/lesson.dart';
import 'package:section_02/show_average.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MainPage> {
  var formKey = GlobalKey<FormState>();

  // 상태 변수는 build 영역이 아닌 클래스 영역에 선언해야 한다.
  // -> 그렇지 않을 경우, setState() 호출 시마다 기본값으로 초기화된다.
  double selectedValue = 3;
  double selectedCredit = 1;
  String incomingLessonName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          Constants.title,
          style: Constants.textStyle,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: createForm(),
              ),

              Expanded(
                flex: 1,
                child: ShowAverage(
                  average: DataHelper.calculateAverage(),
                  numberOfLesson: DataHelper.allAddedLessons.length,
                ),
              ),
            ],
          ),

          Expanded(
            child: LessonList(
              onDismissed: (index) {
                DataHelper.allAddedLessons.removeAt(index);

                // 리렌더링 작업
                setState(() {});

                // print('Deleted element is $index.');
              },
            ),
          ),
        ],
      ),
    );
  }

  // 폼 생성
  Widget createForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          // (1) 텍스트 필드
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: createTextField(),
          ),

          SizedBox(height: 7),

          // (2) 학점 선택
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // 문자형 학점
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: createLetterGrade(),
                ),
              ),

              // 숫자형 학점
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: createCredits(),
                ),
              ),

              // 아이콘
              IconButton(
                onPressed: () {
                  addLessonAndCalculate();
                },
                icon: Icon(
                  Icons.arrow_forward,
                  color: Constants.mainColor,
                  size: 50,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 텍스트 필드 생성
  Widget createTextField() {
    return TextFormField(
      onSaved: (value) {
        setState(() {
          incomingLessonName = value!;
        });
      },
      validator: (value) {
        if (value!.length <= 0) {
          return 'Please Enter a Lesson';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: ('LESSON'),
        filled: true,
        fillColor: Constants.mainColor.shade100,
      ),
    );
  }

  // 학점 아이템 만들기
  Widget createLetterGrade() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Constants.mainColor.shade100.withValues(
          alpha: 0.5,
        ),
        borderRadius: Constants.radius,
      ),

      child: DropdownButton<double>(
        onChanged: (value) {
          setState(() {
            selectedValue = value!;
          });
        },
        value: selectedValue,
        items: DataHelper.allLessonLetter(),
      ),
    );
  }

  // 학점 만들기
  Widget createCredits() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Constants.mainColor.shade100.withValues(
          alpha: 0.5,
        ),
        borderRadius: Constants.radius,
      ),

      child: DropdownButton<double>(
        onChanged: (value) {
          setState(() {
            selectedCredit = value!;
          });
        },
        value: selectedCredit,
        items: DataHelper.allCreditsList(),
      ),
    );
  }

  // 수업 아이템 추가 후, 계산 처리
  void addLessonAndCalculate() {
    if (formKey.currentState!.validate()) {
      // 저장 처리
      formKey.currentState!.save();

      var addLesson = Lesson(
        name: incomingLessonName,
        letterGrade: selectedValue,
        credit: selectedCredit,
      );

      DataHelper.addLesson(addLesson); // 아이템 추가
      DataHelper.calculateAverage; // 계산 처리

      // 출력해보기
      print(DataHelper.allAddedLessons);
      print(DataHelper.calculateAverage());

      // 리랜더링 트리거
      setState(() {});
    }
  }
}
