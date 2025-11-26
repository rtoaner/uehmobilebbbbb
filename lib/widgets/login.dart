import 'package:flutter/material.dart';
import 'package:uehmobile/widgets/register.dart';
import '../helpers/utils.dart';
import '../menu/bottom_navigation.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required String title});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Đăng nhập")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: email, decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: "Password")),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                final user = await loginUser(email.text, password.text);

                if (user != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const BottomNavigation()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Sai email hoặc mật khẩu"))
                  );
                }
              },
              child: const Text("Đăng nhập"),
            ),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterPage(title: '',)),
                );
              },
              child: const Text("Chưa có tài khoản? Đăng ký"),
            )
          ],
        ),
      ),
    );
  }
}
