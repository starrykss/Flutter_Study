class Lesson {
  final String name;
  final double letterGrade;
  final double credit;

  Lesson({
    required this.name,
    required this.letterGrade,
    required this.credit,
  });

  // print 문 출력 형식 설정
  @override
  String toString() {
    return '$name $letterGrade $credit';
  }
}
