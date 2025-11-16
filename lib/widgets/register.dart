import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _classController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    String account = _accountController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    String name = _nameController.text.trim();
    String className = _classController.text.trim();

    if (account.isEmpty || password.isEmpty || confirmPassword.isEmpty || name.isEmpty || className.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập đầy đủ thông tin'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mật khẩu và mật khẩu xác nhận không khớp'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon/Logo người dùng
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  shape: BoxShape.circle,
                ),
                child: const FaIcon(
                  FontAwesomeIcons.userPlus,
                  size: 60,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),

              // Title
              const Text(
                'Đăng ký',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Chào mừng bạn đến với chúng tôi!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 40),

              // TextField Tài khoản
              _buildTextField(
                controller: _accountController,
                label: 'Tài khoản',
                hint: 'Tên đăng nhập',
                icon: FontAwesomeIcons.user,
              ),
              const SizedBox(height: 20),

              // TextField Mật khẩu
              _buildTextField(
                controller: _passwordController,
                label: 'Mật khẩu',
                hint: 'Nhập mật khẩu',
                icon: FontAwesomeIcons.lock,
                obscureText: !_isPasswordVisible,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  child: FaIcon(
                    _isPasswordVisible
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              _buildTextField(
                controller: _confirmPasswordController,
                label: 'Nhập lại mật khẩu',
                hint: 'Xác nhận mật khẩu',
                icon: FontAwesomeIcons.lock,
                obscureText: !_isConfirmPasswordVisible,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                  child: FaIcon(
                    _isConfirmPasswordVisible
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              _buildTextField(
                controller: _nameController,
                label: 'Họ và tên',
                hint: 'Nhập họ và tên',
                icon: FontAwesomeIcons.userTag,
              ),
              const SizedBox(height: 20),

              // TextField Lớp
              _buildTextField(
                controller: _classController,
                label: 'Lớp',
                hint: 'Nhập lớp',
                icon: FontAwesomeIcons.school,
              ),
              const SizedBox(height: 30),

              // Button Đăng ký
              ElevatedButton(
                onPressed: _handleRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  shadowColor: Colors.green.shade200,
                  minimumSize: const Size(double.infinity, 55),
                ),
                child: const Text(
                  'Đăng ký',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Liên kết đăng nhập
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Đã có tài khoản? ',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () {
                      context.go('/login');
                    },
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Hàm tạo TextField với các tùy chọn như label, icon và suffix icon
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(fontSize: 18),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(fontSize: 18),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FaIcon(
            icon,
            color: Colors.green,
            size: 24,
          ),
        ),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.green, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }
}
