import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

import '../services/language_preference.dart';

class LanguagesProvider with ChangeNotifier {
  LanguagePreferences languagePreferences = LanguagePreferences();
  Locale _locale = Locale('en');

  Locale get locale => _locale;

  set locale(Locale locale) {
    _locale = locale;
    HijriCalendar.setLocal(_locale.languageCode);
    Intl.defaultLocale = _locale.languageCode;
    languagePreferences.setLocale(locale.languageCode);
    notifyListeners();
  }
}
