import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '../services/notifications_service.dart';
import '../providers/user_events.dart';

import '../utils/shared_methods.dart';
import '../widgets/user_event_widget.dart';
import '../widgets/animated_date_widget.dart';
import '../widgets/user_events_screen/no_events_widget.dart';

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

    return Container(
      height: MediaQuery.of(context).size.height / 1.4,
      width: MediaQuery.of(context).size.width / .75,
      child: FutureBuilder(
          future: _userEventsSnippet.getAllEvents(),
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : Consumer<UserEvents>(
                  child: NoEventsWidget(),
                  builder: (context, value, child) => value.userEvents.isEmpty
                      ? child!
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
                                notifyStatus: currentItem.isNotified,
                                notificationAction: () =>
                                    _updateEventStatus(currentItem),
                                deletetionAction: () =>
                                    _deleteEvent(currentItem),
                              );
                            },
                          ),
                        ),
                )),
    );
  }

  _updateEventStatus(eventItem) {
    Provider.of<UserEvents>(context, listen: false)
        .updateEvent(eventItem.eventId, !eventItem.isNotified!);
    eventItem.isNotified!
        ? NotificationService()
            .scheduleNotificationForEvent(eventItem.title, eventItem.date)
        : NotificationService().cancelNotification(eventItem.date.hashCode);

    showCustomSnakBar(
      context: context,
      message: !eventItem.isNotified!
          ? 'Notification cancelled'
          : 'You will be notified for ' + eventItem.title,
    );
  }

  _deleteEvent(eventItem) {
    Provider.of<UserEvents>(context, listen: false)
        .removeEvent(eventItem.eventId);
    NotificationService().cancelNotification(eventItem.date.hashCode);
    showCustomSnakBar(
      context: context,
      message: 'Event Deleted!',
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () => addNewEvent(context, eventItem),
      ),
    );
  }
}
