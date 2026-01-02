import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String code;
  final String students;
  final Color bgColor;

  const CourseCard({
    super.key,
    required this.title,
    required this.code,
    required this.students,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(code,
                style: const TextStyle(color: Colors.white70, fontSize: 14)),
            const Spacer(),
            Text(students,
                style: const TextStyle(color: Colors.white, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
