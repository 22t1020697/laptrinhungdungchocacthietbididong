// ignore_for_file: file_names
import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  // Controller để lấy dữ liệu nhập vào
  final _nameController = TextEditingController();
  final _contentController = TextEditingController();

  // Biến lưu số sao đã chọn (mặc định là 0)
  int _starRating = 0;

  @override
  void dispose() {
    _nameController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  // Hàm xử lý khi bấm nút Gửi
  void _sendFeedback() {
    // 1. Lấy dữ liệu
    String name = _nameController.text;
    String content = _contentController.text;

    // 2. Kiểm tra dữ liệu (Validation)
    if (name.isEmpty || content.isEmpty || _starRating == 0) {
      // Hiện thông báo lỗi nếu thiếu thông tin
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập đủ tên, nội dung và chọn sao!'),
          backgroundColor: Colors.red,
        ),
      );
      return; // Dừng lại, không làm gì tiếp theo
    }

    // 3. Tạo nội dung thông báo
    String message =
        "Cám ơn bạn $name đã đánh giá $_starRating sao với phản hồi \"$content\"";

    // 4. Hiển thị thông báo (Dialog)
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Gửi thành công!"),
          content: Text(message), // Hiển thị nội dung bạn yêu cầu
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại

                // (Tùy chọn) Xóa dữ liệu sau khi gửi
                _nameController.clear();
                _contentController.clear();
                setState(() {
                  _starRating = 0;
                });
              },
              child: const Text("Đóng"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gửi Phản Hồi'),
        centerTitle: true,
        backgroundColor: Colors.orange[100],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Căn lề trái
          children: [
            // 1. Nhập Họ tên
            const Text("Họ và tên:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Nhập họ tên của bạn',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 20),

            // 2. Chọn số sao (Logic quan trọng)
            const Text("Đánh giá của bạn:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Căn giữa hàng sao
              children: List.generate(5, (index) {
                // index chạy từ 0 đến 4 (tương ứng sao 1 đến 5)
                return IconButton(
                  onPressed: () {
                    setState(() {
                      _starRating = index + 1; // Lưu số sao (index + 1)
                    });
                  },
                  icon: Icon(
                    // Nếu index nhỏ hơn số sao đã chọn -> Hiện sao đặc (Icons.star)
                    // Ngược lại -> Hiện viền sao (Icons.star_border)
                    index < _starRating ? Icons.star : Icons.star_border,
                    color: Colors.amber, // Màu vàng
                    size: 40, // Kích thước lớn chút cho dễ bấm
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            // 3. Nhập nội dung góp ý
            const Text("Nội dung góp ý:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _contentController,
              maxLines: 5, // Cho phép nhập nhiều dòng (5 dòng)
              decoration: const InputDecoration(
                hintText: 'Nhập ý kiến của bạn vào đây...',
                border: OutlineInputBorder(),
                alignLabelWithHint: true, // Căn text lên trên cùng
              ),
            ),

            const SizedBox(height: 30),

            // 4. Nút Gửi
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _sendFeedback,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'GỬI PHẢN HỒI',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
