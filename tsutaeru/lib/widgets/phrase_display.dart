// フレーズ表示用Widget
// import 'dart:html';

// import 'package:flutter/material.dart';

// class PhraseDisplay extends StatelessWidget{
//   const PhraseDisplay({Key? key}) : super(key: key);

//   @override
// }s

import 'dart:math';

import 'package:flutter/material.dart';

// class PhraseDisplay extends StatelessWidget {
//   String displayText;

//   PhraseDisplay({super.key, required this.displayText});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.white,
//         body: Stack(children: [
//           GestureDetector(
//               onTap: () => {Navigator.of(context).pop(context)},
//               child: Align(
//                 alignment: Alignment.centerRight,
//                 child: Container(
//                   height: double.infinity,
//                   width: 20,
//                   color: Colors.indigo,
//                 ),
//               )),
//           Center(
//             child: Transform.rotate(
//               angle: 90 * pi / 180,
//               child: Container(
//                 color: Colors.white,
//                 child: Text(
//                   displayText,
//                   style: const TextStyle(
//                     fontSize: 50,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }

class PhraseDisplay extends StatefulWidget {
  final String displayText;
  const PhraseDisplay({Key? key, required this.displayText}) : super(key: key);

  @override
  State<PhraseDisplay> createState() => _PhraseDisplayState();
}

class _PhraseDisplayState extends State<PhraseDisplay> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          GestureDetector(
              onTap: () => {Navigator.of(context).pop(context)},
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: double.infinity,
                  width: 20,
                  color: Colors.indigo,
                ),
              )),
          Center(
            child: Transform.rotate(
              angle: 90 * pi / 180,
              child: Container(
                color: Colors.white,
                child: Text(
                  widget.displayText,
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
