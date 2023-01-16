import 'package:flutter/material.dart';

class AnimatedDateWidget extends StatefulWidget {
  final String primaryDate;
  final String alternativeDate;
  AnimatedDateWidget(
      {key, required this.primaryDate, required this.alternativeDate})
      : super(key: key);

  @override
  _AnimatedDateWidgetState createState() => _AnimatedDateWidgetState();
}

class _AnimatedDateWidgetState extends State<AnimatedDateWidget> {
  bool _toggleDate = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _toggleDate = !_toggleDate;
          print('Date Toggled $_toggleDate');
        });
      },
      child: AnimatedContainer(
        padding: const EdgeInsets.all(15),
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut, //animation style
        child: Text(
          !_toggleDate ? widget.primaryDate : widget.alternativeDate,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.normal,
              ),
        ),
      ),
    );
    // );
  }
}
