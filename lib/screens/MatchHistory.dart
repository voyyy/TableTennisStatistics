import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:table_tennis_statistics/components/MatchItem.dart';
import 'package:table_tennis_statistics/style/Styles.dart';

class MatchHistory extends StatefulWidget {
  MatchHistory({Key key}) : super(key: key);

  @override
  _MatchHistoryState createState() => _MatchHistoryState();
}

class _MatchHistoryState extends State<MatchHistory> {
  static var _data = [
    {
      "id": "111",
      "date": "20.09.2019",
      "result": {"voy": 4, "dmn": 0},
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
      "result": {"voy": 0, "dmn": 4},
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

  Future<bool> confirmDelete(DismissDirection direction) {
    return showCupertinoDialog<bool>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            content: Text("Are you sure you want to delete?"),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              CupertinoDialogAction(
                child: Text('Cancel'),
                onPressed: () {
                  return Navigator.of(context).pop(false);
                },
              )
            ],
          ),
        ) ??
        false;
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          title: const Text('Historia meczów'),
          backgroundColor: Styles.primaryColor,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _decodedJson.length,
          itemBuilder: (context, int index) {
            return Dismissible(
              key: Key(_decodedJson[index]['id']),
              confirmDismiss: (direction) => confirmDelete(direction),
              direction: DismissDirection.endToStart,
              background: Align(
                alignment: Alignment(0.9, 0),
                child: Icon(
                  Icons.delete_forever,
                  size: 60,
                ),
              ),
              child: MatchItem(
                color: _decodedJson[index]["result"]["voy"] >
                        _decodedJson[index]["result"]["dmn"]
                    ? Styles.voyColor
                    : Styles.dmnColor,
                date: _decodedJson[index]["date"],
                matchResult: _decodedJson[index]["result"]["voy"].toString() +
                    ':' +
                    _decodedJson[index]["result"]["dmn"].toString(),
                onTap: () => Navigator.pushNamed(context, '/matchDetails',
                    arguments: {'data': _decodedJson[index]}),
              ),
            );
          },
        ),
      ],
    );
  }
}
