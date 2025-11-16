import 'package:flutter/material.dart';
import '../widgets/home.dart';
import '../widgets/notification.dart';
import '../widgets/check_in.dart';
import '../widgets/profile.dart';
import 'drawer.dart';

class BottomNavigation extends StatefulWidget {
  final int selectedIndex;
  const BottomNavigation({super.key, this.selectedIndex = 0});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late int _currentIndex;
  final PageController _pageController = PageController();

  final List<Widget> _pages = const [
    HomePage(),
    NotificationPage(),
    CheckInPage(),
    ProfilePage(title: 'Tài khoản'),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ Drawer dùng chung cho mọi trang
      drawer: const UehDrawer(),

      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Text(
          _getTitle(_currentIndex),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              // TODO: thêm hành động đăng xuất nếu cần
            },
          ),
        ],
      ),

      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),

      // ✅ Thanh điều hướng cố định
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue[700],
        unselectedItemColor: Colors.blue[300],
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
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

  // ✅ Hàm đổi tiêu đề AppBar theo tab hiện tại
  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'Trang chủ';
      case 1:
        return 'Thông báo';
      case 2:
        return 'Điểm danh';
      case 3:
        return 'Tài khoản';
      default:
        return '';
    }
  }
}
