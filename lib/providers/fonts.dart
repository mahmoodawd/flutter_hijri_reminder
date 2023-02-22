import 'package:flutter/foundation.dart';

import '../services/font_preferences.dart';

class FontProvider with ChangeNotifier {
  FontPreferences fontPreferences = FontPreferences();
  String _font = 'Tajawal';

  String get fontFamily => _font;

  set fontFamily(String font) {
    _font = font;
    fontPreferences.setFont(font);
    notifyListeners();
  }
}
