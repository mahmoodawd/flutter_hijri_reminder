import 'package:hijri/hijri_calendar.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '../services/notifications_service.dart';
import '../providers/public_events.dart';
import '../providers/user_events.dart';

import '../widgets/event_widget.dart';
import '../widgets/animated_date_widget.dart';

class EventsScreen extends StatelessWidget {
  static const routeName = 'events-screen';

  @override
  Widget build(BuildContext context) {
    final events2Show = Provider.of<PublicEvents>(context, listen: false);
    final currentYear = HijriCalendar.now().hYear.toString();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Public events for $currentYear',
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: Provider.of<PublicEvents>(context, listen: false)
                .getAllEvents(),
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(child: CircularProgressIndicator())
                    : Consumer<PublicEvents>(
                        builder: (context, value, child) => ListView.builder(
                          itemCount: value.events.length,
                          itemBuilder: (BuildContext context, int index) {
                            final remainingDays =
                                events2Show.events[index].remainingDays;
                            bool isItemSaved =
                                Provider.of<UserEvents>(context, listen: false)
                                    .isExist(events2Show.events[index].eventId);
                            return EventWidget(
                              itemExist: isItemSaved,
                              date: AnimatedDateWidget(
                                primaryDate: '$remainingDays',
                                alternativeDate: events2Show.events[index].date!
                                    .toFormat("dd MMMM"),
                              ),
                              title: events2Show.events[index].title,
                              action: () => _saveEvent(
                                context,
                                events2Show.events[index].eventId,
                                events2Show.events[index].date!,
                                events2Show.events[index].title,
                              ),
                            );
                          },
                        ),
                      )));
  }

  void _saveEvent(BuildContext context, String? eventId, HijriCalendar eventDate,
      String? title) {
    Provider.of<UserEvents>(context, listen: false)
        .addNewEvent(eventId, eventDate, title, true);

    NotificationService().scheduleNotificationForEvent(title, eventDate);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Added to saved dates\n Navigate back to see it',
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 2),
    ));
  }
}
