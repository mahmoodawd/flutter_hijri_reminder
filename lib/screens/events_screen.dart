import 'package:hijri/hijri_calendar.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '../providers/public_events.dart';
import '../providers/user_events.dart';

import '../utils/shared_methods.dart';
import '../widgets/events_screen/event_widget.dart';
import '../widgets/shared/animated_date_widget.dart';
import '../widgets/shared/custom_app_bar.dart';

class EventsScreen extends StatelessWidget {
  static const routeName = 'events-screen';

  @override
  Widget build(BuildContext context) {
    final events2Show = Provider.of<PublicEvents>(context, listen: false);
    final currentYear = HijriCalendar.now().hYear.toString();

    return Scaffold(
        appBar: CustomAppBar(title: 'Public events for $currentYear'),
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
                            final currentItem = events2Show.events[index];
                            bool isItemSaved =
                                Provider.of<UserEvents>(context, listen: false)
                                    .isExist(currentItem.eventId);
                            return EventWidget(
                                itemExist: isItemSaved,
                                date: AnimatedDateWidget(
                                  primaryDate: currentItem.remainingDays,
                                  alternativeDate:
                                      currentItem.date.toFormat("dd MMMM"),
                                ),
                                title: currentItem.title,
                                action: () {
                                  addNewEvent(context, currentItem);
                                  showCustomSnakBar(
                                      context: context,
                                      message:
                                          'Added to saved dates\n Navigate back to see it');
                                });
                          },
                        ),
                      )));
  }
}
