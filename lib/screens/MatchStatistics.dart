import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:table_tennis_statistics/components/ChartPie.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:table_tennis_statistics/style/Styles.dart';

class MatchStatistics extends StatefulWidget {
  MatchStatistics({Key key}) : super(key: key);

  @override
  _MatchStatisticsState createState() => _MatchStatisticsState();
}

class _MatchStatisticsState extends State<MatchStatistics> {
  static var _data = [
    {
      "id": "111",
      "date": "20.09.2019",
      "result": {"voy": 4, "dmn": 2},
      "setsResult": [
        {
          "set1": {"voy": 11, "dmn": 0},
        },
        {
          "set2": {"voy": 11, "dmn": 0},
        },
        {
          "set3": {"voy": 11, "dmn": 0},
        },
        {
          "set4": {"voy": 11, "dmn": 0},
        }
      ]
    },
    {
      "id": "11",
      "date": "20.09.2019",
      "result": {"voy": 1, "dmn": 4},
      "setsResult": [
        {
          "set1": {"voy": 11, "dmn": 0},
        },
        {
          "set2": {"voy": 11, "dmn": 0},
        },
        {
          "set3": {"voy": 11, "dmn": 0},
        },
        {
          "set4": {"voy": 11, "dmn": 0},
        }
      ]
    }
  ];

  static var _encodedJson = json.encode(_data);
  var _decodedJson = json.decode(_encodedJson);

  List<charts.Series<Match, String>> _matchesPieData;
  List<charts.Series<Set, String>> _setsPieData;
  List<charts.Series<Point, String>> _pointsPieData;

  _generateData() {
    int voyMatches = 0;
    int dmnMatches = 0;
    int voySets = 0;
    int dmnSets = 0;
    int voyPoints = 0;
    int dmnPoints = 0;

    for (int i = 0; i < _decodedJson.length; i++) {
      if (_decodedJson[i]['result']['voy'] > _decodedJson[i]['result']['dmn']) {
        voyMatches++;
        voySets += _decodedJson[i]['result']['voy'];
        dmnSets += _decodedJson[i]['result']['dmn'];
      } else {
        dmnMatches++;
        voySets += _decodedJson[i]['result']['voy'];
        dmnSets += _decodedJson[i]['result']['dmn'];
      }

      for (int j = 0; j < _decodedJson[i]['setsResult'].length; j++) {
        voyPoints +=
            _decodedJson[i]['setsResult'][j]['set' + (j + 1).toString()]['voy'];
        dmnPoints +=
            _decodedJson[i]['setsResult'][j]['set' + (j + 1).toString()]['dmn'];
      }
    }

    var matchesData = [
      Match('dmn', dmnMatches, Styles.dmnColor),
      Match('voy', voyMatches, Styles.voyColor),
    ];

    var setsData = [
      Set('dmn', dmnSets, Styles.dmnColor),
      Set('voy', voySets, Styles.voyColor),
    ];

    var pointsData = [
      Point('dmn', dmnPoints, Styles.dmnColor),
      Point('voy', voyPoints, Styles.voyColor),
    ];

    _matchesPieData.add(
      charts.Series(
        domainFn: (Match match, _) => match.name,
        measureFn: (Match match, _) => match.matchValue,
        colorFn: (Match match, _) =>
            charts.ColorUtil.fromDartColor(match.color),
        id: 'matches',
        data: matchesData,
        labelAccessorFn: (Match match, _) => '${match.matchValue}',
      ),
    );

    _setsPieData.add(
      charts.Series(
        domainFn: (Set set, _) => set.name,
        measureFn: (Set set, _) => set.setValue,
        colorFn: (Set set, _) => charts.ColorUtil.fromDartColor(set.color),
        id: 'sets',
        data: setsData,
        labelAccessorFn: (Set set, _) => '${set.setValue}',
      ),
    );

    _pointsPieData.add(
      charts.Series(
        domainFn: (Point point, _) => point.name,
        measureFn: (Point point, _) => point.pointValue,
        colorFn: (Point point, _) =>
            charts.ColorUtil.fromDartColor(point.color),
        id: 'points',
        data: pointsData,
        labelAccessorFn: (Point point, _) => '${point.pointValue}',
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _matchesPieData = List<charts.Series<Match, String>>();
    _setsPieData = List<charts.Series<Set, String>>();
    _pointsPieData = List<charts.Series<Point, String>>();
    _generateData();
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          title: const Text('Statystyki meczów'),
          backgroundColor: Styles.primaryColor,
        ),
        Center(
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
        ),
      ],
    );
  }
}

class Match {
  String name;
  int matchValue;
  Color color;

  Match(this.name, this.matchValue, this.color);
}

class Set {
  String name;
  int setValue;
  Color color;

  Set(this.name, this.setValue, this.color);
}

class Point {
  String name;
  int pointValue;
  Color color;

  Point(this.name, this.pointValue, this.color);
}
