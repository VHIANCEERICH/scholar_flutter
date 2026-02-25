import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScholarLoginScreen extends StatefulWidget {
  final Function(String) onLoginSuccess;
  final VoidCallback onBack;

  const ScholarLoginScreen({
    super.key,
    required this.onLoginSuccess,
    required this.onBack,
  });

  @override
  State<ScholarLoginScreen> createState() => _ScholarLoginScreenState();
}

class _ScholarLoginScreenState extends State<ScholarLoginScreen> {
  // --- STATE VARIABLES ---
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isLoading = false;

  String localScholarType = 'Student Assistant Scholar';
  final List<String> scholarTypes = [
    'Student Assistant Scholar',
    'Varsity Scholar',
    'Academic Scholar',
    'Gift of Education Scholar',
  ];

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  // --- LOGIN LOGIC ---
  Future<void> _handleLogin() async {
    if (_userController.text.isEmpty || _passController.text.isEmpty) {
      _showError("Please enter both email and password");
      return;
    }

    setState(() => _isLoading = true);

    String urlStr = 'http://localhost/scholar_php-main/auth_login.php';

    try {
      final response = await http.post(
        Uri.parse(urlStr),
        body: {
          'email': _userController.text,
          'password': _passController.text,
        },
      );

      if (response.statusCode == 200) {
        List data = json.decode(response.body);

        if (data.isNotEmpty) {
          String dbRole = data[0]['role'].toString().toLowerCase();

          // Check if the user is actually a scholar
          if (dbRole == 'scholar') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Welcome, ${data[0]['usr_fullname']}!")),
            );
            // Tell main.dart to log us in, and pass the selected type!
            widget.onLoginSuccess(localScholarType);
          } else {
            _showError("Unauthorized: You do not have Scholar privileges.");
          }
        } else {
          _showError("Invalid Email or Password");
        }
      } else {
        _showError("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      _showError("Connection Error: Check XAMPP & CORS headers.");
      print("Error details: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. BRANDING HEADER
        const Text(
          'Scholar Login',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),

        // 2. SCHOLAR TYPE DROPDOWN
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white24),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: localScholarType,
              dropdownColor: const Color(0xFF3B125A),
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
              style: const TextStyle(color: Colors.white, fontSize: 16),
              items: scholarTypes
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (val) => setState(() => localScholarType = val!),
            ),
          ),
        ),
        const SizedBox(height: 15),

        // 3. INPUT FIELDS (Now passing controllers!)
        _inputField('Email Address', Icons.email_outlined, _userController),
        const SizedBox(height: 15),
        _inputField('Password', Icons.lock_outline, _passController,
            isObscure: true),

        const SizedBox(height: 30),

        // 4. LOGIN BUTTON / LOADING SPINNER
        if (_isLoading)
          const CircularProgressIndicator(color: Colors.white)
        else
          _loginBtn('LOGIN', _handleLogin),

        // 5. BACK BUTTON
        const SizedBox(height: 10),
        TextButton(
          onPressed: widget.onBack,
          child: const Text(
            'Go Back',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  // Updated to accept TextEditingController
  Widget _inputField(
      String hint, IconData icon, TextEditingController controller,
      {bool isObscure = false}) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54, fontSize: 14),
        prefixIcon: Icon(icon, color: Colors.white70, size: 20),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.white12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.white54),
        ),
      ),
    );
  }

  Widget _loginBtn(String label, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}
