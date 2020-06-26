import 'package:flutter/material.dart';

abstract class Styles {
  static const _voyColor = Color.fromRGBO(216, 61, 218, 1);
  static const _dmnColor = Color.fromRGBO(0, 141, 255, 1);
  static const _primaryColor = Color.fromRGBO(52, 141, 38, 1);
  static const _warningColor = Colors.red;

  static const TextStyle header = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle voy = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: _voyColor,
  );
  static const TextStyle dmn = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: _dmnColor,
  );
  static const TextStyle colon = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle numbers = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle warnings = TextStyle(
    fontSize: 11,
    color: _warningColor,
  );
}
