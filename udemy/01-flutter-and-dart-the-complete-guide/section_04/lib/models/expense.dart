import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

// 날짜 포맷터
final formatter = DateFormat.yMd();

// UUID
const uuid = Uuid();

// 카테고리 (Enum)
enum Category { food, travel, leisure, work }

// 아이콘 매핑 객체
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4(); // Initializer List. (uuid 생성 후, id 필드에 할당)

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category; // enum 적용

  // getter : 포맷팅된 날짜 가져오기
  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
    : expenses = allExpenses
          .where((expense) => expense.category == category)
          .toList();

  final Category category;
  final List<Expense> expenses;

  // getter : 지출 총합 가져오기
  double get totalExpenses {
    double sum = 0;

    // ^ for ... in 문
    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
