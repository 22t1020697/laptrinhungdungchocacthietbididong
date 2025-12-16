import 'package:flutter/material.dart';
import 'package:nhu_project/loginpage.dart';
import 'package:nhu_project/register_page.dart';
import 'package:nhu_project/profile.dart';
import 'package:nhu_project/myhomepage.dart';
import 'package:nhu_project/myproduct.dart';
import 'package:nhu_project/myplace.dart';
import 'package:nhu_project/travelapp.dart';
import 'package:nhu_project/booking.dart';
import 'package:nhu_project/feedback_page.dart';
import 'package:nhu_project/bmi_page.dart';
import 'package:nhu_project/dem.dart';
import 'package:nhu_project/demthoigian.dart';
import 'package:nhu_project/api_login.dart';
import 'package:nhu_project/change.dart';
import 'package:nhu_project/myclassroom.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nhu Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const MyHomePage(),
        '/products': (context) => const MyProduct(),
        '/places': (context) => const MyPlace(),
        '/travel': (context) => const Travelapp(),
        '/booking': (context) => const BookingPage(),
        '/feedback': (context) => const FeedbackPage(),
        '/bmi': (context) => const BmiPage(),
        '/counter': (context) => const CounterScreen(),
        '/timer': (context) => const CountdownTimerScreen(),
        '/api_login': (context) => const ApiLoginPage(),
        '/change': (context) => const ColorChangerPage(),
        '/classroom': (context) => const MyClassroom(),
      },
      onGenerateRoute: (settings) {
        // Support passing arguments to the ProfilePage using a username String
        if (settings.name == '/profile') {
          final args = settings.arguments;
          final username = args is String ? args : '';
          return MaterialPageRoute(
            builder: (context) => ProfilePage(username: username),
            settings: settings,
          );
        }
        // Unknown route
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
      },
    );
  }
}

//bài tập ngày 21/11
// import 'package:flutter/material.dart';
// import 'package:nhu_project/Bmipage.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'BMI Calculator',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//       ),
//       home: const BmiPage(), // Gọi trang BMI
//     );
//   }
// }


//bài tập ngày 24/10
// import 'package:flutter/material.dart';
// import 'package:nhu_project/loginpage.dart';
// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Login Form',
//       // Đặt theme để nút có màu xanh giống trong hình
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//       ),
//       home: const LoginPage(), // Gọi màn hình đăng nhập
//     );
//   }
// }

//bài tập ngày 17/10
// import 'package:flutter/material.dart';
// import 'package:nhu_project/change.dart'; 

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ColorChangerPage(),
//     );
//   }
// }


//bài tập ngày 10/10
// import 'package:flutter/material.dart';
// import 'package:nhu_project/travelapp.dart'; // Nhúng file giao diện chính

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(debugShowCheckedModeBanner: false, home:Travelapp());
//   }
// }

//bài tập ngày 3/10
// import 'package:nhu_project/myclassroom.dart';
// import 'package:flutter/material.dart';

// void main() {

//   runApp(MyApp());
// }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyClassroom() ,
//     );
//   }
// }

//bài tập ngày 26/9
// import 'package:flutter/material.dart';
// import 'giaodienlophoc.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Course UI',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const CourseListScreen(),
//     );
//   }
// }

// class CourseListScreen extends StatelessWidget {
//   const CourseListScreen({super.key});

//   final List<Map<String, dynamic>> courses = const [
//     {
//       "title": "XML và ứng dụng - Nhóm 1",
//       "code": "2025-2026.1.TIN4583.001",
//       "students": "58 học viên",
//       "bgColor": Color.fromARGB(255, 55, 57, 135),
//     },
//     {
//       "title": "Lập trình ứng dụng cho các t...",
//       "code": "2025-2026.1.TIN4403.006",
//       "students": "55 học viên",
//       "bgColor": Colors.redAccent,
//     },
//     {
//       "title": "Lập trình ứng dụng cho các t...",
//       "code": "2025-2026.1.TIN4403.005",
//       "students": "52 học viên",
//       "bgColor": Colors.grey,
//     },
//     {
//       "title": "Lập trình ứng dụng cho các t...",
//       "code": "2025-2026.1.TIN4403.004",
//       "students": "50 học viên",
//       "bgColor": Colors.blue,
//     },
//     {
//       "title": "Lập trình ứng dụng cho các t...",
//       "code": "2025-2026.1.TIN4403.003",
//       "students": "52 học viên",
//       "bgColor": Color.fromARGB(221, 85, 22, 70),
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Danh sách môn học")),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(12),
//         itemCount: courses.length,
//         itemBuilder: (context, index) {
//           final course = courses[index];
//           return Padding(
//             padding: const EdgeInsets.only(bottom: 12),
//             child: CourseCard(
//               title: course["title"],
//               code: course["code"],
//               students: course["students"],
//               bgColor: course["bgColor"],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
