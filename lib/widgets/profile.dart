import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:barcode_widget/barcode_widget.dart';
import '../menu/drawer.dart'; // đường dẫn đến file drawer.dart của bạn

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, this.title = 'Tài khoản'});
  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,



      //
      drawer: const UehDrawer(),

      body: Stack(
        children: [
          // phần nền (trắng + cam)
          Column(
            children: [
              // phần trắng
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // barcode
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: BarcodeWidget(
                          barcode: Barcode.code128(),
                          data: '31231026864',
                          width: 500,
                          height: 100,
                        ),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        'Nguyễn Ngọc Yến Nhi',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE8955E),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // phần cam
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  color: const Color(0xFFE8955E),
                  padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _InfoItem(label: 'Ngày sinh', value: '17/01/2005'),
                      _InfoItem(label: 'Giới tính', value: 'Nữ'),
                      _InfoItem(label: 'Khóa', value: 'DHCQK49'),
                      _InfoItem(label: 'Nơi sinh', value: 'Kon Tum'),
                      _InfoItem(
                          label: 'Hệ',
                          value: 'DH\n- Niên học:\n2023 - 2026'),
                      Spacer(),
                      Text(
                        'UEH',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Ảnh đại diện
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4 - 80,
            right: 80,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'images/anhthe.jpeg',
                  width: 520,
                  height: 720,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const _InfoItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
