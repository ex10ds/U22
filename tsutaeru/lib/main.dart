import 'package:flutter/material.dart';
import 'package:tsutaeru/model_test.dart';
import 'package:tsutaeru/init_process.dart';

void main() {
  initProcess();
  runApp(const ModelJointTestWidget());
}

var sql = """
CREATE TABLE words(
  id TEXT NOT NULL,
  color_id TEXT NOT NULL,
  text TEXT NOT NULL,
  FOREIGN KEY (color_id) REFERENCES colors (id),
  PRIMARY KEY (id)
);
""";
