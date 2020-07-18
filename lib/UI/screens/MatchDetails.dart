import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_tennis_statistics/UI/components/MatchResult.dart';
import 'package:table_tennis_statistics/UI/components/SetResult.dart';
import 'package:table_tennis_statistics/UI/style/Styles.dart';

class MatchDetails extends StatefulWidget {
  MatchDetails({Key key}) : super(key: key);

  @override
  _MatchDetailsState createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> {
  DateFormat _dateFormat;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('pl', null);
    _dateFormat = new DateFormat.yMMMMd('pl');
  }

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
            _dateFormat.format(arguments['data'].date),
            style: Styles.smallerNumbers,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        MatchResult(
          voySets: arguments['data'].result['voy'],
          dmnSets: arguments['data'].result['dmn'],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: arguments['data'].setResult.length,
          itemBuilder: (context, int index) {
            return SetResult(
              voySet: arguments['data'].setResult[index]["voy"],
              dmnSet: arguments['data'].setResult[index]["dmn"],
            );
          },
        ),
      ],
    );
  }
}
