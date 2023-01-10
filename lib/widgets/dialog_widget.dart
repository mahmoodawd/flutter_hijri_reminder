import 'package:flutter/material.dart';

class DialogWidget extends StatefulWidget {
  final String hijriDate;
  final Function onSubmit;
  final ValueChanged<String> onTitleChanged;
  DialogWidget(
      {@required this.hijriDate, @required this.onSubmit, this.onTitleChanged});

  @override
  _DialogWidgetState createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      content: Column(
        children: [
          Text(
            widget.hijriDate,
          ),
          TextFormField(
              controller: _titleController,
              maxLines: 1,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(hintText: 'Title'),
              onChanged: (title) {
                widget.onTitleChanged(title);
              }),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        TextButton(
            child: Text('Save'),
            onPressed: () {
              widget.onSubmit();
              Navigator.of(context).pop(_titleController.text);
            }),
      ],
    );
  }
}
