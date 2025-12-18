import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _nameController = TextEditingController();
  final _contentController = TextEditingController();
  int _starRating = 0;

  // HỆ MÀU CHỦ ĐẠO ĐỒNG BỘ
  static const Color colorStart = Color(0xFF00C6FF); // Xanh Neon
  static const Color colorEnd = Color(0xFFF72F68);   // Hồng Mystic

  @override
  void dispose() {
    _nameController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _sendFeedback() {
    String name = _nameController.text;
    String content = _contentController.text;

    if (name.isEmpty || content.isEmpty || _starRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập đủ thông tin và chọn sao!'),
          backgroundColor: colorEnd,
        ),
      );
      return;
    }

    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Gửi thành công!", style: TextStyle(color: colorEnd, fontWeight: FontWeight.bold)),
        content: Text("Cảm ơn $name đã dành $_starRating sao để ủng hộ chúng tôi!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _nameController.clear();
              _contentController.clear();
              setState(() => _starRating = 0);
            },
            child: const Text("TUYỆT VỜI", style: TextStyle(color: colorStart, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GỬI PHẢN HỒI', 
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
        color: const Color(0xFFF8FAFC),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              _buildStarHeader(),
              const SizedBox(height: 30),
              _buildFeedbackCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStarHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          const Text("Bạn thấy ứng dụng thế nào?", 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                onPressed: () => setState(() => _starRating = index + 1),
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    index < _starRating ? Icons.star_rounded : Icons.star_outline_rounded,
                    key: ValueKey(index < _starRating),
                    color: index < _starRating ? Colors.amber : Colors.grey[300],
                    size: 45,
                  ),
                ),
              );
            }),
          ),
          if (_starRating > 0)
            Text("$_starRating/5 sao", style: const TextStyle(color: colorEnd, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildFeedbackCard() {
    return Card(
      elevation: 8,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCustomField(_nameController, "Tên của bạn", Icons.person_outline),
            const SizedBox(height: 20),
            _buildCustomField(_contentController, "Ý kiến đóng góp...", Icons.chat_bubble_outline, maxLines: 4),
            const SizedBox(height: 30),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomField(TextEditingController controller, String hint, IconData icon, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: colorStart),
        filled: true,
        fillColor: colorStart.withOpacity(0.05),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: colorStart, width: 1.5),
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
        boxShadow: [BoxShadow(color: colorEnd.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: ElevatedButton(
        onPressed: _sendFeedback,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: const Text('GỬI NGAY', 
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}