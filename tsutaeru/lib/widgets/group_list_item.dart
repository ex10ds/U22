// グループリスト内一つずつのアイテムWidget
import 'package:flutter/material.dart';
import 'package:tsutaeru/widgets/phrase_list.dart';

class GroupListItem extends StatelessWidget {
  final String title;
  const GroupListItem({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PhraseList(groupName: title)));
      },
      child: Container(
        height: 50.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.lightGreen[500],
        ),
        child: Center(
          child: Text(title),
        ),
      ),
    );
  }
}
