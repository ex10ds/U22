// フレーズ一覧Widget

import 'package:flutter/material.dart';
import 'package:tsutaeru/models/phrase.dart';
import 'package:tsutaeru/models/phrase_group.dart';

class PhraseList extends StatefulWidget {
  final String groupName, groupId;
  const PhraseList({Key? key, required this.groupId, required this.groupName})
      : super(key: key);

  @override
  State<PhraseList> createState() => _PhraseListState();
}

class _PhraseListState extends State<PhraseList> {
  List<Phrase> _phrases = [];

  Future<void> _setPhrases() async {
    var tmp = PhraseGroup();
    await tmp.readById(widget.groupId);
    setState(() {
      _phrases = tmp.phrases;
    });
  }

  @override
  void initState() {
    super.initState();
    _setPhrases();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: ListView(children: [
        ListTile(
          leading: const Icon(Icons.place),
          title: Text(widget.groupName),
        ),
        ..._phrases
            .map((Phrase phrase) => ListTile(title: Text(phrase.text)))
            .toList()
      ])),
    );
  }
}
