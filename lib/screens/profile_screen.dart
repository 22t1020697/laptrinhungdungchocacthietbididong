import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import 'home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  String selectedGender = 'Nam';
  ActivityLevel selectedActivity = ActivityLevel.medium;

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  void _startTracking() {
    if (weightController.text.isEmpty || heightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
      );
      return;
    }

    final user = UserProfile(
      weight: double.parse(weightController.text),
      height: double.parse(heightController.text),
      gender: selectedGender,
      activityLevel: selectedActivity,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 🎨 MÀU SẮC
    const backgroundBlue = Color(0xFFE1F5FE); // nền xanh pastel
    const cardPink = Color(0xFFFFEBEE);       // khung hồng nhạt
    const accentBlue = Color(0xFF0288D1);     // xanh đậm
    const iconPink = Color(0xFFF48FB1);       // hồng icon

    return Scaffold(
      backgroundColor: backgroundBlue,
      appBar: AppBar(
        backgroundColor: backgroundBlue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Thông tin cá nhân',
          style: TextStyle(color: accentBlue),
        ),
        iconTheme: const IconThemeData(color: accentBlue),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: cardPink,
              borderRadius: BorderRadius.circular(28),
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
              children: [
                Icon(Icons.favorite, size: 60, color: iconPink),
                const SizedBox(height: 10),
                const Text(
                  'Nhập thông tin của bạn',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: accentBlue,
                  ),
                ),

                const SizedBox(height: 30),

                _buildInputField(
                  controller: weightController,
                  label: 'Cân nặng (kg)',
                  icon: Icons.monitor_weight,
                ),

                const SizedBox(height: 16),

                _buildInputField(
                  controller: heightController,
                  label: 'Chiều cao (cm)',
                  icon: Icons.height,
                ),

                const SizedBox(height: 16),

                _buildDropdown<String>(
                  value: selectedGender,
                  label: 'Giới tính',
                  icon: Icons.wc,
                  items: const [
                    DropdownMenuItem(value: 'Nam', child: Text('Nam')),
                    DropdownMenuItem(value: 'Nữ', child: Text('Nữ')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value!;
                    });
                  },
                ),

                const SizedBox(height: 16),

                _buildDropdown<ActivityLevel>(
                  value: selectedActivity,
                  label: 'Mức độ vận động',
                  icon: Icons.directions_run,
                  items: const [
                    DropdownMenuItem(
                      value: ActivityLevel.low,
                      child: Text('Ít'),
                    ),
                    DropdownMenuItem(
                      value: ActivityLevel.medium,
                      child: Text('Vừa'),
                    ),
                    DropdownMenuItem(
                      value: ActivityLevel.high,
                      child: Text('Nhiều'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedActivity = value!;
                    });
                  },
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _startTracking,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentBlue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      'Bắt đầu theo dõi',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===== WIDGET DÙNG CHUNG =====

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.pink),
        filled: true,
        fillColor: Colors.white.withOpacity(0.95),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required T value,
    required String label,
    required IconData icon,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.pink),
        filled: true,
        fillColor: Colors.white.withOpacity(0.95),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
