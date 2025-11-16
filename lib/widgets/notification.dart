import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16),
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final String title;
  final String date;

  const _NotificationItem({required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        title: Text(title, style: const TextStyle(fontSize: 16)),
        subtitle: Text(date,
            style: const TextStyle(color: Colors.black54, fontSize: 14)),
      ),
    );
  }
}
