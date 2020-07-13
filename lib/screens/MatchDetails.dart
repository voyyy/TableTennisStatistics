import 'package:flutter/material.dart';
import 'package:table_tennis_statistics/components/MatchResult.dart';
import 'package:table_tennis_statistics/components/SetResult.dart';

class MatchDetails extends StatefulWidget {
  MatchDetails({Key key}) : super(key: key);

  @override
  _MatchDetailsState createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> {
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      body: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Statystyki meczu'),
          ),
          RaisedButton(
            onPressed: () {
              //Navigator.pop(context);
              print(arguments['data']['setsResult'][1]
                  ["set" + (1 + 1).toString()]["voy"]);
            },
            child: Text('args'),
          ),
          MatchResult(
              voySets: arguments['data']['result']['voy'],
              dmnSets: arguments['data']['result']['dmn']),
          ListView.builder(
            shrinkWrap: true,
            itemCount: arguments['data']['setsResult'].length,
            itemBuilder: (context, int index) {
              return SetResult(
                voySet: arguments['data']['setsResult'][index]
                    ["set" + (index + 1).toString()]["voy"],
                dmnSet: arguments['data']['setsResult'][index]
                    ["set" + (index + 1).toString()]["dmn"],
              );
            },
          ),
        ],
      ),
    );
  }
}
