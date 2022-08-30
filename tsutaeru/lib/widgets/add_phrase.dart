import 'package:flutter/material.dart';
import 'package:tsutaeru/models/color.dart';
import 'package:tsutaeru/models/phrase.dart';
import 'package:tsutaeru/models/phrase_belonging.dart';
import 'package:tsutaeru/values/strings.dart';

// class AddPhrase extends StatelessWidget {
//   final String groupName, groupId;
//   const AddPhrase({Key? key, required this.groupId, required this.groupName})
//       : super(key: key);

//   Future<void> add(String phrase) async {
//     var tmp = Phrase();
//     tmp.text = phrase;
//   }

//   String phrase;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(groupName),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(50),
//         child: Column(
//           children: [
//             const Text(AppString.phrase),
//             TextFormField(
//               enabled: true,
//               decoration:
//                   const InputDecoration(labelText: AppString.inputNewPhrase),
//             ),
//             Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: ElevatedButton(
//                     onPressed: () {}, child: const Text(AppString.addPhrase)))
//           ],
//         ),
//       ),
//     );
//   }
// }
class AddPhrase extends StatefulWidget {
  final String groupName, groupId;
  final Function() setPhrases;

  const AddPhrase(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.setPhrases})
      : super(key: key);

  @override
  State<AddPhrase> createState() => _AddPhraseState();
}

class _AddPhraseState extends State<AddPhrase> {
  String _phrase = "";

  Future<void> add() async {
    var colors = await Color().readAll();
    if (_phrase != "") {
      var tmp = Phrase();
      tmp.text = _phrase;
      tmp.color = colors.first;
      await tmp.create();
      PhraseBelonging().create(phraseGroupId: widget.groupId, phraseId: tmp.id);
    }
    widget.setPhrases();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName),
      ),
      body: Container(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            const Text(AppString.phrase),
            TextFormField(
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
                    child: const Text(AppString.addPhrase)))
          ],
        ),
      ),
    );
  }
}
