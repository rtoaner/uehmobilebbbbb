import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Import đúng – KHÔNG dùng 2 dòng!
import '../helpers/utils.dart';

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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Quan trọng – đảm bảo DB được khởi tạo!
    initDB();
  }

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _classController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    final account = _accountController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final name = _nameController.text.trim();
    final className = _classController.text.trim();

    if (account.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        name.isEmpty ||
        className.isEmpty) {
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

    setState(() => _isLoading = true);

    try {
      final user = {
        'email': account,
        'password': password,
        'fullname': name,
        'className': className,
      };

      await registerUser(user);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng ký thành công'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lỗi đăng ký: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

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
          child: FaIcon(icon, color: Colors.green, size: 24),
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
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
              const Text(
                'Đăng ký',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Chào mừng bạn đến với chúng tôi!',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 24),

              _buildTextField(
                controller: _accountController,
                label: 'Tài khoản (email)',
                hint: 'Tên đăng nhập / email',
                icon: FontAwesomeIcons.user,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                controller: _passwordController,
                label: 'Mật khẩu',
                hint: 'Nhập mật khẩu',
                icon: FontAwesomeIcons.lock,
                obscureText: !_isPasswordVisible,
                suffixIcon: GestureDetector(
                  onTap: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                  child: FaIcon(
                    _isPasswordVisible
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              _buildTextField(
                controller: _confirmPasswordController,
                label: 'Nhập lại mật khẩu',
                hint: 'Xác nhận mật khẩu',
                icon: FontAwesomeIcons.lock,
                obscureText: !_isConfirmPasswordVisible,
                suffixIcon: GestureDetector(
                  onTap: () => setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
                  child: FaIcon(
                    _isConfirmPasswordVisible
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              _buildTextField(
                controller: _nameController,
                label: 'Họ và tên',
                hint: 'Nhập họ và tên',
                icon: FontAwesomeIcons.userTag,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                controller: _classController,
                label: 'Lớp',
                hint: 'Nhập lớp',
                icon: FontAwesomeIcons.school,
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    'Đăng ký',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Đã có tài khoản? Đăng nhập',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
