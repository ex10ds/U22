import 'package:flutter/material.dart';
import 'package:tsutaeru/values/strings.dart';

class AddPhrase extends StatelessWidget {
  final String groupName, groupId;
  const AddPhrase({Key? key, required this.groupId, required this.groupName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(groupName),
      ),
      body: Container(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            const Text(AppString.phrase),
            TextFormField(
              enabled: true,
              decoration:
                  const InputDecoration(labelText: AppString.inputNewPhrase),
            ),
            Padding(
                padding: const EdgeInsets.all(12),
                child: ElevatedButton(
                    onPressed: () {}, child: const Text(AppString.addPhrase)))
          ],
        ),
      ),
    );
  }
}
