import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailScreen extends StatelessWidget {
  final Map article;

  const NewsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết bài viết"),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh lớn
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                article["urlToImage"] ?? "",
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(height: 220, color: Colors.grey),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              article["title"] ?? "",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              article["content"] ??
                  article["description"] ??
                  "",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () async {
                final Uri url = Uri.parse(article["url"]);
                if (await canLaunchUrl(url)) {
                  await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                }
              },
              child: const Text("Mở bài viết gốc"),
            ),
          ],
        ),
      ),
    );
  }
}