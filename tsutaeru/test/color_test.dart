import 'package:flutter/widgets.dart';
import 'package:tsutaeru/models/color.dart';

class ColorTestWidget extends StatefulWidget {
  const ColorTestWidget({Key? key}) : super(key: key);

  @override
  State<ColorTestWidget> createState() => _ColorTestState();
}

class _ColorTestState extends State<ColorTestWidget> {
  String _testString = "Loading...";

  @override
  void initState() {
    super.initState();
    setTestString();
  }

  Future setTestString() async {
    // create a record
    Color create = Color();
    create.backgroundColor = 12345;
    create.textColor = 54321;
    await create.create();

    // read above record by the id
    Color read = Color();
    await read.readById(create.id);
    setState(() {
      _testString = read.backgroundColor.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(_testString);
  }
}
