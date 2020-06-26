import 'package:flutter/material.dart';
import 'package:table_tennis_statistics/screens/AddMatch.dart';
//import 'screens/AddMatch.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'navigation';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: _title, home: AddMatch());
  }
}
