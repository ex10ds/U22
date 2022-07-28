import 'package:flutter_test/flutter_test.dart';
import 'package:tsutaeru/models/color.dart';

void main() {
  test("DatabaseHelper test", () {
    List<Map<String, dynamic>> pattern = [
      {"id": "", "text_color": 0, "background_color": 0},
      {"id": "", "text_color": 0},
      {"id": "", "text_color": 0, "background_color": 0, "any_color": ""},
    ];
    Color color = Color();

    expect(color.testAllMapKey(pattern[0]), true);
    expect(color.testAllMapKey(pattern[1]), false);
    expect(color.testAllMapKey(pattern[2]), false);

    expect(color.testSomeMapKey(pattern[0]), true);
    expect(color.testSomeMapKey(pattern[1]), true);
    expect(color.testSomeMapKey(pattern[2]), false);
  });
}
