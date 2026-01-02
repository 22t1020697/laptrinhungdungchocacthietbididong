import 'package:flutter/material.dart';

class AddWaterButton extends StatelessWidget {
  final int amount;
  final VoidCallback onPressed;

  const AddWaterButton({
    super.key,
    required this.amount,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text("+ ${amount}ml"),
    );
  }
}
