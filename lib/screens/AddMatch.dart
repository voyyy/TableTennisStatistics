import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_tennis_statistics/style/Styles.dart';

class AddMatch extends StatefulWidget {
  AddMatch({Key key}) : super(key: key);

  @override
  _AddMatchState createState() => _AddMatchState();
}

class _AddMatchState extends State<AddMatch> {
  int _voySet;
  int _dmnSet;
  bool _showSetWarning = false;

  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();

  void checkSets() {
    if (_voySet == null || _dmnSet == null) {
      setState(() {
        _showSetWarning = false;
      });
    } else {
      if (_voySet + _dmnSet > 7) {
        setState(() {
          _showSetWarning = true;
        });
      } else if (_voySet != 4) {
        if (_dmnSet != 4) {
          setState(() {
            _showSetWarning = true;
          });
        }
      }
    }
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dodaj mecz'),
        ),
        body: Column(children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Text('Podaj wynik spotkania w setach', style: Styles.header),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(25, 10, 25, 0),
                  child: Column(children: [
                    Text(
                      'voy',
                      style: Styles.voy,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      width: 40,
                      child: TextField(
                        style: Styles.numbers,
                        autofocus: true,
                        focusNode: nodeOne,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (text) {
                          if (text.contains(RegExp('[0-4]'))) {
                            FocusScope.of(context).requestFocus(nodeTwo);
                            setState(() {
                              _voySet = int.parse(text);
                            });
                          } else {
                            setState(() {
                              _voySet = null;
                            });
                          }
                          checkSets();
                        },
                        // inputFormatters: <TextInputFormatter>[
                        //   WhitelistingTextInputFormatter.digitsOnly
                        // ],
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp('[0-4]'))
                        ],
                      ),
                    )
                  ]),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Text(
                    ':',
                    style: Styles.colon,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(25, 10, 25, 0),
                  child: Column(children: [
                    Text('dmn', style: Styles.dmn),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      width: 40,
                      child: TextField(
                        style: Styles.numbers,
                        focusNode: nodeTwo,
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (text) {
                          if (text.contains(RegExp('[0-4]'))) {
                            FocusScope.of(context).requestFocus(nodeTwo);
                            setState(() {
                              _dmnSet = int.parse(text);
                            });
                          } else {
                            setState(() {
                              _dmnSet = null;
                            });
                          }
                          checkSets();
                        },
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp('[0-4]'))
                        ],
                      ),
                    )
                  ]),
                ),
              ]),
          if (_showSetWarning)
            Text('Wprowadzono błędny wynik', style: Styles.warnings),
        ]),
      ),
    );
  }
}
