import 'package:flutter/material.dart';

class MyPlace extends StatelessWidget {
  const MyPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Place"),
        backgroundColor: Colors.teal,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: myBody(),
    );
  }

  Widget myBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          block1(),
          const SizedBox(height: 16),
          block2(),
          const SizedBox(height: 24),
          block3(),
          const SizedBox(height: 24),
          block4(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  /// Hình ảnh
  Widget block1() {
    return Image.asset(
      "assets/images/sa-mac-sahara.jpg",
      height: 240,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  /// Tên, địa chỉ, vote
  Widget block2() {
    var namePlace = "Sahara Desert";
    var addressPlace = "North Africa";
    var votePlace = "4.5";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Bên trái
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                namePlace,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                addressPlace,
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
            ],
          ),
          // Bên phải (vote)
          Row(
            children: [
              const Icon(Icons.star, color: Colors.orange, size: 26),
              Text(
                votePlace,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Hàng nút (call, route, share)
  Widget block3() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          customButton(Icons.call, "CALL"),
          customButton(Icons.near_me, "ROUTE"),
          customButton(Icons.share, "SHARE"),
        ],
      ),
    );
  }

  /// Text mô tả
  Widget block4() {
    var data =
        "The Sahara Desert is the largest hot desert in the world, stretching across North Africa. "
        "Its vast sand dunes, unique landscapes, and extreme climate make it a fascinating natural wonder. "
        "Tourists often visit to experience camel rides, desert camping, and breathtaking sunsets.";

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        data,
        style: const TextStyle(fontSize: 16, height: 1.5),
        textAlign: TextAlign.justify,
      ),
    );
  }

  /// Tạo nút icon + text
  Widget customButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Colors.teal),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.teal),
        ),
      ],
    );
  }
}
