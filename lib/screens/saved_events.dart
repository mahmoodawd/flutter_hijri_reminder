import 'package:hijri/hijri_calendar.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '../services/notifications_service.dart';
import '../providers/user_events.dart';

import '../widgets/user_event_widget.dart';
import '../widgets/animated_date_widget.dart';

class SavedEvents extends StatefulWidget {
  static const routeName = 'saved-events-screen';

  SavedEvents({key}) : super(key: key);

  @override
  _SavedEvent createState() => _SavedEvent();
}

class _SavedEvent extends State<SavedEvents> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final _userEventsSnippet = Provider.of<UserEvents>(context, listen: false);
    final deviceOrientation = MediaQuery.of(context).orientation;

    return Container(
      height: MediaQuery.of(context).size.height / 1.4,
      width: MediaQuery.of(context).size.width / .75,
      child: FutureBuilder(
          future: _userEventsSnippet.getAllEvents(),
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : Consumer<UserEvents>(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Text(
                            'No saved Events yet!',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                        deviceOrientation == Orientation.portrait
                            ? Image.asset(
                                'assets/images/app_icon.png',
                                fit: BoxFit.contain,
                                alignment: Alignment.center,
                                height: 300,
                              )
                            : Container(),
                      ]),
                  builder: (context, value, child) => value.userEvents.isEmpty
                      ? child
                      : Scrollbar(
                          interactive: true,
                          controller: _scrollController,
                          thickness: 15,
                          radius: Radius.circular(10),
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: value.userEvents.length,
                            itemBuilder: (BuildContext context, int index) {
                              final currentItem = value.userEvents[index];
                              return UserEventWidget(
                                title: currentItem.title,
                                date: AnimatedDateWidget(
                                  primaryDate: currentItem.remainingDays,
                                  alternativeDate:
                                      currentItem.date.toFormat("dd MM"),
                                ),
                                notificationAction: () {
                                  value.updateEvent(currentItem.eventId,
                                      !currentItem.isNotified);
                                  if (currentItem.isNotified) {
                                    NotificationService()
                                        .scheduleNotificationForEvent(
                                            currentItem.title,
                                            currentItem.date);
                                  } else {
                                    NotificationService().cancelNotification(
                                        currentItem.date.hashCode);
                                  }

                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      !currentItem.isNotified
                                          ? 'Notification cancelled'
                                          : 'You will be notified for ' +
                                              currentItem.title,
                                      textAlign: TextAlign.center,
                                    ),
                                    duration: Duration(seconds: 2),
                                  ));
                                },
                                deletetionAction: () {
                                  final date = HijriCalendar().hijriToGregorian(
                                      currentItem.date.hYear,
                                      currentItem.date.hMonth,
                                      currentItem.date.hDay);
                                  value.removeEvent(
                                      value.userEvents[index].eventId);
                                  NotificationService()
                                      .cancelNotification(date.hashCode);

                                  _showSnackBar(context, () {
                                    value.addNewEvent(
                                        currentItem.eventId,
                                        currentItem.date,
                                        currentItem.title,
                                        true);
                                  });
                                },
                                notifyStatus: currentItem.isNotified,
                              );
                            },
                          ),
                        ),
                )),
    );
  }

  void _showSnackBar(
    BuildContext context,
    Function action,
  ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Event Deleted!'),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: action,
      ),
    ));
  }
}
