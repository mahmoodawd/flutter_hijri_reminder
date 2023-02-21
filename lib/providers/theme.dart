import 'package:flutter/foundation.dart';

import '../services/theme_preferences.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _isDark = false;

  bool get darkThemeStatus => _isDark;

  set darkThemeStatus(bool value) {
    _isDark = value;
    darkThemePreference.setDarkThemeStatus(value);
    notifyListeners();
  }
}
