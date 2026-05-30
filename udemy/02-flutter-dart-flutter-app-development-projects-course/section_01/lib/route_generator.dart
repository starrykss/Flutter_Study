import 'package:flutter/material.dart';

import 'package:section_01/model/book.dart';
import 'package:section_01/book_list.dart';
import 'package:section_01/book_detail.dart';

class RouteGenerator {
  static Route<dynamic> routeGenerator(RouteSettings settings) {
    switch (settings.name) {
      // 홈 화면
      case ('/'):
        return MaterialPageRoute(
          builder: (context) => BookList(),
        );

      // 아이템 상세 화면
      case ('/book_detail'):
        final selectedBook = settings.arguments as Book;

        return MaterialPageRoute(
          builder: (context) => BookDetail(
            selectedBook: selectedBook,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => BookList(),
        );
    }
  }
}
