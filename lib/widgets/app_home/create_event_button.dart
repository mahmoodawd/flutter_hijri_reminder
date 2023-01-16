import 'package:flutter/material.dart';

import '../create_event_form.dart';

class CreateEventButton extends StatelessWidget {
  const CreateEventButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        label: Text(
          'Create Event',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.date_range,
          color: Colors.white,
          size: 40,
        ),
        onPressed: () => showDialog(
              context: context,
              builder: (context) => CreateEventForm(),
            ));
  }
}
