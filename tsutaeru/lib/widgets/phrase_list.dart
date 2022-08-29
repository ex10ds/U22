// フレーズ一覧Widget

import 'package:flutter/material.dart';
import 'package:tsutaeru/models/phrase.dart';
import 'package:tsutaeru/models/phrase_belonging.dart';
import 'package:tsutaeru/models/phrase_group.dart';
import 'package:tsutaeru/values/strings.dart';
import 'package:tsutaeru/widgets/add_phrase.dart';
import 'package:tsutaeru/widgets/phrase_list_item.dart';

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
    // var phrases = await Phrase().readAll();
    setState(() {
      _phrases = tmp.phrases;
    });
  }

  Future<void> getPhrases() async {
    _setPhrases();
  }

  @override
  void initState() {
    super.initState();
    _setPhrases();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.groupName)),
      body: ListView(children: [
        ListTile(
          leading: const Icon(Icons.add),
          title: const Text(AppString.add),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPhrase(
                    groupId: widget.groupId,
                    groupName: widget.groupName,
                    setPhrases: getPhrases()),
              ),
            );
          },
        ),
        ..._phrases
            .map((Phrase phrase) => PhraseListItem(
                  phrase: phrase,
                  refetchPhrases: _setPhrases,
                ))
            .toList()
      ]),
    );
  }
}
