import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/user_events.dart';
import '../services/notifications_service.dart';

class CreateEventForm extends StatefulWidget {
  const CreateEventForm({Key? key}) : super(key: key);

  @override
  State<CreateEventForm> createState() => _CreateEventFormState();
}

class _CreateEventFormState extends State<CreateEventForm> {
  static final GlobalKey<FormState> _eventCreationFormKey =
      GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  DateTime? pickedDate;

  @override
  Widget build(BuildContext context) {
    const outlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    );
    return AlertDialog(
      title: Text(
        'Create New Event',
        style: Theme.of(context).textTheme.bodyText2,
      ),
      content: Form(
        key: _eventCreationFormKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: _titleController,
                  maxLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: outlineInputBorder,
                    prefixIcon: Icon(Icons.edit),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _titleController.text = value!;
                  }),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Pick Date',
                  border: outlineInputBorder,
                  prefixIcon: Icon(Icons.calendar_month),
                ),
                controller: _dateController,
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pick Date';
                  }
                  return null;
                },
                onTap: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1937, 3, 14),
                    lastDate: DateTime(2027, 11, 16),
                  );

                  if (pickedDate != null) {
                    _dateController.text =
                        DateFormat.yMMMMd().format(pickedDate!);
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  enabled: false,
                  hintText: pickedDate != null
                      ? _convert2hijri(pickedDate!)
                      : 'Hijri Date will go here',
                  border: outlineInputBorder,
                  prefixIcon: Icon(Icons.calendar_today),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        TextButton(
            child: Text('Save'),
            onPressed: () {
              if (_eventCreationFormKey.currentState!.validate()) {
                _eventCreationFormKey.currentState!.save();
                _addNewEvent();
                Navigator.of(context).pop();
              }
            }),
      ],
    );
  }

  void _addNewEvent() {
    final hijriDate = new HijriCalendar.fromDate(pickedDate!);
    String title = _titleController.text;

    final eventId = DateTime.now().toString();
    Provider.of<UserEvents>(context, listen: false)
        .addNewEvent(eventId, hijriDate, title, true);
    NotificationService().scheduleNotificationForEvent(title, hijriDate);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Added to saved dates',
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 2),
    ));
  }

  String _convert2hijri(DateTime gregorianDate) {
    final hijriiDate = new HijriCalendar.fromDate(gregorianDate);
    return hijriiDate.toFormat('MM dd,yyyy');
  }
}
