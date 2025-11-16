import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UehDrawer extends StatelessWidget {
  const UehDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Logo UEH
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40),
            color: Colors.white,
            child: Image.asset(
              'images/ueh-logo.png',
              height: 60,
            ),
          ),

          // Danh sách menu
          Expanded(
            child: Container(
              color: const Color(0xFFE8955E),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildMenuItem(context, Icons.article, 'Tin tức UEH', '/news'),
                  _buildMenuItem(context, Icons.emoji_events, 'Sự kiện UEH', '/events'),
                  _buildMenuItem(context, Icons.description, 'Xem điểm', '/grades'),
                  _buildMenuItem(context, Icons.calendar_today, 'Thời khóa biểu', '/schedule'),
                  _buildMenuItem(context, Icons.schedule, 'Lịch thi', '/exam'),
                  _buildMenuItem(context, Icons.eco, 'UEH Go Green Station', '/green'),
                  _buildMenuItem(context, Icons.phone, 'Liên hệ trực tiếp UEH', '/login'),
                  _buildMenuItem(context, Icons.military_tech, 'Đã điểm danh', '/register'),
                  _buildMenuItem(context, Icons.language, 'Hoạt động ngoại khóa', '/profile'),
                  _buildMenuItem(context, Icons.work, 'Công việc làm UEH', '/jobs'),
                  _buildMenuItem(context, Icons.map, 'UEH Wayfinding', '/map'),
                  _buildMenuItem(context, Icons.print, 'Photocopy', '/copy'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
      onTap: () {
        Navigator.pop(context); // đóng Drawer
        context.go(route); // điều hướng qua router
      },
    );
  }
}
