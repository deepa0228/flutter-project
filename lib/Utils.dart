import 'package:flutter/material.dart';
 class Utils {

static const kApiKey = "c76e1e57adbc81d208d5bdb9f9ecf3c90f1fad4ecb32572fb7ac9e870adaddce";
static String unsplashUrl = "https://api.unsplash.com/photos?page=";
static String collectionIdUrl = "https://api.unsplash.com/collections/";

static Color color = HexColor.fromHex('#000046');
static Color color1 = HexColor.fromHex('#1CB5E0');

}
extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}