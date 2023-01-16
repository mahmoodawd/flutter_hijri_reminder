import 'package:hijri/hijri_calendar.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '../providers/user_events.dart';
import '../services/notifications_service.dart';

void showCustomSnakBar({
  required BuildContext context,
  required String message,
  SnackBarAction? action,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      textAlign: TextAlign.center,
    ),
    action: action,
  ));
}

void addNewEvent(BuildContext context, dynamic userEventItem) {
  Provider.of<UserEvents>(context, listen: false).addNewEvent(
      userEventItem.eventId, userEventItem.date, userEventItem.title, true);

  NotificationService()
      .scheduleNotificationForEvent(userEventItem.title, userEventItem.date);
}

HijriCalendar convert2hijri(DateTime gregorianDate) {
  final hijriiDate = new HijriCalendar.fromDate(gregorianDate);
  return hijriiDate;
}

DateTime convert2Greogrian(HijriCalendar hijriDate) {
  final gregorianDate = new HijriCalendar()
      .hijriToGregorian(hijriDate.hYear, hijriDate.hMonth, hijriDate.hDay);
  return gregorianDate;
}
