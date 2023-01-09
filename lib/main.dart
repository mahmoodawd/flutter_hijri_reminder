import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import 'services/notifications_service.dart';
import 'providers/theme.dart';
import 'providers/user_events.dart';
import 'providers/public_events.dart';
import 'shared/constants.dart';

import 'screens/settings_screen.dart';
import 'screens/events_screen.dart';
import 'screens/app_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
          value: ThemeChanger(ThemeMode.system),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hijri-Reminder',
        theme: ThemeData(
          primarySwatch: lightModePrimaryColor,
          iconTheme: IconThemeData(color: lightModePrimaryColor),
          fontFamily: 'Rakkas',
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: lightModePrimaryColor,
            ),
            bodyText2: TextStyle(
              color: lightModePrimaryColor,
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.grey,
          buttonTheme: ButtonThemeData(
            buttonColor: darkModePrimaryColor,
            highlightColor: Colors.white,
            textTheme: ButtonTextTheme.primary,
          ),
          fontFamily: 'Rakkas',
          textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
            bodyText2: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        // themeMode: Provider.of<ThemeChanger>(context).getTheme(),
        themeMode: ThemeMode.light,
        home: AppHome(),
        routes: {
          EventsScreen.routeName: (ctx) => EventsScreen(),
          // SavedEventsScreen.routeName: (ctx) => SavedEventsScreen(),
          SettingsScreen.routeName: (ctx) => SettingsScreen(),
        },
      ),
    );
  }
}
