import 'package:flutter/foundation.dart';
import 'package:hijri/hijri_calendar.dart';

import '../helpers/db_helper.dart';
import '../models/event_item.dart';

class UserEvents with ChangeNotifier {
  List<UserEventItem> _userEvents = [];

  List<UserEventItem> get userEvents => [..._userEvents.reversed];

  Future<void> addNewEvent(String eventId, HijriCalendar date, String title,
      bool notificationStatus) async {
    _userEvents.add(UserEventItem(
        eventId: eventId,
        date: date,
        title: title,
        isNotified: notificationStatus));
    notifyListeners();
    DBHelper.insert('user_events_tbl', {
      'id': eventId,
      'title': title,
      'event_day': date.hDay,
      'event_month': date.hMonth,
      'event_year': date.hYear,
      'is_notified': notificationStatus ? 1 : 0,
    });
  }

  Future<void> removeEvent(String eventId) async {
    _userEvents.removeWhere((element) => element.eventId == eventId);
    notifyListeners();
    DBHelper.delete('user_events_tbl', eventId);
  }

  Future<void> updateEvent(String eventId, bool notificationStatus) async {
    _userEvents.forEach((element) {
      if (element.eventId == eventId) {
        element.isNotified = notificationStatus;
      }
    });
    notifyListeners();
    DBHelper.update(
        'user_events_tbl',
        {
          'is_notified': notificationStatus ? 1 : 0,
        },
        eventId);
  }

  Future<void> getAllEvents() async {
    final List<Map> eventList = await DBHelper.getData('user_events_tbl');
    _userEvents = eventList
        .map(
          (item) => UserEventItem(
              eventId: item['id'],
              date: HijriCalendar()
                ..hYear = item['event_year']
                ..hMonth = item['event_month']
                ..hDay = item['event_day'],
              title: item['title'],
              isNotified: item['is_notified'] == 1 ? true : false),
        )
        .toList();
    notifyListeners();
  }

  bool isExist(String eventId) {
    return _userEvents.any((element) => element.eventId == eventId);
  }

  bool isItemNotified(String eventId) {
    var item = _userEvents.firstWhere((element) => element.eventId == eventId);
    return item.isNotified;
  }
}
