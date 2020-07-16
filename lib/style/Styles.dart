import 'package:flutter/material.dart';

abstract class Styles {
  static const voyColor = Color.fromRGBO(216, 61, 218, 0.8);
  static const dmnColor = Color.fromRGBO(0, 141, 255, 0.8);
  static const primaryColor = Color.fromRGBO(52, 141, 38, 0.9);
  static const _warningColor = Colors.red;

  static const TextStyle header = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle voy = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: voyColor,
  );
  static const TextStyle dmn = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: dmnColor,
  );
  static const TextStyle colon = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle biggerNumbers = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle numbers = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle smallerNumbers = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle warnings = TextStyle(
    fontSize: 11,
    color: _warningColor,
  );
  static const TextStyle biggerWarning = TextStyle(
    fontSize: 15,
    color: _warningColor,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle matchItem = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
