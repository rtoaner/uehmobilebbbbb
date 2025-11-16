import 'package:flutter/material.dart';
import 'home.dart';
import 'notification.dart';
import 'check_in.dart';
import 'profile.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    NotificationPage(),
    CheckInPage(),
    ProfilePage(title: 'Tài khoản'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue[700],
        unselectedItemColor: Colors.blue[300],
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Thông báo'),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outline), label: 'Điểm danh'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tài khoản'),
        ],
      ),
    );
  }
}
