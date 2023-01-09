import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EventWidget extends StatefulWidget {
  bool itemExist;
  final String title;
  final Widget date;
  final VoidCallback action;

  EventWidget(
      {key,
      @required this.itemExist,
      @required this.date,
      this.title = 'No title given',
      @required this.action});

  @override
  _EventWidgetState createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
          title: Center(
            child: Text(
              this.widget.title,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              this.widget.itemExist ? Icons.done : Icons.add_circle,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: this.widget.itemExist
                ? null
                : () {
                    this.widget.action();
                    setState(
                      () {
                        this.widget.itemExist = true;
                      },
                    );
                  },
          ),
          leading: this.widget.date,
        ),
      ),
    );
  }
}
