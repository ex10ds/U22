// グループリスト内一つずつのアイテムWidget
import 'package:flutter/material.dart';
import 'package:tsutaeru/models/phrase_group.dart';
import 'package:tsutaeru/values/strings.dart';
import 'package:tsutaeru/widgets/add_group.dart';
import 'package:tsutaeru/widgets/phrase_list.dart';

class AddGroupButton extends StatefulWidget {
  const AddGroupButton({Key? key}) : super(key: key);

  @override
  State<AddGroupButton> createState() => _AddGroupButtonState();
}

class _AddGroupButtonState extends State<AddGroupButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddGroup()));
        },
        child: Container(
          height: 50.0,
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.symmetric(horizontal: 6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: const Color.fromARGB(255, 209, 209, 220),
          ),
          child: const Center(
            child: Icon(Icons.add),
          ),
        ));
  }
}
