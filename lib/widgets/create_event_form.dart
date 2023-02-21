import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import '../models/user_event_item.dart';
import '../services/language_preference.dart';
import '../utils/shared_methods.dart';

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
        translate(context)!.createEvent,
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
                    hintText: translate(context)!.title,
                    border: outlineInputBorder,
                    prefixIcon: Icon(Icons.edit),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return translate(context)!.titleHint;
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
                  hintText: translate(context)!.pickDate,
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
                      ? convert2hijri(pickedDate!).toFormat('dd MMMM, yyyy')
                      : translate(context)!.hijriDateHint,
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
            child: Text(translate(context)!.cancel),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        TextButton(
          child: Text(translate(context)!.save),
          onPressed: () => _addNewEvent(),
        ),
      ],
    );
  }

  void _addNewEvent() {
    {
      if (_eventCreationFormKey.currentState!.validate()) {
        _eventCreationFormKey.currentState!.save();
        final hijriDate = convert2hijri(pickedDate!);
        String title = _titleController.text;
        final eventId = hijriDate.hashCode.toString();
        UserEventItem item = UserEventItem(
            eventId: eventId, date: hijriDate, title: title, isNotified: true);
        addNewEvent(context, item);
        Navigator.of(context).pop();
        showCustomSnakBar(
          context: context,
          message: translate(context)!.saved,
        );
      }
    }
  }
}
