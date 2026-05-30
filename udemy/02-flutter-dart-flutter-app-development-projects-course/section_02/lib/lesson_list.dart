import 'package:flutter/material.dart';

import 'package:section_02/constants.dart';
import 'package:section_02/data.dart';
import 'package:section_02/model/lesson.dart';

class LessonList extends StatelessWidget {
  const LessonList({super.key, required this.onDismissed});

  final Function onDismissed; // 아이템 삭제 처리

  @override
  Widget build(BuildContext context) {
    List<Lesson> allLessons = DataHelper.allAddedLessons;

    return allLessons.length > 0
        ? ListView.builder(
            itemCount: allLessons.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (value) {
                  onDismissed(index);
                },
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Card(
                    child: ListTile(
                      title: Text(allLessons[index].name),
                      leading: CircleAvatar(
                        child: Text(
                          DataHelper.calculateAverage().toStringAsFixed(2),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: Constants.mainColor,
                      ),
                      subtitle: Text(
                        'Grade Value: ${allLessons[index].letterGrade}, Credit Value: ${allLessons[index].credit}',
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : Container(
            child: Center(
              child: Text(
                "Please Enter a Lesson",
                style: Constants.textStyle,
              ),
            ),
          );
    ;
  }
}

// class LessonList extends StatefulWidget {
//   const LessonList({super.key});

//   @override
//   State<LessonList> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<LessonList> {
//   @override
//   Widget build(BuildContext context) {
//     List<Lesson> allLessons = DataHelper.allAddedLessons;

//     return allLessons.length > 0
//         ? ListView.builder(
//             itemCount: allLessons.length,
//             itemBuilder: (context, index) {
//               return Dismissible(
//                 key: UniqueKey(),
//                 direction: DismissDirection.endToStart,
//                 onDismissed: (value) {
//                   DataHelper.allAddedLessons.removeAt(index);

//                   // 리렌더링
//                   setState(() {});
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(3.0),
//                   child: Card(
//                     child: ListTile(
//                       title: Text(allLessons[index].name),
//                       leading: CircleAvatar(
//                         child: Text(
//                           DataHelper.calculateAverage().toStringAsFixed(2),
//                         ),
//                         foregroundColor: Colors.white,
//                         backgroundColor: Constants.mainColor,
//                       ),
//                       subtitle: Text(
//                         'Grade Value: ${allLessons[index].letterGrade}, Credit Value: ${allLessons[index].credit}',
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           )
//         : Container(
//             child: Center(
//               child: Text(
//                 "Please Enter a Lesson",
//                 style: Constants.textStyle,
//               ),
//             ),
//           );
//     ;
//   }
// }
