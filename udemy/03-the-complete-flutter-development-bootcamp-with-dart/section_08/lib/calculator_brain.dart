import 'dart:math';

class CalculatorBrain {
  CalculatorBrain({
    required this.height,
    required this.weight,
  });

  final int height;
  final int weight;
  late double _bmi;

  // BMI 계산
  String calculateBMI() {
    // cm -> m 변환
    final double heightInMeters = height / 100;

    _bmi = weight / pow(heightInMeters, 2);

    return _bmi.toStringAsFixed(1); // 소수점 첫째자리까지
  }

  // 결과 가져오기
  String getResult() {
    if (_bmi >= 25) {
      return 'Overweight';
    } else if (_bmi > 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  // 해석값 가져오기
  String getInterpretation() {
    if (_bmi >= 25) {
      return 'You have a higher than normal body weight. Try to exercise more.';
    } else if (_bmi > 18.5) {
      return 'You have a normal body weight. Good job!';
    } else {
      return 'You have a lower than normal body weight. You can eat a bit more.';
    }
  }
}
