import 'package:flutter/material.dart';
import 'package:tsutaeru/models/phrase.dart';
import 'package:tsutaeru/values/strings.dart';
import 'package:tsutaeru/widgets/phrase_list_item.dart';

class AllPhrase extends StatefulWidget {
  const AllPhrase({super.key});

  @override
  State<AllPhrase> createState() => _AllPhraseState();
}

class _AllPhraseState extends State<AllPhrase> {
  List<Phrase> _phrases = [];

  Future<void> setPhrases() async {
    var tmp = await Phrase().readAll();
    setState(() {
      _phrases = tmp;
    });
  }

  @override
  void initState() {
    super.initState();
    setPhrases();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text(AppString.allPhrases)),
        body: ListView(children: [
          ..._phrases
              .map((e) => PhraseListItem(phrase: e, refetchPhrases: setPhrases))
        ]));
  }
}
