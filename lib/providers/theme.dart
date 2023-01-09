import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  ThemeMode _themeMode;

  ThemeChanger(this._themeMode);
  getTheme() => _themeMode;
  setTheme(ThemeMode theme) {
    this._themeMode = theme;
    notifyListeners();
  }
}
