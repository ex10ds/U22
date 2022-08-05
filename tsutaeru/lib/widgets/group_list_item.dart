// グループリスト内一つずつのアイテムWidget
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class GroupListItem extends StatefulWidget {
//   const GroupListItem(language, {Key? key}) : super(key: key);

//   @override
//   State<GroupListItem> createState() => _GroupListItemState();
// }

// class _GroupListItemState extends State<GroupListItem> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // print('Button Click');
//       },
//       child: Container(
//         height: 50.0,
//         padding: const EdgeInsets.all(8.0),
//         margin: const EdgeInsets.symmetric(horizontal: 8.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5.0),
//           color: Colors.lightGreen[500],
//         ),
//         child: const Center(
//           child: Text('Engage'),
//         ),
//       ),
//     );
//   }
// }

class GroupListItem extends StatelessWidget {
  final String title;
  const GroupListItem({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print('Button Click');
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
