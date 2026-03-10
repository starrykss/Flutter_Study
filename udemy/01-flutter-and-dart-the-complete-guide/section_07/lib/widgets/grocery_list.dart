import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:section_07/data/categories.dart';
import 'package:section_07/models/grocery_item.dart';
import 'package:section_07/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() {
    return _GroceryListState();
  }
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();

    // 서버에서 데이터 불러오기 (GET)
    _loadItems();
    _isLoading = false;
  }

  // 데이터 불러오기 (GET)
  void _loadItems() async {
    final url = Uri.https(
      'flutter-study-random-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );

    try {
      final response = await http.get(url);

      // 오류 처리
      if (response.statusCode >= 400) {
        setState(() {
          _error = "Failed to fetch data. Please try again later.";
        });
      }

      // ! null을 문자열로 처리 (Firebase에서 String 반환)
      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> listData = json.decode(
        response.body,
      );
      final List<GroceryItem> loadedItems = [];

      for (final item in listData.entries) {
        // 일치하는 첫 번째 아이템 가져오기
        final category = categories.entries
            .firstWhere(
              (catItem) => catItem.value.title == item.value['category'],
            )
            .value;

        loadedItems.add(
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category,
          ),
        );
      }

      setState(() {
        _groceryItems = loadedItems;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _error = "Something went wrong. Please try again later.";
      });
    }
  }

  // 아이템 추가 기능
  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }

    // 상태 변수 변경
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  // 아이텍 삭제 처리
  void _removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);

    // (1) 로컬에서 지우기
    setState(() {
      _groceryItems.remove(item);
    });

    final url = Uri.https(
      'flutter-study-random-default-rtdb.firebaseio.com',
      'shopping-list/${item.id}.json',
    );

    // (2) 서버에서 지우기
    // -> await을 안 붙일 경우, 백그라운드에서 처리
    final response = await http.delete(url);

    // 삭제 작업이 실패했을 경우, 원상 복구
    if (response.statusCode >= 400) {
      // Optional: Show error message
      setState(() {
        _groceryItems.insert(index, item); // 원상 복구
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No items added yet.'),
    );

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    }

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        // 성능 최적화를 위해 builder 방식으로
        itemCount: _groceryItems.length, // 아이템 수
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) {
            _removeItem(_groceryItems[index]);
          },
          key: ValueKey(_groceryItems[index].id),
          child: ListTile(
            title: Text(_groceryItems[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(
              _groceryItems[index].quantity.toString(),
            ),
          ),
        ),
      );
    }

    // 오류가 발생할 경우, 오류 메시지 표시
    if (_error != null) {
      content = Center(child: Text(_error!));
    }

    return Scaffold(
      // [1] AppBar
      appBar: AppBar(
        title: const Text("Your Groceries"),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),

      // [2] Body
      body: content,
    );
  }
}


// ?
// ? FutureBuilder 사용 버전
// ? -> 데이터 업데이트 후, UI 자동 반영 되지 않음.
// ? 


// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'package:section_07/data/categories.dart';
// import 'package:section_07/models/grocery_item.dart';
// import 'package:section_07/widgets/new_item.dart';

// class GroceryList extends StatefulWidget {
//   const GroceryList({super.key});

//   @override
//   State<GroceryList> createState() {
//     return _GroceryListState();
//   }
// }

// class _GroceryListState extends State<GroceryList> {
//   List<GroceryItem> _groceryItems = [];
//   late Future<List<GroceryItem>> _loadedItems; // late 키워드
//   String? _error;

//   @override
//   void initState() {
//     super.initState();

//     // 서버에서 데이터 가져오기 (GET)
//     _loadedItems = _loadItems();
//   }

//   // 데이터 불러오기 (GET)
//   Future<List<GroceryItem>> _loadItems() async {
//     final url = Uri.https(
//       'flutter-study-random-default-rtdb.firebaseio.com',
//       'shopping-list.json',
//     );

//     final response = await http.get(url);

//     // 오류 처리
//     if (response.statusCode >= 400) {
//       // setState(() {
//       //   _error = "Failed to fetch data. Please try again later.";
//       // });

//       // 오류 발생시키기
//       throw Exception('Failed to fetch grocery items. Please try again later.');
//     }

//     // ! null을 문자열로 처리 (Firebase에서 String 반환)
//     if (response.body == 'null') {
//       return [];
//     }

//     final Map<String, dynamic> listData = json.decode(
//       response.body,
//     );
//     final List<GroceryItem> loadedItems = [];

//     for (final item in listData.entries) {
//       // 일치하는 첫 번째 아이템 가져오기
//       final category = categories.entries
//           .firstWhere(
//             (catItem) => catItem.value.title == item.value['category'],
//           )
//           .value;

//       loadedItems.add(
//         GroceryItem(
//           id: item.key,
//           name: item.value['name'],
//           quantity: item.value['quantity'],
//           category: category,
//         ),
//       );
//     }

//     return loadedItems;
//   }

//   // 아이템 추가 기능
//   void _addItem() async {
//     final newItem = await Navigator.of(context).push<GroceryItem>(
//       MaterialPageRoute(
//         builder: (ctx) => const NewItem(),
//       ),
//     );

//     if (newItem == null) {
//       return;
//     }

//     // 상태 변수 변경
//     setState(() {
//       _groceryItems.add(newItem);
//     });
//   }

//   // 아이텍 삭제 처리
//   void _removeItem(GroceryItem item) async {
//     final index = _groceryItems.indexOf(item);

//     // (1) 로컬에서 지우기
//     setState(() {
//       _groceryItems.remove(item);
//     });

//     final url = Uri.https(
//       'flutter-study-random-default-rtdb.firebaseio.com',
//       'shopping-list/${item.id}.json',
//     );

//     // (2) 서버에서 지우기
//     // -> await을 안 붙일 경우, 백그라운드에서 처리
//     final response = await http.delete(url);

//     // 삭제 작업이 실패했을 경우, 원상 복구
//     if (response.statusCode >= 400) {
//       // Optional: Show error message
//       setState(() {
//         _groceryItems.insert(index, item); // 원상 복구
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // [1] AppBar
//       appBar: AppBar(
//         title: const Text("Your Groceries"),
//         actions: [
//           IconButton(
//             onPressed: _addItem,
//             icon: const Icon(Icons.add),
//           ),
//         ],
//       ),

//       // [2] Body
//       body: FutureBuilder(
//         future: _loadedItems,
//         builder: (context, snapshot) {
//           // 로딩 상태 처리
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           // 오류 처리
//           if (snapshot.hasError) {
//             return Center(
//               child: Text(
//                 snapshot.error.toString(),
//               ),
//             );
//           }

//           // 데이터가 비어있을 경우 처리
//           if (snapshot.data!.isEmpty) {
//             return const Center(
//               child: Text('No items added yet.'),
//             );
//           }

//           // 정상 데이터 출력
//           return ListView.builder(
//             // 성능 최적화를 위해 builder 방식으로
//             itemCount: snapshot.data!.length, // 아이템 수
//             itemBuilder: (ctx, index) => Dismissible(
//               onDismissed: (direction) {
//                 _removeItem(snapshot.data![index]);
//               },
//               key: ValueKey(snapshot.data![index].id),
//               child: ListTile(
//                 title: Text(snapshot.data![index].name),
//                 leading: Container(
//                   width: 24,
//                   height: 24,
//                   color: snapshot.data![index].category.color,
//                 ),
//                 trailing: Text(
//                   snapshot.data![index].quantity.toString(),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

