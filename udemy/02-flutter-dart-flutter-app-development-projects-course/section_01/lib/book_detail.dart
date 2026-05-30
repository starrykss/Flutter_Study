import 'package:flutter/material.dart';
import 'package:palette_generator_master/palette_generator_master.dart';

import 'package:section_01/model/book.dart';

class BookDetail extends StatefulWidget {
  const BookDetail({super.key, required this.selectedBook});

  final Book selectedBook;

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  Color appBarColor = Colors.deepPurple;
  late PaletteGeneratorMaster generator; // 나중에 초기화

  @override
  void initState() {
    super.initState();

    // 앱바 색상 찾기
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => findAppBarColor(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            title: Text(
              widget.selectedBook.bookName +
                  ' ' +
                  widget.selectedBook.bookAuthor,
            ),
            backgroundColor: appBarColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/' + widget.selectedBook.bigImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Text(
                widget.selectedBook.bookDetail,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 앱바 색상 찾기 (비동기 처리)
  void findAppBarColor() async {
    generator = await PaletteGeneratorMaster.fromImageProvider(
      AssetImage('assets/images/' + widget.selectedBook.bigImage),
    );
    appBarColor = generator.dominantColor!.color;

    // 화면 다시 렌더링
    setState(() {});
  }
}
