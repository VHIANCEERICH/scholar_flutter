import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RoleSelectionScreen extends StatefulWidget {
  final Function(String) onRoleSelected;

  const RoleSelectionScreen({super.key, required this.onRoleSelected});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isLoading = false;

  // --- LOGIN LOGIC ---
  Future<void> _handleLogin(String selectedRole) async {
    if (_userController.text.isEmpty || _passController.text.isEmpty) {
      _showError("Please enter both username and password");
      return;
    }

    setState(() => _isLoading = true);

    // Note: Using 10.0.2.2 if you are using an Android Emulator,
    // or your local IP (e.g., 192.168.x.x) if using a real device.
    String urlStr = 'http://localhost/scholar/auth_login.php' +
        'username=${_userController.text}&password=${_passController.text}';

    try {
      final response = await http.get(Uri.parse(urlStr));

      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        if (data.isNotEmpty) {
          String dbRole =
              data[0]['role'].toString().toLowerCase(); // admin or scholar
          String targetRole = selectedRole.toLowerCase(); // admin or scholars

          // Basic validation to ensure role matches the button clicked
          if (dbRole == 'admin' && targetRole == 'admin' ||
              dbRole == 'scholar' && targetRole == 'scholars') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Welcome, ${data[0]['usr_fullname']}!")),
            );

            // Proceed to the next screen via the callback
            widget.onRoleSelected(selectedRole);
          } else {
            _showError("Unauthorized: Role mismatch.");
          }
        } else {
          _showError("Invalid Username or Password");
        }
      } else {
        _showError("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      _showError("Connection Error: Check if XAMPP is running.");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.redAccent),
    );
  }

  // --- UI COMPONENTS ---
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/jmclogo.png', height: 80),
          const SizedBox(height: 15),
          const Text(
            'JOSE MARIA COLLEGE\nFOUNDATION, INC.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Divider(
              color: Colors.white38, thickness: 1, indent: 20, endIndent: 20),
          const SizedBox(height: 10),

          // --- LOGIN FIELDS ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TextField(
                  controller: _userController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputStyle("Username", Icons.person_outline),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _passController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputStyle("Password", Icons.lock_outline),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),
          if (_isLoading)
            const CircularProgressIndicator(color: Colors.white)
          else ...[
            _roleBtn(
                Icons.vpn_key_outlined, 'Admin', () => _handleLogin('Admin')),
            const SizedBox(height: 15),
            _roleBtn(Icons.school_outlined, 'Scholars',
                () => _handleLogin('Scholars')),
          ],
        ],
      ),
    );
  }

  InputDecoration _inputStyle(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white70),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.white38),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.white),
      ),
    );
  }

  Widget _roleBtn(IconData icon, String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: 10),
              Text(label,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
