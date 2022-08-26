import 'package:flutter/material.dart';
import 'package:tsutaeru/models/phrase_group.dart';
import 'package:tsutaeru/values/strings.dart';

class AddGroup extends StatefulWidget {
  const AddGroup({Key? key}) : super(key: key);

  @override
  State<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  String _group = "";

  Future<void> _add() async {
    var tmp = PhraseGroup();
    tmp.name = _group;
    tmp.create();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.addGroup),
      ),
      body: Container(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            const Text(AppString.group),
            TextFormField(
              onChanged: (value) {
                _group = value;
              },
              enabled: true,
              decoration:
                  const InputDecoration(labelText: AppString.inputNewGroup),
            ),
            Padding(
                padding: const EdgeInsets.all(12),
                child: ElevatedButton(
                    onPressed: () {
                      _add();
                      Navigator.of(context).pop();
                    },
                    child: const Text(AppString.addGroup)))
          ],
        ),
      ),
    );
  }
}
