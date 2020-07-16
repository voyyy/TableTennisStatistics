import 'package:flutter/material.dart';
import 'package:table_tennis_statistics/components/MatchResult.dart';
import 'package:table_tennis_statistics/components/SetResult.dart';
import 'package:table_tennis_statistics/style/Styles.dart';

class MatchDetails extends StatefulWidget {
  MatchDetails({Key key}) : super(key: key);

  @override
  _MatchDetailsState createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> {
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    return Column(
      children: <Widget>[
        AppBar(
          title: const Text('Statystyki meczu'),
          backgroundColor: Styles.primaryColor,
        ),
        SizedBox(
          height: 30,
        ),
        Align(
          alignment: Alignment(0.8, -1),
          child: Text(
            arguments['data']['date'],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        MatchResult(
          voySets: arguments['data']['result']['voy'],
          dmnSets: arguments['data']['result']['dmn'],
        ),
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
    );
  }
}
