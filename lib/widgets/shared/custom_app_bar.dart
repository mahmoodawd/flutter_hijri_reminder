import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  final List<Widget>? actions;

  CustomAppBar({Key? key, required this.title, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline1
              ?.copyWith(color: Colors.white, fontSize: 18),
        ),
        actions: actions);
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
