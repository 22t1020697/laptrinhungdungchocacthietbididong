import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../services/bmi_calculator.dart';

class BmiScreen extends StatelessWidget {
  final UserProfile user;

  const BmiScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final bmiResult =
        BmiCalculator.calculate(user.weight, user.height);

    return Scaffold(
      backgroundColor: const Color(0xFFE1F5FE), // xanh pastel
      appBar: AppBar(
        title: const Text('Chỉ số BMI'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFFFEBEE), // hồng nhạt
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.pink.withOpacity(0.25),
                blurRadius: 25,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.monitor_weight,
                  size: 50, color: Colors.pink),
              const SizedBox(height: 12),

              Text(
                bmiResult.bmi.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                bmiResult.status,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                bmiResult.advice,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
