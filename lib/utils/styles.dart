import 'package:flutter/material.dart';
import 'package:hijri_reminder/providers/fonts.dart';
import 'package:provider/provider.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      fontFamily: Provider.of<FontProvider>(context).fontFamily,
      disabledColor: Colors.grey,
      appBarTheme: AppBarTheme(elevation: 5.0),
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      primarySwatch: isDarkTheme ? Colors.grey : Colors.green,
      backgroundColor: isDarkTheme ? Colors.black : Color(0xffF1F5FB),
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: isDarkTheme ? Colors.white : Colors.green.shade500,
        ),
        bodyText1: TextStyle(
          color: isDarkTheme ? Colors.white : Colors.green.shade500,
          fontSize: 16.0,
        ),
        subtitle1: TextStyle(
          color: isDarkTheme ? Colors.white : Colors.green.shade500,
          fontSize: 10.0,
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
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: isDarkTheme ? Colors.grey : Colors.green,
      ),
      iconTheme: IconThemeData(
          color: isDarkTheme ? Colors.white : Color.fromARGB(255, 23, 117, 31)),
    );
  }
}
