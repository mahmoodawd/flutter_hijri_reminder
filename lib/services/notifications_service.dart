// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, avoid_print

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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
      onDidReceiveNotificationResponse: notificationTapForeground,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  void _configureLocalTimeZone() {
    tz.initializeTimeZones();
    DateTime dateTime = DateTime.now();
    final String timeZoneName = dateTime.timeZoneName;
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> scheduleNotificationForEvent(
      String eventTitle, HijriCalendar eventHjriDate) async {
    DateTime eventGregorianDate = HijriCalendar().hijriToGregorian(
        eventHjriDate.hYear, eventHjriDate.hMonth, eventHjriDate.hDay);
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    if (eventHjriDate.hYear < HijriCalendar.now().hYear) {
      eventGregorianDate = HijriCalendar().hijriToGregorian(
          HijriCalendar.now().hYear, eventHjriDate.hMonth, eventHjriDate.hDay);
    }

    Duration difference = eventGregorianDate.difference(now);
    if (difference.inDays.isNegative) {
      eventGregorianDate = addOneMoreHijriYear(eventHjriDate);
    }
    if (difference.inDays == 0 && now.day == eventGregorianDate.day) {
      showNotification(eventTitle, eventHjriDate);
      return;
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
        eventHjriDate.hashCode,
        eventHjriDate.toFormat("dd MMMM"),
        'Today is $eventTitle',
        tz.TZDateTime.from(eventGregorianDate, tz.local),
        const NotificationDetails(
            android: const AndroidNotificationDetails(
          events_channel_id,
          'Saved Events',
          channelDescription: 'Events saved by user',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        )),
        payload: 'item$id',
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
    print('Notification schduled to $eventGregorianDate');
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future notificationTapForeground(NotificationResponse payload) async {
    print('Foreground Notification tapped');
  }

  static void notificationTapBackground(
      NotificationResponse notificationResponse) {
    print('Background Notification tapped');
  }

  void showNotification(String eventTitle, HijriCalendar eventHjriDate) async {
    await flutterLocalNotificationsPlugin.show(
      eventTitle.hashCode,
      eventHjriDate.toFormat("dd MMMM"),
      'Today is $eventTitle',
      const NotificationDetails(
          android: const AndroidNotificationDetails(
        events_channel_id,
        'Saved Events',
        channelDescription: 'Events saved by user',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      )),
      payload: 'item$id',
    );
  }

  addOneMoreHijriYear(HijriCalendar eventHijriDate) {
    eventHijriDate.hYear += 1;
    final correctedDate = HijriCalendar().hijriToGregorian(
        eventHijriDate.hYear, eventHijriDate.hMonth, eventHijriDate.hDay);
    return correctedDate;
  }
}
