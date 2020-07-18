import 'package:flutter/material.dart';
import 'package:table_tennis_statistics/UI/screens/MatchHistory.dart';
import 'package:table_tennis_statistics/UI/screens/MatchDetails.dart';

class MatchHistoryStack extends StatefulWidget {
  @override
  _MatchHistoryStackState createState() => _MatchHistoryStackState();
}

class _MatchHistoryStackState extends State<MatchHistoryStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          // ignore: missing_return
          builder: (BuildContext context) {
            switch (settings.name) {
              case '/':
                return MatchHistory();
              case '/matchDetails':
                return MatchDetails();
            }
          },
        );
      },
    );
  }
}
