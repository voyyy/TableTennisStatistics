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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment(0.8, 0.2),
              child: Text('$date', style: Styles.matchItem),
            ),
            Align(
              alignment: Alignment(-0.6, 0.8),
              child: Text('$matchResult', style: Styles.matchItem),
            ),
          ],
        ),
      ),
    );
  }
}
