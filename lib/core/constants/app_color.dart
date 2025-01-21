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
  0xFF6750A4, // رنگ اصلی
  <int, Color>{
    50: Color(0xFFE5DFF1), // شید 50
    100: Color(0xFFD2C6E7), // شید 100
    200: Color(0xFFB8A9DC), // شید 200
    300: Color(0xFF9E8CD1), // شید 300
    400: Color(0xFF8673C6), // شید 400
    500: Color(0xFF6750A4), // رنگ اصلی (شید 500)
    600: Color(0xFF5B4792), // شید 600
    700: Color(0xFF4F3E80), // شید 700
    800: Color(0xFF43356E), // شید 800
    900: Color(0xFF372B5C), // شید 900
  },
);
  static Color SecondColor=mainColor.shade400;
  static Color TertiaryColor= mainColor.shade50;
  static Color baseColor=Colors.white;
  static Color textTicketScreenLight =mainColor.shade900;
  static Color textTicketScreenDark =const Color.fromARGB(255, 164, 214, 255);
  static Color darkTicketScreen=const Color.fromARGB(255, 164, 214, 255);
  static Color gradientColor1= const Color.fromARGB(255, 33, 23, 57).withOpacity(0.99);
  static Color gradientColor2= const Color.fromARGB(255, 38, 20, 81).withOpacity(0.99);
  static Color gradientColor3= const Color.fromARGB(255, 59, 32, 132).withOpacity(0.6);
  static Color gradientColor4= Colors.white.withOpacity(0.7);
}