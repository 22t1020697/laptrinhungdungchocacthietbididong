import 'package:flutter/material.dart';
// 1. IMPORT TỆP ĐĂNG KÝ MỚI
//    Nhớ thay 'ten_du_an' bằng tên dự án thực tế của bạn

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  // 2. Tạo các controller để lấy text (đã sửa 'textaz' thành 'text')
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Hàm xử lý khi nhấn nút Đăng nhập
  void _login() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng nhập thành công'),
          backgroundColor: Colors.green,
        ),
      );

      // Điều hướng sang trang hồ sơ cá nhân sau 1 giây
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          Navigator.pushReplacementNamed(
            context,
            '/profile',
            arguments: _usernameController.text,
          );
        }
      });
    }
  }

  // **** PHẦN MỚI: Hàm để điều hướng sang trang Đăng ký ****
  void _navigateToRegister() {
    // Push RegisterPage and await returned credentials (if any).
    Navigator.pushNamed<Map<String, String>>(context, '/register')
        .then((result) {
      if (result != null && mounted) {
        // If registration returned credentials, prefill the login fields
        setState(() {
          _usernameController.text = result['username'] ?? '';
          _passwordController.text = result['password'] ?? '';
        });

        // Optionally show a confirmation message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Đã đăng ký — điền thông tin vào form đăng nhập')),
        );
      }
    });
  }
  // ******************************************************

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Đăng nhập'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // (Trường Tên người dùng... không đổi)
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Tên người dùng',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên người dùng';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // (Trường Mật khẩu... không đổi)
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mật khẩu';
                  }
                  if (value.length < 6) {
                    return 'Mật khẩu phải có ít nhất 6 ký tự';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // (Nút Đăng nhập... không đổi)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child:
                      const Text('Đăng nhập', style: TextStyle(fontSize: 18)),
                ),
              ),

              // **** PHẦN MỚI: Link để Đăng ký ****
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Chưa có tài khoản?'),
                  // Nút văn bản (TextButton)
                  TextButton(
                    onPressed: _navigateToRegister, // Gọi hàm điều hướng
                    child: const Text('Đăng ký ngay'),
                  ),
                ],
              )
              // ***************************************
            ],
          ),
        ),
      ),
    );
  }
}
