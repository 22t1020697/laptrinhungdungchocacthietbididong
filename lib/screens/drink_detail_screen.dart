import 'package:flutter/material.dart';

class DrinkDetailScreen extends StatelessWidget {
  final Map<String, dynamic> drink;

  const DrinkDetailScreen({
    super.key,
    required this.drink,
  });

  @override
  Widget build(BuildContext context) {
    const backgroundBlue = Color(0xFFE1F5FE); // xanh pastel
    const cardPink = Color(0xFFFFEBEE); // hồng nhạt
    const accentBlue = Color(0xFF0288D1);
    const accentPink = Color(0xFFF48FB1);

    return Scaffold(
      backgroundColor: backgroundBlue,
      appBar: AppBar(
        backgroundColor: backgroundBlue,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: accentBlue),
        title: Text(
          drink['name'],
          style: const TextStyle(
            color: accentBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
          decoration: BoxDecoration(
            color: cardPink,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.pink.withOpacity(0.25),
                blurRadius: 25,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ICON / HÌNH LY NƯỚC
              Icon(
                drink['icon'],
                size: 90,
                color: accentPink,
              ),

              const SizedBox(height: 24),

              _infoCenter(
                icon: Icons.schedule,
                title: 'Thời điểm tốt nhất',
                value: drink['bestTime'],
              ),

              const SizedBox(height: 20),

              _infoCenter(
                icon: Icons.local_drink,
                title: 'Lượng nên uống',
                value: drink['amount'],
              ),

              const SizedBox(height: 20),

              _infoCenter(
                icon: Icons.favorite,
                title: 'Lời khuyên',
                value: drink['advice'],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ====== WIDGET HIỂN THỊ THÔNG TIN (CĂN GIỮA) ======
  Widget _infoCenter({
    required IconData icon,
    required String title,
    required String value,
  }) {
    const accentBlue = Color(0xFF0288D1);
    const accentPink = Color(0xFFF48FB1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: accentPink, size: 28),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: accentBlue,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
