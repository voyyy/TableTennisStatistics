import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_tennis_statistics/UI/navigation/BottomNavigation.dart';
import 'package:table_tennis_statistics/core/view/CRUDModel.dart';
import 'package:table_tennis_statistics/locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'navigation';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => locator<CRUDModel>(),
        ),
      ],
      child: MaterialApp(title: _title, home: BottomNavigation()),
    );
  }
}
