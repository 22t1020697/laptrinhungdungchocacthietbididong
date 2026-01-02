import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:nhu_project/profile.dart'; 

class LoginApiScreen extends StatefulWidget {
  final Function(String) onLoginSuccess;

  LoginApiScreen({required this.onLoginSuccess});

  @override
  _LoginApiScreenState createState() => _LoginApiScreenState();
}

class _LoginApiScreenState extends State<LoginApiScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool isLoading = false;

  Future<void> login() async {
    // Kiểm tra input trống trước khi gọi API
    if (_userController.text.isEmpty || _passController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final dio = Dio();
      final response = await dio.post(
        "https://dummyjson.com/auth/login",
        data: {
          "username": _userController.text.trim(),
          "password": _passController.text.trim(),
          "expiresInMins": 30
        },
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      setState(() => isLoading = false);

      if (response.statusCode == 200) {
        final data = response.data;
        final String token = data["accessToken"];
        
        // Gọi callback để thông báo đăng nhập thành công ra bên ngoài
        widget.onLoginSuccess(token);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Đăng nhập thành công!")),
        );

        // Chuyển hướng sang ProfilePage và truyền đúng tham số username (String)
        // Vì file profile.dart của bạn hiện tại chỉ nhận String username
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(username: data["username"]),
          ),
        );
      }
    } on DioException catch (e) {
      setState(() => isLoading = false);
      String message = "Đăng nhập thất bại";
      if (e.response?.statusCode == 400) {
        message = "Sai tài khoản hoặc mật khẩu";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Giữ nguyên phần UI của bạn vì nó đã được thiết kế rất đẹp
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đăng Nhập API"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.account_circle, size: 80, color: Colors.blueAccent),
                      const SizedBox(height: 20),
                      const Text("Chào mừng trở lại!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 32),
                      TextField(
                        controller: _userController,
                        decoration: InputDecoration(
                          labelText: "Tên đăng nhập",
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _passController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Mật khẩu",
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const SizedBox(height: 24),
                      isLoading
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: login,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: const Text("Đăng Nhập", style: TextStyle(fontSize: 18, color: Colors.white)),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}