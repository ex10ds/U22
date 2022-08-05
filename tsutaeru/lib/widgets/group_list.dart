// グループ一覧表示Widget
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsutaeru/widgets/group_list_item.dart';

class GroupList extends StatefulWidget {
  const GroupList({Key? key}) : super(key: key);

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  List<String> languages = ["Dart", "Java", "Ruby", "PHP"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      // body: GridView.count(
      //   primary: false,
      //   padding: EdgeInsets.all(20),
      //   crossAxisSpacing: 10,
      //   mainAxisSpacing: 10,
      //   crossAxisCount: 2,
      //   children: languages.map((String title) =>
      //     return _GroupItem(title);
      //   ).toList(),
      // ),
      body: GridView.count(
        crossAxisSpacing: 2,
        mainAxisSpacing: 8,
        crossAxisCount: 2,
        children: languages
            .map((String title) => GroupListItem(
                  title: title,
                ))
            .toList(),
      ),
    ));
  }

  // Widget _groupItem(String title) {
  //   return GestureDetector(
  //     onTap: () {
  //       // print('Button Click');
  //     },
  //     child: Container(
  //       height: 100.0,
  //       padding: const EdgeInsets.all(8.0),
  //       margin: const EdgeInsets.symmetric(horizontal: 8.0),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(5.0),
  //         color: Colors.lightGreen[500],
  //       ),
  //       child: Center(
  //         child: Text(title),
  //       ),
  //     ),
  //   );
  // }
}
