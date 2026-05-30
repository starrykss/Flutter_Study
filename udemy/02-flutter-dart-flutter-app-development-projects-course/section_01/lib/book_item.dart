import 'package:flutter/material.dart';

import 'package:section_01/book_detail.dart';
import 'package:section_01/model/book.dart';

class BookItem extends StatelessWidget {
  const BookItem({
    super.key,
    required this.listedBook,
  });

  final Book listedBook;

  @override
  Widget build(BuildContext context) {
    var myTextStyle = Theme.of(context).textTheme;

    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          // 아이템 클릭 처리
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => BookDetail(
            //       selectedBook: listedBook,
            //     ),
            //   ),
            // );

            // 리다이렉션
            Navigator.of(context).pushNamed(
              '/book_detail',
              arguments: listedBook,
            );
          },
          // 앞부분 이미지
          leading: Image.asset(
            'assets/images/' + listedBook.smallImage,
            width: 75,
            height: 75,
          ),
          title: Text(
            listedBook.bookName,
            style: myTextStyle.headlineSmall,
          ),
          subtitle: Text(
            listedBook.bookAuthor,
            style: myTextStyle.bodyMedium,
          ),
          trailing: Icon(
            Icons.arrow_forward,
            color: Colors.deepPurple,
            size: 35,
          ),
        ),
      ),
    );
  }
}
