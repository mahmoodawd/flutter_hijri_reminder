import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '.././providers/theme.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = 'settings';

  const SettingsScreen({key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var darkThemeProvider = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Preferences'),
            tiles: <SettingsTile>[
              SettingsTile.switchTile(
                onToggle: (value) {
                  darkThemeProvider.darkThemeStatus = value;
                },
                initialValue: darkThemeProvider.darkThemeStatus,
                title: Text('Dark Mode'),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.language),
                title: Text('Language'),
                value: Text('Soon'),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.font_download_outlined),
                title: Text('Font type'),
                value: Text('Soon'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
