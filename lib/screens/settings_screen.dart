import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import 'package:flutter/material.dart';

import '../providers/theme.dart';
import '../widgets/shared/custom_app_bar.dart';

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
      appBar: CustomAppBar(title: 'Settings'),
      body: SettingsList(
        lightTheme: SettingsThemeData(
          leadingIconsColor: Theme.of(context).iconTheme.color,
          settingsTileTextColor: Theme.of(context).primaryColor,
        ),
        sections: [
          SettingsSection(
            title: Text(
              'Preferences',
              style: Theme.of(context).textTheme.bodyText2,
            ),
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
