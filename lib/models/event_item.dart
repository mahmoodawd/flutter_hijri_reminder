import 'package:flutter/foundation.dart';
import 'package:hijri/hijri_calendar.dart';

class EventItem {
  final String eventId;
  final HijriCalendar date;
  final String title;
  int daysRemain;

  EventItem({
    @required this.eventId,
    @required this.date,
    @required this.title,
  }) {
    _calcRemainingDays();
  }

  _calcRemainingDays() {
    var eventDateInGregorian = HijriCalendar()
        .hijriToGregorian(this.date.hYear, this.date.hMonth, this.date.hDay);
    int diffInDays = eventDateInGregorian.difference(DateTime.now()).inDays;
    if (diffInDays == 0 && DateTime.now().day < eventDateInGregorian.day) {
      diffInDays = 1;
    } else if (diffInDays == 0 &&
        DateTime.now().day > eventDateInGregorian.day) {
      diffInDays = -1;
    }
    print(" difference for $title : $diffInDays");
    daysRemain = diffInDays;
  }

  String get remainingDays {
    String equivelentString = '';
    switch (daysRemain) {
      case (0):
        equivelentString = 'today';
        break;
      case (-1):
        equivelentString = 'Yesterday';
        break;
      case (1):
        equivelentString = 'tommorow';
        break;
      default:
        if (daysRemain > 0) {
          equivelentString = 'in $daysRemain days';
        } else {
          equivelentString = 'Gone';
        }
    }
    return equivelentString;
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
