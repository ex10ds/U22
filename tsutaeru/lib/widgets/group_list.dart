// グループ一覧表示Widget
import 'package:flutter/material.dart';
import 'package:tsutaeru/models/phrase_group.dart';
import 'package:tsutaeru/values/strings.dart';
import 'package:tsutaeru/widgets/add_group_button.dart';
import 'package:tsutaeru/widgets/all_phrase.dart';
import 'package:tsutaeru/widgets/group_list_item.dart';
import 'package:tsutaeru/widgets/setting_screen.dart';

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

  Future<void> deleteGroup() async {
    setGroups();
  }

  @override
  void initState() {
    super.initState();
    setGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.appName),
        centerTitle: true,
        elevation: 1,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingScreen()));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: GridView.count(
          // crossAxisSpacing: 2,
          mainAxisSpacing: 6,
          crossAxisCount: 2,
          padding: const EdgeInsets.only(top: 20),
          children: [
            AddGroupButton(setGroups: setGroups()),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AllPhrase()));
              },
              child: Container(
                height: 50.0,
                // padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.symmetric(horizontal: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: const Color.fromARGB(255, 144, 242, 255),
                ),
                child: const Center(
                  child: Text(AppString.allPhrases),
                ),
              ),
            ),
            ..._groups
                .asMap()
                .entries
                .map((entry) => GroupListItem(
                      groupId: entry.value.id,
                      title: entry.value.name,
                      setGroups: setGroups(),
                    ))
                .toList(),
          ]),
    );
  }
}
