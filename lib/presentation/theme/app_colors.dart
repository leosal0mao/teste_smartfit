import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color themeLighterColor = Color(0xff43446A);
  static const Color themeColor = Color(0xff31315C);
  static const Color transparent = Colors.transparent;
  static const Color shadowBlue = Color(0xff0d5180);
  static const Color blue = Color(0xFF096CB4);
  static const Color lightBlue = Color(0xFF95c5e6);
  static const Color darkBlue = Color(0xFF0E6AF5);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color inactiveButton = Color(0xFFE0DCDA);
  static const Color inactiveText = Color(0xff939598);
  static const Color orange = Color(0xffff4e27);
  static const Color greyText = Color(0xFF8D7F7C);
  static const Color red = Color(0xFFED1C24);
  static const Color green = Color(0xFF00A650);
  static const Color gridButtonGrey = Color(0xFFF1F1F0);
  static const Color filterBlue = Color(0xFF5665AF);
  static const Color darkGreyText = Color(0xFF58595B);
}

extension ColorsExt on Color {
  MaterialColor toMaterialColor() {
    final int red = this.red;
    final int green = this.green;
    final int blue = this.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(value, shades);
  }
}
