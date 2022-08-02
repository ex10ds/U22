import 'package:flutter/material.dart';
import 'package:tsutaeru/models/color.dart';
import 'package:tsutaeru/models/word_belonging.dart';
import 'package:tsutaeru/models/word_group.dart';
import 'package:tsutaeru/models/word.dart';

class ModelJointTestWidget extends StatelessWidget {
  const ModelJointTestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Model Joint Test",
        theme: ThemeData(primarySwatch: Colors.orange),
        home: const ModelJointTest());
  }
}

class ModelJointTest extends StatefulWidget {
  const ModelJointTest({Key? key}) : super(key: key);

  @override
  State<ModelJointTest> createState() => _ModelJointTestState();
}

class _ModelJointTestState extends State<ModelJointTest> {
  String _testString = "Loading...";

  @override
  void initState() {
    super.initState();
    run();
  }

  Future run() async {
    String text = "";

    // sample data making
    Color color1 = Color();
    color1.textColor = 11111;
    color1.backgroundColor = 11111;
    await color1.create();

    Color color2 = Color();
    color2.textColor = 22222;
    color2.backgroundColor = 22222;
    await color2.create();

    Word word1 = Word();
    word1.text = "word1";
    word1.color = color1;
    await word1.create();

    // Word word2 = Word();
    // word2.text = "word2";
    // word2.color = color2;
    // word2.create();

    // WordGroup wordGroup1 = WordGroup();
    // wordGroup1.name = "group1";
    // wordGroup1.create();

    // WordGroup wordGroup2 = WordGroup();
    // wordGroup2.name = "group2";
    // wordGroup2.create();

    // WordBelonging().create(wordGroupId: wordGroup1.id, wordId: word1.id);
    // WordBelonging().create(wordGroupId: wordGroup2.id, wordId: word2.id);

    // // reading
    // List<Color> readAllColors = await Color().readAll();
    // List<Word> readAllWords = await Word().readAll();
    // List<WordGroup> readAllWordGroups = await WordGroup().readAll();

    // _testString = "";
    // for (var v in readAllColors) {
    //   _testString +=
    //       "id : ${v.id}\ntxt : ${v.textColor.toString()}\nbg : ${v.backgroundColor.toString()}\n";
    // }

    setState(() {
      _testString += text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TEST"),
      ),
      body: Text(_testString),
    );
  }
}
