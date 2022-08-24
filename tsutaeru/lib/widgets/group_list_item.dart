// グループリスト内一つずつのアイテムWidget
import 'package:flutter/material.dart';
import 'package:tsutaeru/models/phrase_group.dart';
import 'package:tsutaeru/values/strings.dart';
import 'package:tsutaeru/widgets/phrase_list.dart';

class GroupListItem extends StatelessWidget {
  final String groupId, title;
  final Future<void> setGroups;

  const GroupListItem(
      {Key? key,
      required this.groupId,
      required this.title,
      required this.setGroups})
      : super(key: key);

  Future<void> deleteGroup() async {
    PhraseGroup group = PhraseGroup();
    group.id = groupId;
    await group.delete();
    // widget.setGroups;
  }

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
        alignment: Alignment.center,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: PopupMenuButton(
                  onSelected: (s) {
                    deleteGroup();
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                        PopupMenuItem(
                            value: groupId, child: const Text(delete)),
                      ]),
            ),
            Container(
              padding: const EdgeInsets.only(top: 35),
              child: (Text(title)),
            )
          ],
        ),
      ),
    );
  }
}

// class GroupListItem extends StatefulWidget {
//   final String groupId, title;
//   final Future<void> setGroups;

//   const GroupListItem(
//       {Key? key,
//       required this.groupId,
//       required this.title,
//       required this.setGroups})
//       : super(key: key);

//   @override
//   State<GroupListItem> createState() => _GroupListItemState();
// }

// class _GroupListItemState extends State<GroupListItem> {
//   Future<void> deleteGroup() async {
//     PhraseGroup group = PhraseGroup();
//     group.id = widget.groupId;
//     await group.delete();
//     // widget.setGroups;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => PhraseList(
//                     groupId: widget.groupId, groupName: widget.title)));
//       },
//       child: Container(
//         height: 50.0,
//         padding: const EdgeInsets.all(8.0),
//         margin: const EdgeInsets.symmetric(horizontal: 8.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5.0),
//           color: const Color.fromARGB(255, 209, 255, 157),
//         ),
//         alignment: Alignment.center,
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.topRight,
//               child: PopupMenuButton(
//                   onSelected: (s) {
//                     deleteGroup();
//                   },
//                   itemBuilder: (BuildContext context) => <PopupMenuEntry>[
//                         const PopupMenuItem(
//                             value: "delete", child: Text(delete)),
//                       ]),
//             ),
//             Container(
//               padding: const EdgeInsets.only(top: 35),
//               child: (Text(widget.title)),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
