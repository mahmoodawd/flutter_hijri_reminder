import 'package:flutter/material.dart';

class UserEventWidget extends StatelessWidget {
  final bool? notifyStatus;
  final String? title;
  final Widget date;
  final VoidCallback deletetionAction, notificationAction;

  UserEventWidget(
      {key,
      required this.date,
      this.title = 'No title given',
      required this.notificationAction,
      required this.deletetionAction,
      required this.notifyStatus});

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
              this.title!,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: this.notificationAction,
                icon: !this.notifyStatus!
                    ? Icon(
                        Icons.notifications_off_outlined,
                        color:
                            Theme.of(context).iconTheme.color!.withOpacity(0.6),
                      )
                    : Icon(
                        Icons.notifications_active,
                        color: Theme.of(context).iconTheme.color,
                      ),
              ),
              IconButton(
                  onPressed: this.deletetionAction,
                  highlightColor: Color.fromARGB(255, 240, 106, 126),
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))
            ],
          ),
          leading: this.date,
        ),
      ),
    );
  }
}
