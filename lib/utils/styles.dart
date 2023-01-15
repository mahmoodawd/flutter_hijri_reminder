import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      fontFamily: 'Rakkas',
      disabledColor: Colors.grey,
      appBarTheme: AppBarTheme(elevation: 5.0),
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      primarySwatch: isDarkTheme ? Colors.grey : Colors.green,
      backgroundColor: isDarkTheme ? Colors.black : Color(0xffF1F5FB),
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: isDarkTheme ? Colors.white : Colors.green,
        ),
        bodyText2: TextStyle(
          color: isDarkTheme ? Colors.white : Colors.green,
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      hintColor: isDarkTheme
          ? Color.fromARGB(255, 129, 136, 128)
          : Color.fromARGB(255, 112, 206, 120),
      highlightColor: isDarkTheme
          ? Color.fromARGB(255, 109, 106, 99)
          : Color.fromARGB(255, 34, 211, 48),
      hoverColor:
          isDarkTheme ? Color(0xff3A3A3B) : Color.fromARGB(255, 34, 211, 48),
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light(),
          ),
      iconTheme: IconThemeData(
          color: isDarkTheme ? Colors.white : Color.fromARGB(255, 23, 117, 31)),
    );
  }
}
