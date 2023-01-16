import 'event_item.dart';

class UserEventItem extends EventItem {
  bool? isNotified;

  UserEventItem({
    required eventId,
    required date,
    required title,
    required isNotified,
  }) : super(eventId: eventId, date: date, title: title) {
    this.isNotified = isNotified;
  }
}
