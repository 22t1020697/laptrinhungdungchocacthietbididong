import 'package:flutter/material.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({super.key});

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double? _bmiResult;
  String _textResult = "";
  Color _resultColor = Colors.white;

  // HỆ MÀU CHỦ ĐẠO
  static const Color colorStart = Color(0xFF00C6FF); // Xanh Neon
  static const Color colorEnd = Color(0xFFF72F68);   // Hồng Mystic

  void _calculateBMI() {
    String heightText = _heightController.text;
    String weightText = _weightController.text;

    if (heightText.isEmpty || weightText.isEmpty) {
      _showSnackBar("Vui lòng nhập đầy đủ thông tin!");
      return;
    }

    double height = double.parse(heightText);
    double weight = double.parse(weightText);
    double heightInMeters = height / 100;
    double bmi = weight / (heightInMeters * heightInMeters);

    String message = "";
    Color color = Colors.white;

    if (bmi < 18.5) {
      message = "Bạn đang quá gầy (Thiếu cân)";
      color = Colors.orangeAccent;
    } else if (bmi >= 18.5 && bmi < 25) {
      message = "Cơ thể cân đối (Bình thường)";
      color = Colors.greenAccent;
    } else if (bmi >= 25 && bmi < 30) {
      message = "Bạn đang thừa cân";
      color = Colors.yellowAccent;
    } else {
      message = "Bạn bị béo phì (Nguy hiểm)";
      color = Colors.redAccent;
    }

    setState(() {
      _bmiResult = bmi;
      _textResult = message;
      _resultColor = color;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: colorEnd),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CHỈ SỐ SỨC KHỎE BMI', 
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [colorStart, colorEnd]),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFF8FAFC),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildHeaderIcon(),
              const SizedBox(height: 30),
              _buildInputCard(),
              const SizedBox(height: 30),
              if (_bmiResult != null) _buildResultCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderIcon() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(colors: [colorStart, colorEnd]),
        boxShadow: [BoxShadow(color: colorEnd.withOpacity(0.3), blurRadius: 20, spreadRadius: 5)],
      ),
      child: const Icon(Icons.monitor_weight_rounded, size: 60, color: Colors.white),
    );
  }

  Widget _buildInputCard() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            _buildTextField(_heightController, 'Chiều cao (cm)', Icons.height),
            const SizedBox(height: 20),
            _buildTextField(_weightController, 'Cân nặng (kg)', Icons.line_weight),
            const SizedBox(height: 30),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: colorEnd),
        filled: true,
        fillColor: colorStart.withOpacity(0.05),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: colorStart, width: 2),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(colors: [colorStart, colorEnd]),
      ),
      child: ElevatedButton(
        onPressed: _calculateBMI,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: const Text('TÍNH TOÁN NGAY', 
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  Widget _buildResultCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [colorStart, colorEnd]),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: colorEnd.withOpacity(0.3), blurRadius: 15)],
      ),
      child: Column(
        children: [
          const Text("CHỈ SỐ BMI CỦA BẠN", style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold)),
          Text(_bmiResult!.toStringAsFixed(1), 
            style: const TextStyle(fontSize: 70, fontWeight: FontWeight.w900, color: Colors.white)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
            child: Text(_textResult, textAlign: TextAlign.center, 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _resultColor)),
          ),
        ],
      ),
    );
  }
}