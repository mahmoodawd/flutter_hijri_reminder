import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EventWidget extends StatefulWidget {
  bool itemExist;
  final String title;
  final Widget date;
  final VoidCallback action;
  final String subtitle;

  EventWidget(
      {key,
      required this.itemExist,
      required this.date,
      required this.title,
      required this.subtitle,
      required this.action});

  @override
  _EventWidgetState createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5.0,
          margin: EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            title: Center(
              child: Text(
                this.widget.title,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            subtitle: Center(
              child: Text(
                this.widget.subtitle,
                style: Theme.of(context).textTheme.subtitle1,
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
      ),
    );
  }
}
