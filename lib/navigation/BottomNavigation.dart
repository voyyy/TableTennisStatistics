import 'package:flutter/material.dart';
import 'package:table_tennis_statistics/navigation/MatchHistoryStack.dart';
import 'package:table_tennis_statistics/screens/AddMatch.dart';
import 'package:table_tennis_statistics/screens/MatchStatistics.dart';

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
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.add),
            title: new Text('Add Match'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.list),
            title: new Text('History'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.donut_small),
            title: Text('Statistics'),
          )
        ],
      ),
    );
  }
}
