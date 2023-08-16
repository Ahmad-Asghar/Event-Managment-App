import 'package:flutter/material.dart';

class ProgressTimeline extends StatelessWidget {
  final double progress;
  final Color color;
  const ProgressTimeline({Key? key, required this.progress, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: LinearProgressIndicator(
          backgroundColor: Colors.grey[300],
          color: color,
          value:progress,
        ),
      ),
    );
  }
}