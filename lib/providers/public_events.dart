import 'package:flutter/material.dart';
import '.././helpers/db_helper.dart';
import 'package:hijri/hijri_calendar.dart';

import '../models/event_item.dart';

class PublicEvents with ChangeNotifier {
  List<EventItem> _events = [];
  List<EventItem> get events {
    return [..._events];
  }

  Future<void> getAllEvents() async {
    final List<Map> eventList = await DBHelper.getData('public_events_tbl');
    _events = eventList
        .map((item) => EventItem(
              eventId: item['id'],
              date: HijriCalendar()
                ..hYear = item['event_year']
                ..hMonth = item['event_month']
                ..hDay = item['event_day'],
              title: item['title'],
            ))
        .toList();
    notifyListeners();
  }
}
