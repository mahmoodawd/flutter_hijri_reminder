import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePreferences {
  static const LANGUAGE_CODE = 'LANGUAGE_CODE';
  static const String ENGLISH = 'en';
  static const String ARABIC = 'ar';

  setLocale(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LANGUAGE_CODE, languageCode);
  }

  getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String langCode = prefs.getString(LANGUAGE_CODE) ?? ENGLISH;
    return Locale(langCode);
  }
}

AppLocalizations? translate(BuildContext? context) {
  return AppLocalizations.of(context!);
}
