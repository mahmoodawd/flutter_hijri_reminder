import 'package:hijri/hijri_calendar.dart';
import 'package:hijri_reminder/screens/about_screen.dart';
import 'package:hijri_reminder/widgets/create_event_form.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import '../widgets/animated_date_widget.dart';
import '../screens/events_screen.dart';
import 'saved_events.dart';
import '../screens/settings_screen.dart';

class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  @override
  Widget build(BuildContext context) {
    final hijriAppBar = AppBar(
      title: Text(
        'Hijri Reminder',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
            tooltip: 'About',
            icon: Icon(Icons.info),
            onPressed: () =>
                Navigator.of(context).pushNamed(AboutScreen.routeName)),
        IconButton(
          tooltip: 'Settings',
          icon: Icon(Icons.settings),
          onPressed: () =>
              Navigator.of(context).pushNamed(SettingsScreen.routeName),
        ),
        IconButton(
          tooltip: 'Public islamic events',
          icon: Icon(Icons.date_range_outlined),
          onPressed: () =>
              Navigator.of(context).pushNamed(EventsScreen.routeName),
        ),
      ],
    );

    return Scaffold(
      appBar: hijriAppBar,
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
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).primaryColor,
          label: Text(
            'Create Event',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.date_range,
            color: Colors.white,
            size: 40,
          ),
          onPressed: () => showDialog(
                context: context,
                builder: (context) => CreateEventForm(),
              )),
    );
  }
}
