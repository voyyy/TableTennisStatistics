import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_tennis_statistics/style/Styles.dart';

class InputMatchResult extends StatelessWidget {
  InputMatchResult(
      {@required this.voyFocusNode,
      @required this.voyOnChange,
      @required this.dmnFocusNode,
      @required this.dmnOnChange});

  final voyFocusNode;
  final dmnFocusNode;
  final Function voyOnChange;
  final Function dmnOnChange;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Column(children: <Widget>[
          Text(
            'voy',
            style: Styles.voy,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            width: 40,
            height: 60,
            child: TextField(
              style: Styles.numbers,
              //autofocus: true,
              focusNode: this.voyFocusNode,
              textAlign: TextAlign.center,
              maxLength: 1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                counterText: '',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: this.voyOnChange,
              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp('[0-4]'))
              ],
            ),
          )
        ]),
      ),
      Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Text(
          ':',
          style: Styles.colon,
        ),
      ),
      Container(
        margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Column(children: <Widget>[
          Text('dmn', style: Styles.dmn),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            width: 40,
            height: 60,
            child: TextField(
              style: Styles.numbers,
              focusNode: this.dmnFocusNode,
              maxLength: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                counterText: '',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: this.dmnOnChange,
              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp('[0-4]'))
              ],
            ),
          )
        ]),
      ),
    ]);
  }
}
