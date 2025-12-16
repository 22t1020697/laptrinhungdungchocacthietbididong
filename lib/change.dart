import 'dart:math';
import 'package:flutter/material.dart';

class ColorChangerPage extends StatefulWidget {
  const ColorChangerPage({super.key});

  @override
  State<ColorChangerPage> createState() => _ColorChangerPageState();
}

class _ColorChangerPageState extends State<ColorChangerPage> {
  // Biến để lưu trữ màu nền hiện tại
  Color _backgroundColor = Colors.purple;
  final Random _random = Random();

  // Hàm này sẽ được gọi khi nhấn nút
  void _changeColor() {
    // Tạo một màu ngẫu nhiên
    Color newColor = Color.fromARGB(
      255, // Alpha
      _random.nextInt(256), // Red
      _random.nextInt(256), // Green
      _random.nextInt(256), // Blue
    );

    // Dùng setState() để cập nhật lại màu nền
    setState(() {
      _backgroundColor = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('Ứng dụng Đổi màu nền'),
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.2),
        elevation: 0,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _changeColor,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text('Đổi màu'),
        ),
      ),
    );
  }
}
