import 'package:flutter/material.dart';
import 'package:table_tennis_statistics/style/Styles.dart';

class MatchItem extends StatelessWidget {
  MatchItem(
      {@required this.date,
      @required this.matchResult,
      @required this.color,
      @required this.onTap});

  final String date;
  final matchResult;
  final color;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        alignment: AlignmentDirectional(0.0, 0.0),
        height: 80,
        color: this.color,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('$matchResult', style: Styles.matchItem),
            Text('$date', style: Styles.matchItem),
          ],
        ),
      ),
    );
  }
}
