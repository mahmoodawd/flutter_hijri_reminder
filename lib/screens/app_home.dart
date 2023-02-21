import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import '../services/language_preference.dart';

import '../screens/about_screen.dart';
import '../screens/public_events_screen.dart';
import '../screens/saved_events_screen.dart';
import '../screens/settings_screen.dart';
import '../widgets/app_home/header_navigator.dart';
import '../widgets/shared/custom_app_bar.dart';
import '../widgets/shared/animated_date_widget.dart';
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
        title: translate(context)!.home,
        actions: [
          HeaderNavigator(
              tooltip: translate(context)!.about,
              icon: Icons.info,
              destination: AboutScreen.routeName),
          HeaderNavigator(
              tooltip: translate(context)!.settings,
              icon: Icons.settings,
              destination: SettingsScreen.routeName),
          HeaderNavigator(
              tooltip: translate(context)!.publicEvents,
              icon: Icons.date_range_outlined,
              destination: PublicEventsScreen.routeName),
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
            SavedEventsScreen(),
          ],
        ),
      ),
      floatingActionButton: CreateEventButton(),
    );
  }
}
