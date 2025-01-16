import 'package:flutter/material.dart';

class AppColor {
  static Color darkBaseColor = Color(0xFF4585B5);
  static Color lightTextTheme= Color(0xFF090909);
  static Color darkTextTheme= Color(0xFFECECEC);
  static Color darkContainer =Colors.grey.shade800;
  static Color lightContainer=Colors.grey.shade200;
  static Color darkLabelContainer =Colors.grey.shade900;
  static Color lightLabelContainer=Colors.grey.shade400;
  static Color LightSecondLabelContainer = Colors.grey.shade100;
  static Color LightTertiaryLabelContainer = Colors.grey.shade300;
  static Color darkSecondLabelContainer = Colors.grey.shade500;
  static Color darkTertiaryLabelContainer = Colors.grey.shade600;
  static const MaterialColor mainColor = MaterialColor(
    0xFF6A2C9C, // رنگ اصلی
    <int, Color>{
      50: Color(0xFFE9B5D7), // شید 50
      100: Color(0xFFD99FC7), // شید 100
      200: Color(0xFFC68AC8), // شید 200
      300: Color(0xFFB175C9), // شید 300
      400: Color(0xFF9A61CA), // شید 400
      500: Color(0xFF6A2C9C), // رنگ اصلی (شید 500)
      600: Color(0xFF5C2390), // شید 600
      700: Color(0xFF4F1A83), // شید 700
      800: Color(0xFF421172), // شید 800
      900: Color(0xFF33105F), // شید 900
    },
  );
  static Color SecondColor=mainColor.shade400;
  static Color TertiaryColor= Color.fromRGBO(241, 211, 250, 1);
  static Color baseColor=Colors.white;
  static Color textTicketScreenLight =mainColor.shade900;
  static Color textTicketScreenDark =const Color.fromARGB(255, 164, 214, 255);
  static Color darkTicketScreen=const Color.fromARGB(255, 164, 214, 255);
}