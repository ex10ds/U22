// フレーズ一覧内アイテムWidget
import 'package:flutter/material.dart';
import 'package:tsutaeru/models/phrase.dart';
import 'package:tsutaeru/values/strings.dart';
import 'package:tsutaeru/widgets/edit_phrase.dart';
import 'package:tsutaeru/widgets/phrase_display.dart';

class PhraseListItem extends StatelessWidget {
  final Phrase phrase;
  final Function refetchPhrases;
  // final Future<void> setGroups;

  const PhraseListItem(
      {Key? key, required this.phrase, required this.refetchPhrases})
      : super(key: key);

  void jumpToEditPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditPhrase(phrase: phrase),
        ));
  }

  Future<void> delete() async {
    await phrase.delete();
    refetchPhrases();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PhraseDisplay(displayText: phrase.text)));
      },
      title: Text(phrase.text),
      trailing: PopupMenuButton(
          onSelected: (value) async {
            if (value == "edit") {
              jumpToEditPage(context);
              return;
            }
            if (value == "delete") {
              delete();
              return;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                const PopupMenuItem(value: "edit", child: Text(AppString.edit)),
                const PopupMenuItem(
                    value: "delete", child: Text(AppString.delete)),
              ]),
    );
  }
}
