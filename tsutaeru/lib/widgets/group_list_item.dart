// グループリスト内一つずつのアイテムWidget
import 'package:flutter/material.dart';
import 'package:tsutaeru/widgets/phrase_list.dart';

class GroupListItem extends StatelessWidget {
  final String groupId, title;
  const GroupListItem({Key? key, required this.groupId, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PhraseList(groupId: groupId, groupName: title)));
      },
      child: Container(
        height: 50.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: const Color.fromARGB(255, 209, 255, 157),
        ),
        child: Center(
          child: Text(title),
        ),
      ),
    );
  }
}
