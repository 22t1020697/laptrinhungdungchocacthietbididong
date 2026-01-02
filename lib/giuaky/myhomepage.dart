import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const Color colorStart = Color(0xFF00C6FF); // Xanh Neon rực rỡ
  static const Color colorEnd = Color(0xFFF72F68);   // Hồng Mystic
  static const Color sidebarBg = Color(0xFFF0F7FF);  // Nền menu xanh nhạt cực nhẹ

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
                Expanded(child: _buildStudentInfoCard()),
              ],
            );
          }

          return Row(
            children: [
              _buildMenu(context),
              Expanded(child: _buildStudentInfoCard()),
            ],
          );
        },
      ),
    );
  }

  // MENU
  Widget _buildMenu(BuildContext context, {bool isNarrow = false}) {
    return Container(
      width: isNarrow ? double.infinity : 260,
      color: sidebarBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
                Text('Danh sách bài tập',
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
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
                    ...items.map((it) => ListTile(
                          dense: true,
                          leading: Icon(it['icon'] as IconData, color: colorEnd),
                          title: Text(it['title'] as String),
                          trailing: const Icon(Icons.chevron_right, size: 18),
                          onTap: () async {
                            final route = it['route'] as String;
                            if (route == '/profile') {
                              final user = await _askUsername(context);
                              if (mounted && user != null) Navigator.pushNamed(context, route, arguments: user);
                            } else {
                              Navigator.pushNamed(context, route);
                            }
                          },
                        )),
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

  // --- THÔNG TIN SINH VIÊN ---
  Widget _buildStudentInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: const NetworkImage('https://www.transparenttextures.com/patterns/white-diamond.png'),
          opacity: 0.1,
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ảnh đại diện giả lập
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(colors: [colorStart, colorEnd]),
                  boxShadow: [
                    BoxShadow(color: colorStart.withOpacity(0.3), blurRadius: 20, spreadRadius: 5)
                  ],
                ),
                child: const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 60, color: colorStart),
                ),
              ),
              const SizedBox(height: 30),
              
              // Thẻ thông tin
              Container(
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5))
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: sidebarBg,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      ),
                      child: const Text('THÔNG TIN CÁ NHÂN', 
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, color: colorStart, letterSpacing: 1.1)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _buildDetailRow(Icons.assignment_ind_rounded, 'Mã SV', _studentId),
                          const Divider(height: 30),
                          _buildDetailRow(Icons.badge_rounded, 'Họ Tên', _studentName),
                          const Divider(height: 30),
                          _buildDetailRow(Icons.school_rounded, 'Lớp', 'Công nghệ thông tin'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: colorEnd, size: 22),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        )
      ],
    );
  }

  // ---  DIALOG ---
  Future<String?> _askUsername(BuildContext context) {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nhập Username'),
        content: TextField(controller: controller, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text),
            style: ElevatedButton.styleFrom(backgroundColor: colorStart),
            child: const Text('OK', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}