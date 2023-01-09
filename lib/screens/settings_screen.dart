import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '.././providers/theme.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = 'settings';

  const SettingsScreen({key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  IconData darkModeSwitcher = Icons.toggle_off_outlined;
  // bool _isDark = false;
  // TextEditingController _modeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('APP THEME'),
            trailing: IconButton(
              icon: Icon(
                Icons.brightness_7_outlined,
                size: 30,
              ),
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      scrollable: true,
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton.icon(
                            icon: Icon(Icons.light_mode_rounded),
                            label: Text('Light'),
                            onPressed: () {
                              _themeChanger.setTheme(ThemeMode.light);

                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton.icon(
                            icon: Icon(Icons.dark_mode_rounded),
                            label: Text('Dark'),
                            onPressed: () {
                              _themeChanger.setTheme(ThemeMode.dark);
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton.icon(
                            icon: Icon(Icons.settings_display_sharp),
                            label: Text('Same as System'),
                            onPressed: () {
                              _themeChanger.setTheme(ThemeMode.system);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                      // actions: [
                      // TextButton(
                      //   child: Text('Save'),
                      //   onPressed: _changeAppTheme,
                      // ),
                      // ],
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  // void _changeAppTheme() {
  //   setState(() {
  //     darkModeSwitcher =
  //         _isDark ? Icons.toggle_on_outlined : Icons.toggle_off_outlined;

  //     _isDark = !_isDark;
  //   });
  //   appMode = _isDark ? ThemeMode.dark : ThemeMode.light;
  // }
}
