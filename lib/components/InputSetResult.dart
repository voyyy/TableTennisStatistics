import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_tennis_statistics/style/Styles.dart';

class InputSetResult extends StatelessWidget {
  InputSetResult({
    @required this.set,
    @required this.voyFocusNode,
    @required this.voyOnChange,
    @required this.dmnFocusNode,
    @required this.dmnOnChange,
    @required this.voyOnSubmitted,
    @required this.dmnOnSubmitted,
    @required this.voyController,
    @required this.dmnController,
  });

  final int set;
  final voyFocusNode;
  final dmnFocusNode;
  final Function voyOnChange;
  final Function dmnOnChange;
  final Function voyOnSubmitted;
  final Function dmnOnSubmitted;
  final voyController;
  final dmnController;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text('$set set'),
      Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(5, 5, 10, 0),
            width: 45,
            height: 45,
            child: TextField(
              style: Styles.smallerNumbers,
              focusNode: this.voyFocusNode,
              textAlign: TextAlign.center,
              maxLength: 2,
              keyboardType: TextInputType.number,
              onChanged: this.voyOnChange,
              onSubmitted: this.voyOnSubmitted,
              controller: this.voyController,
              decoration: InputDecoration(
                counterText: '',
                border: OutlineInputBorder(),
                isDense: true,
                //contentPadding: EdgeInsets.all(8),
              ),
              //onChanged: this.voyOnChange,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
            ),
          ),
          Container(
            child: Text(
              ':',
              style: Styles.colon,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 5, 35, 0),
            width: 45,
            height: 45,
            child: TextField(
              style: Styles.smallerNumbers,
              scrollPadding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              focusNode: this.dmnFocusNode,
              maxLength: 2,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: this.dmnOnChange,
              onSubmitted: this.dmnOnSubmitted,
              controller: this.dmnController,
              decoration: InputDecoration(
                counterText: '',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              //onChanged: this.dmnOnChange,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
            ),
          ),
        ],
      )
    ]);
  }
}
