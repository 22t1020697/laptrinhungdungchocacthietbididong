import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const List<Map<String, dynamic>> _menuSections = [
    {
      'title': '🔐 Xác thực',
      'items': [
        {'title': 'Đăng nhập API', 'route': '/api_login', 'icon': Icons.cloud},
        {'title': 'Đăng nhập', 'route': '/login', 'icon': Icons.login},
        {'title': 'Đăng ký', 'route': '/register', 'icon': Icons.person_add},
      ],
    },
    {
      'title': '🧰 Tiện ích',
      'items': [
        {'title': 'Đếm số', 'route': '/counter', 'icon': Icons.exposure_plus_1},
        {'title': 'Hẹn giờ', 'route': '/timer', 'icon': Icons.timer},
        {'title': 'Tính BMI', 'route': '/bmi', 'icon': Icons.monitor_weight},
        {
          'title': 'Đổi màu (Color)',
          'route': '/change',
          'icon': Icons.color_lens
        },
        {'title': 'MyClassroom', 'route': '/classroom', 'icon': Icons.class_},
      ],
    },
    {
      'title': '🛍️ Sản phẩm & Tin tức',
      'items': [
        {'title': 'Sản phẩm', 'route': '/products', 'icon': Icons.shopping_bag},
        {'title': 'Phản hồi', 'route': '/feedback', 'icon': Icons.feedback},
      ],
    },
  ];

  String _studentId = '22t1020697';
  String _studentName = 'Lê Thị Quỳnh Như';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trang chính')),
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
      color: Colors.blueGrey.shade50,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            height: 140,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF7b2ff7), Color(0xFFf107a3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.school, color: Colors.white, size: 28),
                ),
                const SizedBox(height: 8),
                const Text('Flutter N3 App',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                const Text('Danh sách bài tập',
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
          const Divider(height: 1),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8),
                      child: Text(section['title'] as String,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    // ignore: unnecessary_to_list_in_spreads
                    ...items.map((it) {
                      return ListTile(
                        dense: true,
                        leading:
                            Icon(it['icon'] as IconData, color: Colors.blue),
                        title: Text(it['title'] as String),
                        trailing: const Icon(Icons.chevron_right),
                        // ignore: use_build_context_synchronously
                        onTap: () async {
                          final route = it['route'] as String;
                          final currentContext = context;
                          if (route == '/profile') {
                            final username = await _askUsername(currentContext);
                            if (!mounted) return;
                            if (username != null && username.isNotEmpty) {
                              Navigator.pushNamed(currentContext, '/profile',
                                  arguments: username);
                            }
                          } else {
                            Navigator.pushNamed(currentContext, route);
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton.icon(
              onPressed: () => _editStudentDialog(context),
              icon: const Icon(Icons.edit),
              label: const Text('Chỉnh sửa thông tin sinh viên'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentInfoCard() {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(24),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Thông tin sinh viên',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(
                    width: 120,
                    child: Text('Mã sinh viên',
                        style: TextStyle(fontWeight: FontWeight.w600))),
                const SizedBox(width: 12),
                Text(_studentId),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const SizedBox(
                    width: 120,
                    child: Text('Họ và tên',
                        style: TextStyle(fontWeight: FontWeight.w600))),
                const SizedBox(width: 12),
                Text(_studentName),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ignore: use_build_context_synchronously
  Future<String?> _askUsername(BuildContext context) {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter username'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Username'),
            autofocus: true,
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            ElevatedButton(
                onPressed: () => Navigator.pop(context, controller.text),
                child: const Text('OK')),
          ],
        );
      },
    );
  }

  // ignore: use_build_context_synchronously
  Future<void> _editStudentDialog(BuildContext context) async {
    final ctx = context; // capture ctx
    final idController = TextEditingController(text: _studentId);
    final nameController = TextEditingController(text: _studentName);

    final result = await showDialog<bool>(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          title: const Text('Chỉnh sửa thông tin sinh viên'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: idController,
                decoration:
                    const InputDecoration(labelText: 'Mã sinh viên (MSV)'),
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Họ và tên'),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Hủy')),
            ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Lưu')),
          ],
        );
      },
    );

    if (!mounted) return;
    if (result == true) {
      setState(() {
        _studentId = idController.text.trim();
        _studentName = nameController.text.trim();
      });
      ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('Thông tin đã được cập nhật')));
    }
  }
}
