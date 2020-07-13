import 'package:flutter/material.dart';

class MatchStatistics extends StatefulWidget {
  MatchStatistics({Key key}) : super(key: key);

  @override
  _MatchStatisticsState createState() => _MatchStatisticsState();
}

class _MatchStatisticsState extends State<MatchStatistics> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statystyki meczów'),
      ),
      body: Center(
        child: Text('data'),
      ),
    );
  }
}
