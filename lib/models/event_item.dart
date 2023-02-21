import 'package:hijri/hijri_calendar.dart';

import '../utils/shared_methods.dart';

class EventItem {
  final String eventId;
  final HijriCalendar date;
  final String title;
  late int daysRemain;

  EventItem({
    required this.eventId,
    required this.date,
    required this.title,
  }) {
    _calcRemainingDays();
  }

  String get remainingDays {
    String equivelentString = '';
    switch (daysRemain) {
      case (0):
        equivelentString = 'today';
        break;
      case (-1):
        equivelentString = 'yesterday';
        break;
      case (1):
        equivelentString = 'tommorow';
        break;
      default:
        if (daysRemain > 0) {
          equivelentString = '$daysRemain';
        } else {
          equivelentString = 'gone';
        }
    }
    return equivelentString;
  }

  _calcRemainingDays() {
    var eventDateInGregorian = convert2Greogrian(date);
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
}
