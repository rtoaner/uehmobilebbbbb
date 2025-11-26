import 'package:flutter/material.dart';
import 'helpers/utils.dart';
import 'widgets/login.dart';
import 'widgets/register.dart';
import 'menu/bottom_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 Không gọi initDB ở đây nữa
  // Vì utils.dart đã tự INIT theo nền tảng.
  // Android/iOS dùng sqflite (tự init)
  // Desktop dùng ffi (lazy init)

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UEH Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),

      // ⭐ Màn hình khởi động
      home: const LoginPage(title: "Đăng nhập"),

      // ⭐ Routes
      routes: {
        '/login': (context) => const LoginPage(title: "Đăng nhập"),
        '/register': (context) => const RegisterPage(title: "Đăng ký"),
        '/home': (context) => const BottomNavigation(),
      },
    );
  }
}
