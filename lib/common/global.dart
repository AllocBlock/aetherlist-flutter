import 'package:flutter/material.dart';

const _themes = <MaterialColor>[
  Colors.purple,
  Colors.amber,
  Colors.cyan,
  Colors.teal,
  Colors.grey,
];

class Global {
  static List<MaterialColor> get themes => _themes;
  static Future init() async {
    // TODO: add shared_preferences to handle user profile
  }
}
