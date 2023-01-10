import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: isDarkTheme ? Colors.grey : Colors.green,
      fontFamily: 'Rakkas',
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: isDarkTheme ? Colors.white : Colors.green,
        ),
        bodyText2: TextStyle(
          color: isDarkTheme ? Colors.white : Colors.green,
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      primaryColor: isDarkTheme ? Colors.black : Colors.green,
      backgroundColor: isDarkTheme ? Colors.black : Color(0xffF1F5FB),
      indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      hintColor: isDarkTheme
          ? Color.fromARGB(255, 176, 231, 169)
          : Color.fromARGB(255, 238, 206, 238),
      highlightColor: isDarkTheme
          ? Color.fromARGB(255, 187, 172, 132)
          : Color.fromARGB(255, 34, 211, 48),
      hoverColor:
          isDarkTheme ? Color(0xff3A3A3B) : Color.fromARGB(255, 34, 211, 48),
      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      iconTheme: IconThemeData(
          color: isDarkTheme ? Colors.white : Color.fromARGB(255, 25, 133, 34)),
      appBarTheme: AppBarTheme(
        elevation: 5.0,
      ),
    );
  }
}
