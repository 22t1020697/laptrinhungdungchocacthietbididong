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
  Color _resultColor = Colors.black;

  void _calculateBMI() {
    String heightText = _heightController.text;
    String weightText = _weightController.text;

    if (heightText.isEmpty || weightText.isEmpty) {
      setState(() {
        _textResult = "Vui lòng nhập đầy đủ thông tin!";
        _resultColor = Colors.red;
        _bmiResult = null;
      });
      return;
    }

    double height = double.parse(heightText);
    double weight = double.parse(weightText);
    double heightInMeters = height / 100;
    double bmi = weight / (heightInMeters * heightInMeters);

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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.monitor_weight_outlined,
              size: 100,
              color: Colors.blue,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Chiều cao (cm)',
                hintText: 'Ví dụ: 170',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.height),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Cân nặng (kg)',
                hintText: 'Ví dụ: 65',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.line_weight),
              ),
            ),
            const SizedBox(height: 30),
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
            if (_bmiResult != null)
              Column(
                children: [
                  const Text(
                    "Chỉ số BMI của bạn:",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Text(
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
                      color: _resultColor,
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
