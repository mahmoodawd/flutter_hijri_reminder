import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

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
    bool isDark = darkThemeProvider.darkThemeStatus;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Theme Mode'),
            trailing: IconButton(
              onPressed: () {
                isDark = !isDark;
                darkThemeProvider.darkThemeStatus = isDark;
              },
              icon: Icon(
                  isDark ? Icons.lightbulb_outline : Icons.lightbulb_rounded),
              color: Theme.of(context).iconTheme.color,
              iconSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}
