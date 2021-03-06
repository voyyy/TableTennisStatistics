import 'package:flutter/material.dart';
import 'package:table_tennis_statistics/UI/navigation/MatchHistoryStack.dart';
import 'package:table_tennis_statistics/UI/screens/AddMatch.dart';
import 'package:table_tennis_statistics/UI/screens/MatchStatistics.dart';
import 'package:table_tennis_statistics/UI/style/Styles.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({Key key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    AddMatch(),
    MatchHistoryStack(),
    MatchStatistics()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(
          size: 28,
        ),
        selectedItemColor: Styles.primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text('Dodaj mecz'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Historia'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.donut_small),
            title: Text('Statystyki'),
          )
        ],
      ),
    );
  }
}
