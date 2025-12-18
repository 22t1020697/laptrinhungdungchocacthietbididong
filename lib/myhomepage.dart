import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Định nghĩa màu sắc chủ đạo
  static const Color colorStart = Color(0xFFF72F68); // Hồng
  static const Color colorEnd = Color(0xFFF16807);   // Cam
  static const Color sidebarBg = Color(0xFFFFF5F2); // Nền menu hồng nhạt

  static const List<Map<String, dynamic>> _menuSections = [
    {
      'title': '🔐 Xác thực',
      'items': [
        {'title': 'Đăng nhập API', 'route': '/api_login', 'icon': Icons.cloud},
        {'title': 'Đăng nhập', 'route': '/login', 'icon': Icons.login},
        {'title': 'Đăng ký', 'route': '/register', 'icon': Icons.person_add},
        {'title': 'Hồ sơ', 'route': '/profile', 'icon': Icons.person},
      ],
    },
    {
      'title': '🧰 Tiện ích',
      'items': [
        {'title': 'Đếm số', 'route': '/counter', 'icon': Icons.exposure_plus_1},
        {'title': 'Hẹn giờ', 'route': '/timer', 'icon': Icons.timer},
        {'title': 'Tính BMI', 'route': '/bmi', 'icon': Icons.monitor_weight},
        {'title': 'Đổi màu (Color)', 'route': '/change', 'icon': Icons.color_lens},
        {'title': 'MyClassroom', 'route': '/classroom', 'icon': Icons.class_},
      ],
    },
    {
      'title': '🛍️ Sản phẩm & Tin tức',
      'items': [
        {'title': 'Sản phẩm', 'route': '/products', 'icon': Icons.shopping_bag},
        {'title': 'Phản hồi', 'route': '/feedback', 'icon': Icons.feedback},
        {'title': 'Tin tức', 'route': '/news', 'icon': Icons.article},
      ],
    },
    {
      'title': '📍 Địa điểm & Du lịch',
      'items': [
        {'title': 'Địa điểm', 'route': '/places', 'icon': Icons.place},
        {'title': 'Du lịch', 'route': '/travel', 'icon': Icons.flight},
        {'title': 'Đặt chỗ', 'route': '/booking', 'icon': Icons.event},
      ],
    },
  ];

  // Thông tin cố định (Không sửa)
  final String _studentId = '22T1020697';
  final String _studentName = 'Lê Thị Quỳnh Như';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chính', 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [colorStart, colorEnd]),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 700;
          if (isNarrow) {
            return Column(
              children: [
                _buildMenu(context, isNarrow: true),
                const Divider(height: 1),
                Expanded(child: Center(child: _buildStudentInfoCard())),
              ],
            );
          }

          return Row(
            children: [
              _buildMenu(context),
              Expanded(
                child: Center(
                  child: _buildStudentInfoCard(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMenu(BuildContext context, {bool isNarrow = false}) {
    return Container(
      width: isNarrow ? double.infinity : 260,
      color: sidebarBg,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Sidebar
          Container(
            height: 140,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [colorStart, colorEnd],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(topRight: Radius.circular(12)),
            ),
            padding: const EdgeInsets.all(12.0),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.school, color: Colors.white, size: 28),
                ),
                SizedBox(height: 8),
                Text('Flutter N3 App',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(height: 2),
                Text('Danh sách bài tập',
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
          const Divider(height: 1),
          // List Menu Items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _menuSections.length,
              itemBuilder: (context, sectionIndex) {
                final section = _menuSections[sectionIndex];
                final items = section['items'] as List<dynamic>;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                      child: Text(section['title'] as String,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: colorStart)),
                    ),
                    ...items.map((it) {
                      return ListTile(
                        dense: true,
                        leading: Icon(it['icon'] as IconData, color: colorEnd),
                        title: Text(it['title'] as String),
                        trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
                        onTap: () async {
                          final route = it['route'] as String;
                          if (route == '/profile') {
                            final username = await _askUsername(context);
                            if (!mounted) return;
                            if (username != null && username.isNotEmpty) {
                              Navigator.pushNamed(context, '/profile', arguments: username);
                            }
                          } else {
                            Navigator.pushNamed(context, route);
                          }
                        },
                      );
                    }),
                    const SizedBox(height: 8),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentInfoCard() {
    return Card(
      elevation: 4,
      shadowColor: colorStart.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(24),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Thông tin sinh viên',
                style: TextStyle(color: colorStart, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildInfoRow('Mã sinh viên', _studentId),
            const Divider(height: 24),
            _buildInfoRow('Họ và tên', _studentName),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        SizedBox(
            width: 100,
            child: Text(label, style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500))),
        const SizedBox(width: 12),
        Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
      ],
    );
  }

  // Giữ lại Dialog này vì nó dùng cho chức năng "Hồ sơ" trong menu
  Future<String?> _askUsername(BuildContext context) {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nhập Username'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
                hintText: 'Username', 
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorStart))),
            autofocus: true,
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), 
                child: const Text('Hủy', style: TextStyle(color: Colors.grey))),
            ElevatedButton(
                onPressed: () => Navigator.pop(context, controller.text),
                style: ElevatedButton.styleFrom(backgroundColor: colorStart),
                child: const Text('OK', style: TextStyle(color: Colors.white))),
          ],
        );
      },
    );
  }
}