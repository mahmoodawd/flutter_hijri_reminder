import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import 'services/notifications_service.dart';
import 'providers/theme.dart';
import 'providers/user_events.dart';
import 'providers/public_events.dart';

import 'utils/styles.dart';
import 'screens/app_home.dart';
import 'screens/events_screen.dart';
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

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkThemeStatus =
        await themeChangeProvider.darkThemePreference.getDarkThemeStatus();
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
        ],
        child: Consumer<DarkThemeProvider>(
            builder: (BuildContext context, theme, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Hijri-Reminder',
            theme: Styles.themeData(theme.darkThemeStatus, context),
            home: AppHome(),
            routes: {
              EventsScreen.routeName: (ctx) => EventsScreen(),
              SettingsScreen.routeName: (ctx) => SettingsScreen(),
              AboutScreen.routeName: (ctx) => AboutScreen(),
            },
          );
        }));
  }
}
