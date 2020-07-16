import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_tennis_statistics/components/InputMatchResult.dart';
import 'package:table_tennis_statistics/components/InputSetResult.dart';
import 'package:table_tennis_statistics/style/Styles.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddMatch extends StatefulWidget {
  AddMatch({Key key}) : super(key: key);

  @override
  _AddMatchState createState() => _AddMatchState();
}

class _AddMatchState extends State<AddMatch> {
  int _voySet;
  int _dmnSet;

  static DateTime _date = DateTime.now();
  static DateFormat _format = DateFormat('dd-MM-yyyy');
  String _formattedDate = _format.format(_date);

  final myController = TextEditingController();

  List<int> _voySetPoints = new List(7);
  List<int> _dmnSetPoints = new List(7);

  List<FocusNode> _focusNodes =
      new List<FocusNode>.generate(16, (index) => new FocusNode());

  List<bool> _errors =
      new List<bool>.generate(8, (index) => new bool.fromEnvironment(''));

  List<TextEditingController> _textEditingController =
      new List<TextEditingController>.generate(
          14, (index) => new TextEditingController());

  void checkSets() {
    if (_voySet == null || _dmnSet == null) {
      setState(() {
        _errors[7] = false;
      });
    } else {
      if (_voySet + _dmnSet > 7) {
        setState(() {
          _errors[7] = true;
        });
      } else if (_voySet != 4) {
        if (_dmnSet != 4) {
          setState(() {
            _errors[7] = true;
          });
        }
      }
    }
  }

  void checkSetPoints(int i) {
    if (_voySetPoints[i] == null || _dmnSetPoints[i] == null) {
      _errors[i] = false;
    } else {
      if (_voySetPoints[i] == _dmnSetPoints[i])
        _errors[i] = true;
      else if (_voySetPoints[i] < 11 && _dmnSetPoints[i] < 11)
        _errors[i] = true;
      else if (_voySetPoints[i] - _dmnSetPoints[i] == -1 ||
          _voySetPoints[i] - _dmnSetPoints[i] == 1)
        _errors[i] = true;
      else if (_voySetPoints[i] > 11 || _dmnSetPoints[i] > 11) {
        if (_voySetPoints[i] - _dmnSetPoints[i] == 2 ||
            _voySetPoints[i] - _dmnSetPoints[i] == -2) {
          _errors[i] = false;
        } else
          _errors[i] = true;
      } else
        _errors[i] = false;
    }
  }

  void resetPoints() {
    setState(() {
      _voySetPoints.fillRange(0, 7, null);
      _dmnSetPoints.fillRange(0, 7, null);
      _errors.fillRange(0, 7, false);
    });
  }

  bool checkWinner() {
    if (_errors.contains(true)) return false;

    int voySets = 0;
    int dmnSets = 0;

    int sets = _voySet + _dmnSet;

    for (int i = 0; i < sets; i++) {
      if (_voySetPoints[i] == null || _dmnSetPoints[i] == null) {
        return false;
      }

      if (_voySetPoints[i] > _dmnSetPoints[i])
        voySets++;
      else
        dmnSets++;
    }
    if (voySets != _voySet || dmnSets != _dmnSet) {
      return true;
    } else {
      return false;
    }
  }

  bool checkErrorsAndPoints() {
    if (_errors.contains(true)) {
      return false;
    } else {
      int sets = _voySet + _dmnSet;

      for (int i = 0; i < sets; i++) {
        if (_voySetPoints[i] == null || _dmnSetPoints[i] == null) return false;
      }
    }
    return true;
  }

  void onChangeVoySetPoints(text, int i) {
    if (text.contains(RegExp('[0-99]'))) {
      setState(() {
        _voySetPoints[i] = int.parse(text);
      });
    } else {
      setState(() {
        _voySetPoints[i] = null;
      });
    }
  }

  void onChangeDmnSetPoints(text, int i) {
    if (text.contains(RegExp('[0-99]'))) {
      setState(() {
        _dmnSetPoints[i] = int.parse(text);
      });
    } else {
      setState(() {
        _dmnSetPoints[i] = null;
      });
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
          backgroundColor: Styles.primaryColor,
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child:
                  Text('Podaj wynik spotkania w setach', style: Styles.header),
            ),
            InputMatchResult(
              voyFocusNode: _focusNodes[0],
              dmnFocusNode: _focusNodes[1],
              voyOnChange: (text) {
                if (text.contains(RegExp('[0-4]'))) {
                  FocusScope.of(context).requestFocus(_focusNodes[1]);
                  setState(() {
                    _voySet = int.parse(text);
                  });
                } else {
                  setState(() {
                    _voySet = null;
                  });
                }
                checkSets();
                resetPoints();
              },
              dmnOnChange: (text) {
                if (text.contains(RegExp('[0-4]'))) {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    _dmnSet = int.parse(text);
                  });
                } else {
                  setState(() {
                    _dmnSet = null;
                  });
                }
                checkSets();
                resetPoints();
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                    onPressed: () {
                      DatePicker.showDatePicker(
                        context,
                        minTime: DateTime(2014, 1, 1),
                        maxTime: DateTime.now(),
                        currentTime: DateTime.now(),
                        locale: LocaleType.pl,
                        showTitleActions: true,
                        onConfirm: (date) {
                          setState(() {
                            _formattedDate = _format.format(date);
                          });
                        },
                      );
                    },
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.calendar_today,
                            size: 24.0,
                          ),
                        ),
                        Text(_formattedDate),
                      ],
                    )),
              ],
            ),
            if (_errors[7])
              Text('Wprowadzono błędny wynik meczu', style: Styles.warnings),
            if (!_errors[7] && _voySet != null && _dmnSet != null)
              Column(children: <Widget>[
                Divider(
                  color: Colors.black,
                  thickness: 2,
                  indent: 50,
                  endIndent: 50,
                ),
                Text('Uzupełnij poniższe sety', style: Styles.header),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 5),
                          ListView(
                            shrinkWrap: true,
                            children: [
                              InputSetResult(
                                set: 1,
                                voyFocusNode: _focusNodes[2],
                                dmnFocusNode: _focusNodes[3],
                                voyController: _textEditingController[0],
                                dmnController: _textEditingController[1],
                                voyOnSubmitted: (text) {
                                  FocusScope.of(context)
                                      .requestFocus(_focusNodes[3]);
                                },
                                voyOnChange: (text) {
                                  this.onChangeVoySetPoints(text, 0);
                                  this.checkSetPoints(0);
                                },
                                dmnOnSubmitted: (text) {
                                  FocusScope.of(context)
                                      .requestFocus(_focusNodes[4]);
                                },
                                dmnOnChange: (text) {
                                  this.onChangeDmnSetPoints(text, 0);
                                  this.checkSetPoints(0);
                                },
                              ),
                              if (_errors[0])
                                Center(
                                  child: Text('Wprowadzono błędny wynik',
                                      style: Styles.warnings),
                                ),
                              InputSetResult(
                                set: 2,
                                voyFocusNode: _focusNodes[4],
                                dmnFocusNode: _focusNodes[5],
                                voyController: _textEditingController[2],
                                dmnController: _textEditingController[3],
                                voyOnSubmitted: (text) {
                                  FocusScope.of(context)
                                      .requestFocus(_focusNodes[5]);
                                },
                                voyOnChange: (text) {
                                  this.onChangeVoySetPoints(text, 1);
                                  this.checkSetPoints(1);
                                },
                                dmnOnSubmitted: (text) {
                                  FocusScope.of(context)
                                      .requestFocus(_focusNodes[6]);
                                },
                                dmnOnChange: (text) {
                                  this.onChangeDmnSetPoints(text, 1);
                                  this.checkSetPoints(1);
                                },
                              ),
                              if (_errors[1])
                                Center(
                                  child: Text('Wprowadzono błędny wynik',
                                      style: Styles.warnings),
                                ),
                              InputSetResult(
                                set: 3,
                                voyFocusNode: _focusNodes[6],
                                dmnFocusNode: _focusNodes[7],
                                voyController: _textEditingController[4],
                                dmnController: _textEditingController[5],
                                voyOnSubmitted: (text) {
                                  FocusScope.of(context)
                                      .requestFocus(_focusNodes[7]);
                                },
                                voyOnChange: (text) {
                                  this.onChangeVoySetPoints(text, 2);
                                  this.checkSetPoints(2);
                                },
                                dmnOnSubmitted: (text) {
                                  FocusScope.of(context)
                                      .requestFocus(_focusNodes[8]);
                                },
                                dmnOnChange: (text) {
                                  this.onChangeDmnSetPoints(text, 2);
                                  this.checkSetPoints(2);
                                },
                              ),
                              if (_errors[2])
                                Center(
                                  child: Text('Wprowadzono błędny wynik',
                                      style: Styles.warnings),
                                ),
                              InputSetResult(
                                set: 4,
                                voyFocusNode: _focusNodes[8],
                                dmnFocusNode: _focusNodes[9],
                                voyController: _textEditingController[6],
                                dmnController: _textEditingController[7],
                                voyOnSubmitted: (text) {
                                  FocusScope.of(context)
                                      .requestFocus(_focusNodes[9]);
                                },
                                voyOnChange: (text) {
                                  this.onChangeVoySetPoints(text, 3);
                                  this.checkSetPoints(3);
                                },
                                dmnOnSubmitted: (text) {
                                  if (_voySet + _dmnSet > 4)
                                    FocusScope.of(context)
                                        .requestFocus(_focusNodes[10]);
                                  else
                                    FocusScope.of(context).unfocus();
                                },
                                dmnOnChange: (text) {
                                  this.onChangeDmnSetPoints(text, 3);
                                  this.checkSetPoints(3);
                                },
                              ),
                              if (_errors[3])
                                Center(
                                  child: Text('Wprowadzono błędny wynik',
                                      style: Styles.warnings),
                                ),
                              if (_voySet + _dmnSet > 4)
                                InputSetResult(
                                  set: 5,
                                  voyFocusNode: _focusNodes[10],
                                  dmnFocusNode: _focusNodes[11],
                                  voyController: _textEditingController[8],
                                  dmnController: _textEditingController[9],
                                  voyOnSubmitted: (text) {
                                    FocusScope.of(context)
                                        .requestFocus(_focusNodes[11]);
                                  },
                                  voyOnChange: (text) {
                                    this.onChangeVoySetPoints(text, 4);
                                    this.checkSetPoints(4);
                                  },
                                  dmnOnSubmitted: (text) {
                                    if (_voySet + _dmnSet > 5)
                                      FocusScope.of(context)
                                          .requestFocus(_focusNodes[12]);
                                    else
                                      FocusScope.of(context).unfocus();
                                  },
                                  dmnOnChange: (text) {
                                    this.onChangeDmnSetPoints(text, 4);
                                    this.checkSetPoints(4);
                                  },
                                ),
                              if (_errors[4])
                                Center(
                                  child: Text('Wprowadzono błędny wynik',
                                      style: Styles.warnings),
                                ),
                              if (_voySet + _dmnSet > 5)
                                InputSetResult(
                                  set: 6,
                                  voyFocusNode: _focusNodes[12],
                                  dmnFocusNode: _focusNodes[13],
                                  voyController: _textEditingController[10],
                                  dmnController: _textEditingController[11],
                                  voyOnSubmitted: (text) {
                                    FocusScope.of(context)
                                        .requestFocus(_focusNodes[13]);
                                  },
                                  voyOnChange: (text) {
                                    this.onChangeVoySetPoints(text, 5);
                                    this.checkSetPoints(5);
                                  },
                                  dmnOnSubmitted: (text) {
                                    if (_voySet + _dmnSet > 6)
                                      FocusScope.of(context)
                                          .requestFocus(_focusNodes[14]);
                                    else
                                      FocusScope.of(context).unfocus();
                                  },
                                  dmnOnChange: (text) {
                                    this.onChangeDmnSetPoints(text, 5);
                                    this.checkSetPoints(5);
                                  },
                                ),
                              if (_errors[5])
                                Center(
                                  child: Text('Wprowadzono błędny wynik',
                                      style: Styles.warnings),
                                ),
                              if (_voySet + _dmnSet > 6)
                                InputSetResult(
                                  set: 7,
                                  voyFocusNode: _focusNodes[14],
                                  dmnFocusNode: _focusNodes[15],
                                  voyController: _textEditingController[12],
                                  dmnController: _textEditingController[13],
                                  voyOnSubmitted: (text) {
                                    FocusScope.of(context)
                                        .requestFocus(_focusNodes[15]);
                                  },
                                  voyOnChange: (text) {
                                    this.onChangeVoySetPoints(text, 6);
                                    this.checkSetPoints(6);
                                  },
                                  dmnOnSubmitted: (text) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  dmnOnChange: (text) {
                                    this.onChangeDmnSetPoints(text, 6);
                                    this.checkSetPoints(6);
                                  },
                                ),
                              if (_errors[6])
                                Center(
                                  child: Text('Wprowadzono błędny wynik',
                                      style: Styles.warnings),
                                ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    if (checkErrorsAndPoints() && !checkWinner())
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
                        child: FlatButton(
                          color: Styles.primaryColor,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(30.0),
                          shape: CircleBorder(),
                          onPressed: () => this.resetPoints(),
                          child: Column(
                            children: <Widget>[
                              Text("Dodaj"),
                              Text("Mecz"),
                            ],
                          ),
                        ),
                      ),
                    if (checkWinner())
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                        child: Column(
                          children: <Widget>[
                            Text("Wynik meczu", style: Styles.biggerWarning),
                            Text("nie zgadza się", style: Styles.biggerWarning),
                            Text("z setami", style: Styles.biggerWarning),
                          ],
                        ),
                      ),
                  ],
                ),
              ])
          ]),
        ),
      ),
    );
  }
}
