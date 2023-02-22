import 'package:hijri_reminder/providers/fonts.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import 'package:flutter/material.dart';

import '../models/font.dart';
import '../models/language.dart';
import '../services/language_preference.dart';
import '../providers/theme.dart';
import '../providers/languages.dart';
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
    var languagesProvider = Provider.of<LanguagesProvider>(context);
    var fontProvider = Provider.of<FontProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(title: translate(context)!.settings),
      body: SettingsList(
        lightTheme: SettingsThemeData(
          leadingIconsColor: Theme.of(context).iconTheme.color,
          settingsTileTextColor: Theme.of(context).primaryColor,
        ),
        sections: [
          SettingsSection(
            title: Text(
              translate(context)!.preferences,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            tiles: <SettingsTile>[
              SettingsTile.switchTile(
                onToggle: (value) {
                  darkThemeProvider.darkThemeStatus = value;
                },
                initialValue: darkThemeProvider.darkThemeStatus,
                title: Text(
                  translate(context)!.darkMode,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              SettingsTile.navigation(
                  leading: Icon(Icons.language),
                  title: Text(
                    translate(context)!.language,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onPressed: (context) => showModalBottomSheet(
                        elevation: 10,
                        context: context,
                        builder: (context) {
                          return Wrap(
                            children: Language.languageList()
                                .map((selectedLanguage) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        elevation: 5.0,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: ListTile(
                                          trailing: Text(
                                            selectedLanguage.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          leading: Text(selectedLanguage.flag),
                                          onTap: () {
                                            languagesProvider.locale =
                                                Locale(selectedLanguage.code);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                    ))
                                .toList(),
                          );
                        },
                      )),
              SettingsTile.navigation(
                  leading: Icon(Icons.font_download_outlined),
                  title: Text(
                    translate(context)!.font,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onPressed: (context) => showModalBottomSheet(
                        elevation: 10,
                        context: context,
                        builder: (context) {
                          return Wrap(
                            children: Font.fontList()
                                .map((selectedFont) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        elevation: 5.0,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: ListTile(
                                          title: Text(
                                              translate(context)!.fontSample,
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontFamily:
                                                        selectedFont.family,
                                                  )),
                                          onTap: () {
                                            fontProvider.fontFamily =
                                                selectedFont.family;
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                    ))
                                .toList(),
                          );
                        },
                      )),
            ],
          ),
        ],
      ),
    );
  }
}
