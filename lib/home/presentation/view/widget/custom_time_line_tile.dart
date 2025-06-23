import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CustomTimeLineTile extends StatelessWidget {
  const CustomTimeLineTile({
    super.key,
    this.isFirst = false,
    this.isLast = false,
    required this.isDone,
    required this.title,
    required this.isLeft,
  });

  final bool isFirst;
  final bool isLast;
  final bool isDone;
  final String title;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: TimelineTile(
        alignment: TimelineAlign.center,
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
          color: isDone ? Colors.deepPurple : Colors.blueGrey,
        ),
        indicatorStyle: IndicatorStyle(
          color: isDone ? Colors.deepPurple : Colors.blueGrey,
          width: 40,
          iconStyle: IconStyle(iconData: Icons.check, color: Colors.white),
        ),
        startChild: isLeft
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  textAlign: TextAlign.end,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
            : null,
        endChild: !isLeft
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
            : null,
      ),
    );
  }
}
