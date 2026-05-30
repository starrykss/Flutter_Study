import 'package:flutter/material.dart';

import 'package:section_01/book_item.dart';
import 'package:section_01/data/listData.dart';
import 'package:section_01/model/book.dart';

class BookList extends StatelessWidget {
  BookList() {
    allBooks = preparedData();
  }

  late List<Book> allBooks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book List"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: allBooks.length,
          itemBuilder: (context, index) {
            return BookItem(listedBook: allBooks[index]);
          },
        ),
      ),
    );
  }

  List<Book> preparedData() {
    List<Book> tentativeList = [];

    for (int i = 0; i < 10; i++) {
      var bookName = Strings.Books_Name[i];
      var bookAuthor = Strings.Books_Authors[i];
      var bookDetail = Strings.Books_Detail[i];
      var smallImage = Strings.Small_Images[i];
      var bigImage = Strings.Big_Images[i];

      Book addBook = Book(
        bookName,
        bookAuthor,
        bookDetail,
        smallImage,
        bigImage,
      );

      tentativeList.add(addBook);
    }
    return tentativeList;
  }
}
