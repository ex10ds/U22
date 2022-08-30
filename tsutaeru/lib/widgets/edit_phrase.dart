import 'package:flutter/material.dart';
import 'package:tsutaeru/models/phrase.dart';
import 'package:tsutaeru/values/strings.dart';

class EditPhrase extends StatefulWidget {
  final Phrase phrase;
  final Function() updatePhrases;

  const EditPhrase(
      {Key? key, required this.phrase, required this.updatePhrases})
      : super(key: key);

  @override
  State<EditPhrase> createState() => _EditPhraseState();
}

class _EditPhraseState extends State<EditPhrase> {
  String _phrase = "";

  Future<void> add() async {
    widget.phrase.text = _phrase;
    await widget.phrase.update();
    widget.updatePhrases();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.editPhrase),
      ),
      body: Container(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            TextFormField(
              initialValue: widget.phrase.text,
              onChanged: (value) {
                _phrase = value;
              },
              enabled: true,
              decoration:
                  const InputDecoration(labelText: AppString.inputNewPhrase),
            ),
            Padding(
                padding: const EdgeInsets.all(12),
                child: ElevatedButton(
                    onPressed: () {
                      add();
                      Navigator.of(context).pop();
                    },
                    child: const Text(AppString.savePhrase)))
          ],
        ),
      ),
    );
  }
}
