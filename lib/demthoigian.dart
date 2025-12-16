import 'package:flutter/material.dart';
import 'dart:async';

class CountdownTimerScreen extends StatefulWidget {
  const CountdownTimerScreen({super.key});

  @override
  State<CountdownTimerScreen> createState() => _CountdownTimerScreenState();
}

class _CountdownTimerScreenState extends State<CountdownTimerScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  Timer? _timer;
  int _remainingSeconds = 0;
  int _totalSeconds = 0;
  bool _isRunning = false;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void startTimer() {
    if (_controller.text.isEmpty) return;

    int seconds = int.tryParse(_controller.text) ?? 0;
    if (seconds <= 0) return;

    setState(() {
      _remainingSeconds = seconds;
      _totalSeconds = seconds;
      _isRunning = true;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
        setState(() {
          _isRunning = false;
        });
        _showCompletionDialog();
      }
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Column(
          children: [
            Text("🎉", style: TextStyle(fontSize: 50)),
            SizedBox(height: 10),
            Text("Hết thời gian!"),
          ],
        ),
        content: const Text(
          "Đếm ngược đã hoàn thành!",
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void resetTimer() {
    _timer?.cancel();
    setState(() {
      _remainingSeconds = 0;
      _totalSeconds = 0;
      _isRunning = false;
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  double get progress =>
      _totalSeconds > 0 ? _remainingSeconds / _totalSeconds : 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          '⏱️ Bộ đếm thời gian',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0f0c29), Color(0xFF302b63), Color(0xFF24243e)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Input field
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Nhập số giây...",
                      hintStyle: const TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.5)),
                      prefixIcon: const Icon(Icons.timer_outlined,
                          color: Colors.white54),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(20),
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                // Circular Timer
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background circle
                    SizedBox(
                      width: 220,
                      height: 220,
                      child: CircularProgressIndicator(
                        value: 1,
                        strokeWidth: 12,
                        backgroundColor:
                            const Color.fromRGBO(255, 255, 255, 0.1),
                        valueColor: const AlwaysStoppedAnimation(
                            Color.fromRGBO(255, 255, 255, 0.1)),
                      ),
                    ),
                    // Progress circle
                    SizedBox(
                      width: 220,
                      height: 220,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: progress),
                        duration: const Duration(milliseconds: 300),
                        builder: (context, value, _) {
                          return CircularProgressIndicator(
                            value: value,
                            strokeWidth: 12,
                            strokeCap: StrokeCap.round,
                            valueColor: AlwaysStoppedAnimation(
                              _isRunning
                                  ? const Color(0xFF00d2ff)
                                  : Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                    // Timer text
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _isRunning
                              ? 1 + (_pulseController.value * 0.05)
                              : 1,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                formatTime(_remainingSeconds),
                                style: TextStyle(
                                  fontSize: 52,
                                  fontWeight: FontWeight.bold,
                                  color: _isRunning
                                      ? const Color(0xFF00d2ff)
                                      : Colors.white70,
                                  shadows: _isRunning
                                      ? [
                                          Shadow(
                                            color: const Color.fromRGBO(
                                                0, 210, 255, 0.5),
                                            blurRadius: 20,
                                          ),
                                        ]
                                      : null,
                                ),
                              ),
                              Text(
                                _isRunning ? "đang chạy..." : "sẵn sàng",
                                style: const TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 0.5),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 50),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButton(
                      onPressed: _isRunning ? null : startTimer,
                      icon: Icons.play_arrow_rounded,
                      label: "Bắt đầu",
                      colors: _isRunning
                          ? [Colors.grey, Colors.grey]
                          : [const Color(0xFF00d2ff), const Color(0xFF3a7bd5)],
                    ),
                    const SizedBox(width: 20),
                    _buildButton(
                      onPressed: resetTimer,
                      icon: Icons.refresh_rounded,
                      label: "Đặt lại",
                      colors: [
                        const Color(0xFFee0979),
                        const Color(0xFFff6a00)
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required VoidCallback? onPressed,
    required IconData icon,
    required String label,
    required List<Color> colors,
  }) {
    final isDisabled = onPressed == null;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: isDisabled
              ? [Colors.grey.shade700, Colors.grey.shade600]
              : colors,
        ),
        boxShadow: isDisabled
            ? null
            : [
                BoxShadow(
                  color: colors[0].withAlpha((0.4 * 255).round()),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 24),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
