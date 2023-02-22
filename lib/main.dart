import 'package:flutter/material.dart';
import 'package:hijri_reminder/providers/fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'services/notifications_service.dart';
import 'providers/languages.dart';
import 'providers/theme.dart';
import 'providers/user_events.dart';
import 'providers/public_events.dart';

import 'utils/styles.dart';
import 'screens/app_home.dart';
import 'screens/public_events_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/about_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();
  LanguagesProvider languagesProvider = new LanguagesProvider();
  FontProvider fontProvider = new FontProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
    getCurrentAppLanguage();
    getCurrentFont();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkThemeStatus =
        await themeChangeProvider.darkThemePreference.getDarkThemeStatus();
  }

  void getCurrentAppLanguage() async {
    languagesProvider.locale =
        await languagesProvider.languagePreferences.getLocale();
  }

  void getCurrentFont() async {
    fontProvider.fontFamily = await fontProvider.fontPreferences.getFont();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: PublicEvents(),
          ),
          ChangeNotifierProvider.value(
            value: UserEvents(),
          ),
          ChangeNotifierProvider.value(
            value: themeChangeProvider,
          ),
          ChangeNotifierProvider.value(
            value: languagesProvider,
          ),
          ChangeNotifierProvider.value(
            value: fontProvider,
          ),
        ],
        child: Consumer<DarkThemeProvider>(
            builder: (BuildContext context, theme, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Hijri-Reminder',
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Provider.of<LanguagesProvider>(context).locale,
            theme: Styles.themeData(theme.darkThemeStatus, context),
            home: AppHome(),
            routes: {
              PublicEventsScreen.routeName: (ctx) => PublicEventsScreen(),
              SettingsScreen.routeName: (ctx) => SettingsScreen(),
              AboutScreen.routeName: (ctx) => AboutScreen(),
            },
          );
        }));
  }
}
