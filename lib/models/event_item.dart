import 'package:flutter/foundation.dart';
import 'package:hijri/hijri_calendar.dart';

class EventItem {
  final String eventId;
  final HijriCalendar date;
  final String title;
  EventItem({
    @required this.eventId,
    @required this.date,
    @required this.title,
  });

  int get remainingDays {
    var eventDateInGregorian = HijriCalendar()
        .hijriToGregorian(this.date.hYear, this.date.hMonth, this.date.hDay);
    return int.parse(
        eventDateInGregorian.difference(DateTime.now()).inDays.toString());
  }
}

class UserEventItem extends EventItem {
  bool isNotified;

  UserEventItem({
    String eventId,
    HijriCalendar date,
    String title,
    bool isNotified,
  }) : super(eventId: eventId, date: date, title: title) {
    this.isNotified = isNotified;
  }
}
