// ignore_for_file: file_names
import 'package:flutter/material.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({super.key});

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  // Controller để lấy dữ liệu nhập vào
  final TextEditingController _heightController =
      TextEditingController(); // Chiều cao (cm)
  final TextEditingController _weightController =
      TextEditingController(); // Cân nặng (kg)

  // Biến để lưu kết quả
  double? _bmiResult; // Dấu ? nghĩa là ban đầu có thể null (chưa tính)
  String _textResult = ""; // Thông báo (Gầy, Bình thường...)
  Color _resultColor = Colors.black; // Màu chữ kết quả

  // Hàm tính toán BMI
  void _calculateBMI() {
    // Lấy text từ ô nhập liệu
    String heightText = _heightController.text;
    String weightText = _weightController.text;

    // Kiểm tra xem người dùng có nhập thiếu không
    if (heightText.isEmpty || weightText.isEmpty) {
      setState(() {
        _textResult = "Vui lòng nhập đầy đủ thông tin!";
        _resultColor = Colors.red;
        _bmiResult = null;
      });
      return;
    }

    // Chuyển đổi String sang số (double)
    double height = double.parse(heightText);
    double weight = double.parse(weightText);

    // Đổi chiều cao từ cm sang m (Ví dụ 170cm -> 1.7m)
    double heightInMeters = height / 100;

    // Công thức tính BMI
    double bmi = weight / (heightInMeters * heightInMeters);

    // Logic phân loại sức khỏe
    String message = "";
    Color color = Colors.black;

    if (bmi < 18.5) {
      message = "Bạn đang quá gầy (Thiếu cân)";
      color = Colors.orange;
    } else if (bmi >= 18.5 && bmi < 25) {
      message = "Cơ thể cân đối (Bình thường)";
      color = Colors.green;
    } else if (bmi >= 25 && bmi < 30) {
      message = "Bạn đang thừa cân";
      color = Colors.orangeAccent;
    } else {
      message = "Bạn bị béo phì (Nguy hiểm)";
      color = Colors.red;
    }

    // Cập nhật giao diện
    setState(() {
      _bmiResult = bmi;
      _textResult = message;
      _resultColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tính chỉ số BMI'),
        backgroundColor: Colors.blue[100],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // Cho phép cuộn nếu màn hình nhỏ
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hình ảnh minh họa cho đẹp (Icon lớn)
            const Icon(
              Icons.monitor_weight_outlined,
              size: 100,
              color: Colors.blue,
            ),

            const SizedBox(height: 30),

            // Ô nhập Chiều cao
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number, // Chỉ hiện bàn phím số
              decoration: const InputDecoration(
                labelText: 'Chiều cao (cm)',
                hintText: 'Ví dụ: 170',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.height),
              ),
            ),

            const SizedBox(height: 20),

            // Ô nhập Cân nặng
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number, // Chỉ hiện bàn phím số
              decoration: const InputDecoration(
                labelText: 'Cân nặng (kg)',
                hintText: 'Ví dụ: 65',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.line_weight),
              ),
            ),

            const SizedBox(height: 30),

            // Nút Tính toán
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _calculateBMI,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'TÍNH BMI',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Phần hiển thị kết quả (Chỉ hiện khi đã có kết quả)
            if (_bmiResult != null)
              Column(
                children: [
                  const Text(
                    "Chỉ số BMI của bạn:",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Text(
                    // toStringAsFixed(2): Lấy 2 số sau dấu phẩy (VD: 22.55)
                    _bmiResult!.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _textResult,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: _resultColor, // Màu thay đổi theo kết quả
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
