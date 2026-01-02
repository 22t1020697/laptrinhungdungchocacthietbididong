import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../services/water_calculator.dart';
import 'profile_screen.dart';
import 'reminder_screen.dart';
import 'history_screen.dart';
import 'bmi_screen.dart';
import 'drink_shop_screen.dart';


class HomeScreen extends StatefulWidget {
  final UserProfile user;

  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double totalDrankMl = 0;

  /// ✅ LỊCH SỬ HÔM NAY – DÙNG CHUNG CHO HOME + HISTORY SCREEN
  final List<Map<String, dynamic>> history = [];

  void _addWater(double amount) {
    setState(() {
      totalDrankMl += amount;
      history.insert(0, {
        'amount': amount,
        'time': TimeOfDay.now().format(context),
        'date': DateTime.now(),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final dailyGoalLit = WaterCalculator.calculateDailyWater(
      widget.user.weight,
      widget.user.activityLevel,
    );

    final dailyGoalMl = dailyGoalLit * 1000;
    final progress = (totalDrankMl / dailyGoalMl).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Reminder'),
        centerTitle: true,
      ),

      // ✅ DRAWER
      drawer: _buildDrawer(context),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Mục tiêu hôm nay',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),

            Text(
              '${dailyGoalLit.toStringAsFixed(1)} lít',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 20),

            // 🧴 BÌNH NƯỚC
            buildWaterBottle(progress),

            const SizedBox(height: 20),

            LinearProgressIndicator(
              value: progress,
              minHeight: 12,
            ),

            const SizedBox(height: 8),
            Text('${totalDrankMl.toInt()} ml đã uống'),

            const SizedBox(height: 20),

            // ➕ NÚT UỐNG NƯỚC
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _addWater(200),
                  child: const Text('+200ml'),
                ),
                ElevatedButton(
                  onPressed: () => _addWater(300),
                  child: const Text('+300ml'),
                ),
                ElevatedButton(
                  onPressed: () => _addWater(500),
                  child: const Text('+500ml'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 📜 LỊCH SỬ HÔM NAY
            const Text(
              'Lịch sử hôm nay',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Expanded(
              child: history.isEmpty
                  ? const Center(
                      child: Text('Chưa có dữ liệu uống nước'),
                    )
                  : ListView.builder(
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        final item = history[index];
                        return ListTile(
                          leading: const Icon(
                            Icons.water_drop,
                            color: Colors.blue,
                          ),
                          title: Text('${item['amount']} ml'),
                          subtitle: Text(item['time']),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  //////////////////// MENU DRAWER ////////////////////
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.water_drop, color: Colors.white, size: 40),
                SizedBox(height: 10),
                Text(
                  'Water Reminder',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Thông tin cá nhân'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.monitor_weight),
            title: const Text('Chỉ số BMI'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BmiScreen(user: widget.user),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_cafe),
            title: const Text('Đồ uống sức khỏe'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const DrinkShopScreen(),
                ),
              );
            },
          ),


          ListTile(
            leading: const Icon(Icons.access_time),
            title: const Text('Hẹn giờ uống nước'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ReminderScreen(),
                ),
              );
            },
          ),

          /// ✅ LIÊN KẾT LỊCH SỬ HÔM NAY → HISTORY SCREEN
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Lịch sử uống nước'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HistoryScreen(history: history),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

//////////////////// BÌNH NƯỚC ////////////////////
Widget buildWaterBottle(double progress) {
  return Center(
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 160,
          height: 320,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.blue, width: 3),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          width: 160,
          height: 320 * progress,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        Positioned(
          top: 140,
          child: Text(
            '${(progress * 100).toInt()}%',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
