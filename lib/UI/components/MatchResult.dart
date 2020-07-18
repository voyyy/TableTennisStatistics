import 'package:flutter/material.dart';
import 'package:table_tennis_statistics/UI/style/Styles.dart';

class MatchResult extends StatelessWidget {
  MatchResult({@required this.voySets, @required this.dmnSets});

  final int voySets;
  final int dmnSets;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              'voy',
              style: Styles.voy,
            ),
            Text(
              '$voySets',
              style: Styles.biggerNumbers,
            )
          ],
        ),
        Container(
          margin: EdgeInsets.fromLTRB(10, 10, 4, 0),
          child: Text(
            ':',
            style: Styles.biggerNumbers,
          ),
        ),
        Column(
          children: <Widget>[
            Text(
              'dmn',
              style: Styles.dmn,
            ),
            Text(
              '$dmnSets',
              style: Styles.biggerNumbers,
            )
          ],
        )
      ],
    );
  }
}
