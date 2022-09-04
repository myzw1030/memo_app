import 'package:flutter/material.dart';

// key を用意
const kTitleKey = 'name';

var kCardTextStyle = TextStyle(
  fontSize: 20.0,
  letterSpacing: 0.6,
  height: 1.4,
  fontWeight: FontWeight.w400,
  color: HexColor('222222'),
);

// カラーコード指定
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
