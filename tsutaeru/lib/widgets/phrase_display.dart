// フレーズ表示用Widget
// import 'dart:html';

// import 'package:flutter/material.dart';

// class PhraseDisplay extends StatelessWidget{
//   const PhraseDisplay({Key? key}) : super(key: key);

//   @override
// }s

import 'dart:math';

import 'package:flutter/material.dart';

class PhraseDisplay extends StatelessWidget {
  String displayText;

  PhraseDisplay({super.key, required this.displayText});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          // GestureDetector(
          //   onTap: () => {Navigator.of(context).pop()},
          //   child: Container(
          //     alignment: Alignment.centerRight,
          //     width: 20,
          //     height: 300,
          //     color: Colors.indigo,
          //   ),
          // ),
          GestureDetector(
              onTap: () => {Navigator.of(context).pop},
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
                  displayText,
                  style: TextStyle(
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
