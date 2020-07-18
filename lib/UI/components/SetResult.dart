import 'package:flutter/material.dart';
import 'package:table_tennis_statistics/UI/style/Styles.dart';

class SetResult extends StatelessWidget {
  SetResult({@required this.voySet, @required this.dmnSet});

  final int voySet;
  final int dmnSet;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 10,
                child: Text(
                  '$voySet',
                  style: Styles.numbers,
                ),
              ),
              Center(
                child: Text(
                  ':',
                  style: Styles.numbers,
                ),
              ),
              Positioned(
                right: 10,
                child: Text(
                  '$dmnSet',
                  style: Styles.numbers,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
