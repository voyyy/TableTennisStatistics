import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_tennis_statistics/UI/components/ChartPie.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:table_tennis_statistics/UI/style/Styles.dart';
import 'package:table_tennis_statistics/core/view/CRUDModel.dart';
import 'package:table_tennis_statistics/core/models/MatchModel.dart';

class MatchStatistics extends StatefulWidget {
  MatchStatistics({Key key}) : super(key: key);

  @override
  _MatchStatisticsState createState() => _MatchStatisticsState();
}

class _MatchStatisticsState extends State<MatchStatistics> {
  List<Match> matches;
  List<charts.Series<MatchChart, String>> _matchesPieData;
  List<charts.Series<SetChart, String>> _setsPieData;
  List<charts.Series<PointChart, String>> _pointsPieData;

  @override
  void initState() {
    super.initState();
    _matchesPieData = List<charts.Series<MatchChart, String>>();
    _setsPieData = List<charts.Series<SetChart, String>>();
    _pointsPieData = List<charts.Series<PointChart, String>>();
  }

  Widget fillCharts(matches) {
    int voyMatches = 0;
    int dmnMatches = 0;
    int voySets = 0;
    int dmnSets = 0;
    int voyPoints = 0;
    int dmnPoints = 0;

    for (int i = 0; i < matches.length; i++) {
      if (matches[i].result['voy'] > matches[i].result['dmn']) {
        voyMatches++;
        voySets += matches[i].result['voy'];
        dmnSets += matches[i].result['dmn'];
      } else {
        dmnMatches++;
        voySets += matches[i].result['voy'];
        dmnSets += matches[i].result['dmn'];
      }

      for (int j = 0; j < matches[i].setResult.length; j++) {
        voyPoints += matches[i].setResult[j]['voy'];
        dmnPoints += matches[i].setResult[j]['dmn'];
      }
    }

    var matchesData = [
      MatchChart('dmn', dmnMatches, Styles.dmnColor),
      MatchChart('voy', voyMatches, Styles.voyColor),
    ];

    var setsData = [
      SetChart('dmn', dmnSets, Styles.dmnColor),
      SetChart('voy', voySets, Styles.voyColor),
    ];

    var pointsData = [
      PointChart('dmn', dmnPoints, Styles.dmnColor),
      PointChart('voy', voyPoints, Styles.voyColor),
    ];

    _matchesPieData.add(
      charts.Series(
        domainFn: (MatchChart match, _) => match.name,
        measureFn: (MatchChart match, _) => match.matchValue,
        colorFn: (MatchChart match, _) =>
            charts.ColorUtil.fromDartColor(match.color),
        id: 'matches',
        data: matchesData,
        labelAccessorFn: (MatchChart match, _) => '${match.matchValue}',
      ),
    );

    _setsPieData.add(
      charts.Series(
        domainFn: (SetChart set, _) => set.name,
        measureFn: (SetChart set, _) => set.setValue,
        colorFn: (SetChart set, _) => charts.ColorUtil.fromDartColor(set.color),
        id: 'sets',
        data: setsData,
        labelAccessorFn: (SetChart set, _) => '${set.setValue}',
      ),
    );

    _pointsPieData.add(
      charts.Series(
        domainFn: (PointChart point, _) => point.name,
        measureFn: (PointChart point, _) => point.pointValue,
        colorFn: (PointChart point, _) =>
            charts.ColorUtil.fromDartColor(point.color),
        id: 'points',
        data: pointsData,
        labelAccessorFn: (PointChart point, _) => '${point.pointValue}',
      ),
    );

    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.timelapse,
                color: Styles.voyColor,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'voy',
                style: Styles.header,
              ),
              SizedBox(
                width: 50,
              ),
              Icon(
                Icons.timelapse,
                color: Styles.dmnColor,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'dmn',
                style: Styles.header,
              ),
            ],
          ),
          ChartPie(
            title: 'Wygrane mecze',
            list: _matchesPieData,
          ),
          Row(
            children: <Widget>[
              ChartPie(
                title: 'Wygrane sety',
                list: _setsPieData,
              ),
              ChartPie(
                title: 'Wygrane punkty',
                list: _pointsPieData,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    final matchProvider = Provider.of<CRUDModel>(context);
    return Column(
      children: <Widget>[
        AppBar(
          title: const Text('Statystyki meczów'),
          backgroundColor: Styles.primaryColor,
        ),
        StreamBuilder(
          stream: matchProvider.fetchMatchesAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.documents.length == 0)
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 250, 0, 0),
                  child: Center(
                    child: Text('Brak meczów w historii'),
                  ),
                );
              else {
                matches = snapshot.data.documents
                    .map((doc) => Match.fromMap(doc.data, doc.documentID))
                    .toList();
                return fillCharts(matches);
              }
            } else
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 250, 0, 0),
                child: Container(
                  height: 70,
                  width: 70,
                  child: CircularProgressIndicator(
                    strokeWidth: 12,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Styles.primaryColor),
                  ),
                ),
              );
          },
        ),
      ],
    );
  }
}

class MatchChart {
  String name;
  int matchValue;
  Color color;

  MatchChart(this.name, this.matchValue, this.color);
}

class SetChart {
  String name;
  int setValue;
  Color color;

  SetChart(this.name, this.setValue, this.color);
}

class PointChart {
  String name;
  int pointValue;
  Color color;

  PointChart(this.name, this.pointValue, this.color);
}
