import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:table_tennis_statistics/UI/style/Styles.dart';

class ChartPie extends StatelessWidget {
  ChartPie({@required this.title, @required this.list});

  final String title;
  final list;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Text("$title", style: Styles.header),
          Container(
            width: 180,
            height: 180,
            child: charts.PieChart(
              list,
              animate: true,
              animationDuration: Duration(seconds: 1),
              defaultRenderer: charts.ArcRendererConfig(
                arcWidth: 50,
                arcRendererDecorators: [
                  charts.ArcLabelDecorator(
                    labelPosition: charts.ArcLabelPosition.inside,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
