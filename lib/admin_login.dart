import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final String selectedRole;
  final Function(String) onLoginSuccess;
  final VoidCallback onBack;

  const LoginScreen({
    super.key,
    required this.selectedRole,
    required this.onLoginSuccess,
    required this.onBack,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String localScholarType = 'Student Assistant Scholar';
  final List<String> scholarTypes = [
    'Student Assistant Scholar',
    'Varsity Scholar',
    'Academic Scholar',
    'Gift of Education Scholar',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. BRANDING (Same as Role Selection)
        // Note: The Logo/Title is handled in main.dart's Column,
        // but we add the "Role" style header here for consistency.

        Text(
          widget.selectedRole == 'Admin' ? 'Admin Login' : 'Scholar Login',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),

        // 2. SCHOLAR TYPE DROPDOWN (Only if not Admin)
        if (widget.selectedRole != 'Admin') ...[
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
        ],

        // 3. INPUT FIELDS
        _inputField('Email Address', Icons.email_outlined),
        const SizedBox(height: 15),
        _inputField('Password', Icons.lock_outline, isObscure: true),

        const SizedBox(height: 30),

        // 4. LOGIN BUTTON (Pill-shaped like Role Selection)
        _loginBtn('LOGIN', () => widget.onLoginSuccess(localScholarType)),

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

  Widget _inputField(String hint, IconData icon, {bool isObscure = false}) {
    return TextField(
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
