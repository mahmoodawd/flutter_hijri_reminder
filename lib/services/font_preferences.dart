import 'package:shared_preferences/shared_preferences.dart';

class FontPreferences {
  static const FONT_TYPE = "FONT_TYPE";

  setFont(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(FONT_TYPE, value);
  }

  Future<String> getFont() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(FONT_TYPE) ?? '';
  }
}
