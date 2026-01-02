import 'package:flutter/material.dart';

class WaterProgress extends StatelessWidget {
  final double progress;

  const WaterProgress({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: progress),
      duration: const Duration(milliseconds: 800),
      builder: (context, value, child) {
        return Column(
          children: [
            Icon(Icons.local_drink,
                size: 120, color: Colors.blue.withOpacity(value)),
            Text("${(value * 100).toInt()}%"),
          ],
        );
      },
    );
  }
}
