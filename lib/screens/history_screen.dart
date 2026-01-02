import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> history;

  const HistoryScreen({
    super.key,
    required this.history,
  });

  Map<String, List<Map<String, dynamic>>> _groupByDate() {
    final Map<String, List<Map<String, dynamic>>> grouped = {};

    for (var item in history) {
      final date = item['date'] as DateTime;
      final key =
          '${date.day.toString().padLeft(2, '0')}/'
          '${date.month.toString().padLeft(2, '0')}/'
          '${date.year}';

      grouped.putIfAbsent(key, () => []);
      grouped[key]!.add(item);
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    const backgroundBlue = Color(0xFFE1F5FE);
    const cardPink = Color(0xFFFFEBEE);
    const accentBlue = Color(0xFF0288D1);
    const accentPink = Color(0xFFF48FB1);

    final groupedHistory = _groupByDate();

    return Scaffold(
      backgroundColor: backgroundBlue,
      appBar: AppBar(
        backgroundColor: backgroundBlue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Thống kê uống nước',
          style: TextStyle(color: accentBlue),
        ),
        iconTheme: const IconThemeData(color: accentBlue),
      ),
      body: groupedHistory.isEmpty
          ? const Center(child: Text('Chưa có dữ liệu'))
          : ListView(
              padding: const EdgeInsets.all(20),
              children: groupedHistory.entries.map((entry) {
                final date = entry.key;
                final items = entry.value;
                final total = items.fold<double>(
                    0, (sum, e) => sum + e['amount']);

                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cardPink,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.withOpacity(0.25),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 📅 NGÀY + TỔNG
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '📅 $date',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: accentBlue,
                            ),
                          ),
                          Text(
                            '${total.toInt()} ml',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: accentPink,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // 💧 DANH SÁCH TRONG NGÀY
                      ...items.map((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.water_drop,
                                  color: accentPink, size: 18),
                              Text('${item['amount']} ml'),
                              Text(item['time'],
                                  style: const TextStyle(
                                      color: Colors.black54)),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                );
              }).toList(),
            ),
    );
  }
}
