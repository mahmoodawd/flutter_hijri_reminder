import 'package:flutter/material.dart';

class HeaderNavigator extends StatelessWidget {
  final String tooltip;
  final String destination;
  final IconData icon;
  HeaderNavigator(
      {Key? key,
      required this.tooltip,
      required this.icon,
      required this.destination})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        tooltip: tooltip,
        icon: Icon(icon),
        onPressed: () => Navigator.of(context).pushNamed(destination));
  }
}
