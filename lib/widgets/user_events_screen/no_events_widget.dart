import 'package:flutter/material.dart';

import '../../services/language_preference.dart';

class NoEventsWidget extends StatelessWidget {
  const NoEventsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceOrientation = MediaQuery.of(context).orientation;

    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              translate(context)!.noEvents,
              softWrap: true,
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
        ]);
  }
}
