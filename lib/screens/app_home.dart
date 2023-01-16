import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import '../screens/about_screen.dart';
import '../screens/events_screen.dart';
import '../screens/saved_events.dart';
import '../screens/settings_screen.dart';
import '../widgets/app_home/header_navigator.dart';
import '../widgets/shared/custom_app_bar.dart';
import '../widgets/animated_date_widget.dart';
import '../widgets/app_home/create_event_button.dart';

class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Hijri Reminder',
        actions: [
          HeaderNavigator(
              tooltip: 'About',
              icon: Icons.info,
              destination: AboutScreen.routeName),
          HeaderNavigator(
              tooltip: 'Settings',
              icon: Icons.settings,
              destination: SettingsScreen.routeName),
          HeaderNavigator(
              tooltip: 'Public islamic events',
              icon: Icons.date_range_outlined,
              destination: EventsScreen.routeName),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedDateWidget(
              primaryDate: HijriCalendar.now().toFormat('dd MMMM, yyyy'),
              alternativeDate: DateFormat.yMMMMd().format(DateTime.now()),
            ),
            SavedEvents(),
          ],
        ),
      ),
      floatingActionButton: CreateEventButton(),
    );
  }
}
