import 'dart:async';
import 'package:flutter/material.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController minuteController = TextEditingController();
  Timer? _timer;

  int remainingSeconds = 0;
  bool isRunning = false;
  bool timeUp = false;

  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _shakeAnimation = Tween<double>(begin: -8, end: 8)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_shakeController);
  }

  void _startTimer() {
    if (minuteController.text.isEmpty) return;

    final minutes = int.parse(minuteController.text);
    remainingSeconds = minutes * 60;
    timeUp = false;

    _timer?.cancel();

    setState(() => isRunning = true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingSeconds > 0) {
          remainingSeconds--;
        } else {
          timer.cancel();
          isRunning = false;
          timeUp = true;
          _shakeController.repeat(reverse: true);
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _shakeController.stop();
    setState(() {
      isRunning = false;
      timeUp = false;
    });
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _shakeController.dispose();
    minuteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 🎨 MÀU CHUẨN PASTEL
    const backgroundBlue = Color(0xFFE1F5FE);
    const cardPink = Color(0xFFFFEBEE);
    const accentBlue = Color(0xFF4FC3F7);
    const accentPink = Color(0xFFF48FB1);

    return Scaffold(
      backgroundColor: backgroundBlue,
      appBar: AppBar(
        backgroundColor: backgroundBlue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Hẹn giờ uống nước',
          style: TextStyle(color: accentBlue),
        ),
        iconTheme: const IconThemeData(color: accentBlue),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: cardPink,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: accentPink.withOpacity(0.35),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ICON ĐỒNG HỒ
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [accentPink, accentBlue],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: accentBlue.withOpacity(0.6),
                      blurRadius: 25,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.timer,
                  size: 70,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              // THÔNG BÁO HẾT GIỜ (LẮC)
              if (timeUp)
                AnimatedBuilder(
                  animation: _shakeAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_shakeAnimation.value, 0),
                      child: child,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [accentPink, accentBlue],
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.water_drop, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Đã đến giờ uống nước',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              Text(
                isRunning ? 'Thời gian còn lại' : 'Nhập số phút',
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 12),

              // ĐỒNG HỒ / INPUT
              if (isRunning)
                Text(
                  _formatTime(remainingSeconds),
                  style: const TextStyle(
                    fontSize: 54,
                    fontWeight: FontWeight.bold,
                    color: accentBlue,
                  ),
                )
              else
                TextField(
                  controller: minuteController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Ví dụ: 30',
                    hintStyle: const TextStyle(color: Colors.black38),
                    suffixText: 'phút',
                    suffixStyle: const TextStyle(color: accentBlue),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: accentBlue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          const BorderSide(color: accentPink, width: 2),
                    ),
                  ),
                ),

              const SizedBox(height: 26),

              // NÚT
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Bắt đầu'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: isRunning ? null : _startTimer,
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.stop),
                    label: const Text('Dừng'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: accentBlue,
                      side: const BorderSide(color: accentBlue),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: isRunning ? _stopTimer : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
