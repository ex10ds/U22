// グループリスト内一つずつのアイテムWidget
import 'package:flutter/material.dart';
import 'package:tsutaeru/widgets/add_group.dart';

class AddGroupButton extends StatefulWidget {
  final Future<void> setGroups;
  const AddGroupButton({Key? key, required this.setGroups}) : super(key: key);

  @override
  State<AddGroupButton> createState() => _AddGroupButtonState();
}

class _AddGroupButtonState extends State<AddGroupButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddGroup(
                    setGroups: widget.setGroups,
                  )));
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
