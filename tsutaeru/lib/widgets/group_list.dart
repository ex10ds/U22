// グループ一覧表示Widget
import 'package:flutter/material.dart';
import 'package:tsutaeru/widgets/group_list_item.dart';

class GroupList extends StatefulWidget {
  const GroupList({Key? key}) : super(key: key);

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  List<String> places = ["コンビニ", "スーパー", "サイゼリヤ"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: GridView.count(
        crossAxisSpacing: 2,
        mainAxisSpacing: 8,
        crossAxisCount: 2,
        padding: const EdgeInsets.only(top: 40),
        children: places
            .map((String title) => GroupListItem(
                  title: title,
                ))
            .toList(),
      ),
    ));
  }
}
