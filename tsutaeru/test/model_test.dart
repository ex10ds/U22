import 'package:flutter/material.dart';
import 'package:tsutaeru/init_process.dart';
import 'package:tsutaeru/models/color.dart';
import 'package:tsutaeru/models/phrase_group.dart';
import 'package:tsutaeru/models/phrase.dart';
import 'package:tsutaeru/models/phrase_belonging.dart';

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

    await initProcess();

    // sample data making
    Color color1 = Color();
    color1.textColor = 11111;
    color1.backgroundColor = 11111;
    await color1.create();

    Color color2 = Color();
    color2.textColor = 22222;
    color2.backgroundColor = 22222;
    await color2.create();

    PhraseGroup phraseGroup1 = PhraseGroup();
    phraseGroup1.name = "group1";
    phraseGroup1.create();

    PhraseGroup phraseGroup2 = PhraseGroup();
    phraseGroup2.name = "group2";
    phraseGroup2.create();

    Phrase phrase1 = Phrase();
    phrase1.text = "phrase1";
    phrase1.color = color1;
    await phrase1.create();

    Phrase phrase2 = Phrase();
    phrase2.text = "phrase2";
    phrase2.color = color2;
    phrase2.create();

    PhraseBelonging()
        .create(phraseGroupId: phraseGroup1.id, phraseId: phrase1.id);
    PhraseBelonging()
        .create(phraseGroupId: phraseGroup2.id, phraseId: phrase2.id);

    // reading
    List<Color> readAllColors = await Color().readAll();
    List<Phrase> readAllPhrases = await Phrase().readAll();
    List<PhraseGroup> readAllPhraseGroups = await PhraseGroup().readAll();

    _testString = "";
    for (var v in readAllColors) {
      _testString +=
          "id : ${v.id}\ntxt : ${v.textColor.toString()}\nbg : ${v.backgroundColor.toString()}\n";
    }

    for (var v in readAllPhrases) {
      _testString += "id: ${v.id}\nname: ${v.text}\ncolor: ${v.color.id}\n";
    }

    for (var v in readAllPhraseGroups) {
      _testString += "id: ${v.name}\n";
      for (var w in v.phrases) {
        _testString += "    ${w.id}\n";
      }
    }

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
