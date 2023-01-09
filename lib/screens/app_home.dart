import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '../services/notifications_service.dart';
import '../providers/user_events.dart';

import '../widgets/animated_date_widget.dart';
import '../widgets/dialog_widget.dart';
import '../screens/events_screen.dart';
import 'saved_events.dart';
import '../screens/settings_screen.dart';

class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  String _eventTitle;
  DateTime _choosenDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final hijriAppBar = AppBar(
      title: Text(
        'Hijri Reminder',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
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
              primaryDate: HijriCalendar.now().toFormat('dd MMMM  yyyy'),
              alternativeDate: DateFormat.yMMMMd().format(DateTime.now()),
            ),
            SavedEvents(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).primaryColor,
        label: Text(
          'Pick a Date',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.date_range,
          color: Colors.white,
          size: 40,
        ),
        onPressed: () {
          _selectDate(context);
        },
      ),
    );
  }

  String convert2hijri(DateTime gregorianDate) {
    final hijriiDate = new HijriCalendar.fromDate(gregorianDate);
    return hijriiDate.toFormat('dd MMMM yyyy');
  }

  void _saveAndClose() {
    final hijriDate = new HijriCalendar.fromDate(_choosenDate);
    final eventId = DateTime.now().toString();
    Provider.of<UserEvents>(context, listen: false).addNewEvent(eventId,
        hijriDate, _eventTitle == null ? 'Untitled' : _eventTitle, true);
    NotificationService().scheduleNotificationForEvent(_eventTitle, hijriDate);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Added to saved dates',
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 2),
    ));
  }

  Future<void> _showDialogAndGetTitle() {
    final String _hijri = convert2hijri(_choosenDate);
    return showDialog(
      context: context,
      builder: (context) {
        return DialogWidget(
          hijriDate: _hijri, //to be shown
          onSubmit: _saveAndClose, //to be saved
          onTitleChanged: (newTitle) => _eventTitle = newTitle,
        );
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _choosenDate != null ? _choosenDate : DateTime.now(),
      firstDate: DateTime(1937, 3, 14),
      lastDate: DateTime(2027, 11, 16),
    );

    if (newSelectedDate != null) {
      _choosenDate = newSelectedDate;
      _showDialogAndGetTitle();
    }
  }
}
