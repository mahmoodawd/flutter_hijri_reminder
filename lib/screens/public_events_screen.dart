import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '../providers/public_events.dart';
import '../providers/user_events.dart';

import '../services/language_preference.dart';
import '../utils/shared_methods.dart';
import '../widgets/events_screen/event_widget.dart';
import '../widgets/shared/animated_date_widget.dart';
import '../widgets/shared/custom_app_bar.dart';

class PublicEventsScreen extends StatelessWidget {
  static const routeName = 'events-screen';

  @override
  Widget build(BuildContext context) {
    final currentYear = HijriCalendar.now().hYear.toString();

    return Scaffold(
        appBar: CustomAppBar(
          title: translate(context)!.publicEvents +
              ' ' +
              translate(context)!.forYear +
              ' ' +
              currentYear,
        ),
        body: FutureBuilder(
            future: Provider.of<PublicEvents>(context, listen: false)
                .getAllEvents(),
            builder: (context, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<PublicEvents>(
                    builder: (context, value, child) => ListView.builder(
                      itemCount: value.events.length,
                      itemBuilder: (BuildContext context, int index) {
                        final currentItem = value.events[index];
                        bool isItemSaved =
                            Provider.of<UserEvents>(context, listen: false)
                                .isExist(currentItem.eventId);
                        return EventWidget(
                            itemExist: isItemSaved,
                            date: AnimatedDateWidget(
                              primaryDate: translate(context)!
                                  .remainingDays(currentItem.remainingDays),
                              alternativeDate: DateFormat.MMMEd()
                                  .format(convert2Greogrian(currentItem.date)),
                            ),
                            title: translate(context)!
                                .publicIslamicEvents(currentItem.title),
                            subtitle: currentItem.date.toFormat("dd MMMM"),
                            action: () {
                              addNewEvent(context, currentItem,
                                  translateTitle: true);
                              showCustomSnakBar(
                                  context: context,
                                  message: translate(context)!.saved +
                                      '\n' +
                                      translate(context)!.navBack);
                            });
                      },
                    ),
                  )));
  }
}
