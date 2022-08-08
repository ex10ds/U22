// グループ一覧表示Widget
import 'package:flutter/material.dart';
import 'package:tsutaeru/models/phrase_group.dart';
import 'package:tsutaeru/widgets/group_list_item.dart';

class GroupList extends StatefulWidget {
  const GroupList({Key? key}) : super(key: key);

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  List<PhraseGroup> _groups = [];

  Future<void> setGroups() async {
    var tmp = await PhraseGroup().readAll();
    setState(() {
      _groups = tmp;
    });
  }

  @override
  void initState() {
    super.initState();
    setGroups();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: GridView.count(
        crossAxisSpacing: 2,
        mainAxisSpacing: 8,
        crossAxisCount: 2,
        padding: const EdgeInsets.only(top: 40),
        children: _groups
            .map((PhraseGroup group) => GroupListItem(
                  groupId: group.id,
                  title: group.name,
                ))
            .toList(),
      ),
    ));
  }
}
