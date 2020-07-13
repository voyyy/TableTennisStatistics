import 'package:flutter/material.dart';
import 'package:table_tennis_statistics/style/Styles.dart';

class SetResult extends StatelessWidget {
  SetResult({@required this.voySet, @required this.dmnSet});

  final int voySet;
  final int dmnSet;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$voySet : $dmnSet',
        style: Styles.numbers,
      ),
    );
  }
}
