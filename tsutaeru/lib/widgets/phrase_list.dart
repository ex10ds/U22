// フレーズ一覧Widget

import 'package:flutter/material.dart';

class PhraseList extends StatefulWidget {
  final String groupName;
  const PhraseList({Key? key, required this.groupName}) : super(key: key);

  @override
  State<PhraseList> createState() => _PhraseListState();
}

class _PhraseListState extends State<PhraseList> {
  static const List<String> data = ["一覧こんなふう", "一覧こんなふう", "一覧こんなふう"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: ListView(children: [
        ListTile(
          leading: const Icon(Icons.place),
          title: Text(widget.groupName),
        ),
        ...data
            .map((String phrase) => ListTile(
                  title: Text(phrase),
                ))
            .toList()
      ])),
    );
  }
}
