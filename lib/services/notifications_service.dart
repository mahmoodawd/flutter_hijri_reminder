import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../utils/shared_methods.dart';

const String events_channel_id = '2023';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  int id = 0;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    _configureLocalTimeZone();

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _notificationTapForeground,
      onDidReceiveBackgroundNotificationResponse: _notificationTapBackground,
    );
  }

  void _configureLocalTimeZone() {
    tz.initializeTimeZones();
    DateTime dateTime = DateTime.now();
    final String timeZoneName = dateTime.timeZoneName;
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> scheduleNotificationForEvent(
      String? eventTitle, HijriCalendar eventHjriDate) async {
    DateTime eventGregorianDate = convert2Greogrian(eventHjriDate);
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    if (eventHjriDate.hYear < HijriCalendar.now().hYear) {
      eventHjriDate.hYear = HijriCalendar.now().hYear;
      eventGregorianDate = convert2Greogrian(eventHjriDate);
    }

    Duration difference = eventGregorianDate.difference(now);
    if (difference.inDays == 0 && now.day == eventGregorianDate.day) {
      _showNotification(eventTitle, eventHjriDate);
      return;
    }

    if (difference.inDays.isNegative) {
      eventGregorianDate = _addOneMoreHijriYear(eventHjriDate);
    }
    _scheduleNotification(eventHjriDate, eventTitle, eventGregorianDate);
    print('Notification schduled to $eventGregorianDate');
  }

  void _showNotification(
      String? eventTitle, HijriCalendar eventHjriDate) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      events_channel_id,
      'Saved Events',
      channelDescription: 'Events saved by user',
      priority: Priority.max,
      ticker: 'ticker',
    );
    await flutterLocalNotificationsPlugin.show(
      eventHjriDate.hashCode,
      eventHjriDate.toFormat("dd MMMM"),
      // translate(_).notificationBody,
      'Today is $eventTitle',
      const NotificationDetails(android: androidNotificationDetails),
      payload: 'item$id',
    );
  }

  Future<void> _scheduleNotification(
    HijriCalendar eventHjriDate,
    String? eventTitle,
    DateTime eventGregorianDate,
  ) async {
    const androidNotificationDetails = AndroidNotificationDetails(
        events_channel_id, 'Saved Events',
        channelDescription: 'Events saved by user',
        priority: Priority.max,
        ticker: 'ticker');
    await flutterLocalNotificationsPlugin.zonedSchedule(
        eventHjriDate.hashCode,
        eventHjriDate.toFormat("dd MMMM"),
        'Today is $eventTitle',
        tz.TZDateTime.from(eventGregorianDate, tz.local),
        const NotificationDetails(android: androidNotificationDetails),
        payload: 'item$id',
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future _notificationTapForeground(NotificationResponse payload) async {
    print('Foreground Notification tapped');
  }

  static void _notificationTapBackground(
      NotificationResponse notificationResponse) {
    print('Background Notification tapped');
  }

  _addOneMoreHijriYear(HijriCalendar eventHijriDate) {
    eventHijriDate.hYear += 1;
    final correctedDate = convert2Greogrian(eventHijriDate);
    return correctedDate;
  }
}
