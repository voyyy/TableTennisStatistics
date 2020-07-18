import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_tennis_statistics/UI/components/MatchItem.dart';
import 'package:table_tennis_statistics/UI/style/Styles.dart';
import 'package:table_tennis_statistics/core/view/CRUDModel.dart';
import 'package:table_tennis_statistics/core/models/MatchModel.dart';

class MatchHistory extends StatefulWidget {
  MatchHistory({Key key}) : super(key: key);

  @override
  _MatchHistoryState createState() => _MatchHistoryState();
}

class _MatchHistoryState extends State<MatchHistory> {
  List<Match> matches;

  DateFormat _dateFormat;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('pl', null);
    _dateFormat = new DateFormat.yMMMMd('pl');
  }

  Future<bool> confirmDelete(
      DismissDirection direction, String id, matchProvider) {
    return showCupertinoDialog<bool>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            content: Text("Czy na pewno chcesz usunać?"),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("Tak"),
                onPressed: () {
                  matchProvider.removeMatch(id);
                  return Navigator.of(context).pop(true);
                },
              ),
              CupertinoDialogAction(
                child: Text('Nie'),
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
    final matchProvider = Provider.of<CRUDModel>(context);
    return Column(
      children: <Widget>[
        AppBar(
          title: const Text('Historia meczów'),
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
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: matches.length,
                  itemBuilder: (context, int index) {
                    return Dismissible(
                      key: Key(matches[index].id),
                      confirmDismiss: (direction) => confirmDelete(
                          direction, matches[index].id, matchProvider),
                      direction: DismissDirection.endToStart,
                      background: Align(
                        alignment: Alignment(0.9, 0),
                        child: Icon(
                          Icons.delete_forever,
                          size: 60,
                        ),
                      ),
                      child: MatchItem(
                        color: matches[index].result['voy'] >
                                matches[index].result['dmn']
                            ? Styles.voyColor
                            : Styles.dmnColor,
                        date: _dateFormat.format(
                          matches[index].date,
                        ),
                        matchResult: matches[index].result['voy'].toString() +
                            ':' +
                            matches[index].result['dmn'].toString(),
                        onTap: () => Navigator.pushNamed(
                            context, '/matchDetails',
                            arguments: {'data': matches[index]}),
                      ),
                    );
                  },
                );
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
