import 'package:flutter/material.dart';
import 'package:my_app/admin_managescholar.dart';
import 'admin_dashboard.dart';
import 'verification.dart';
import 'monitoring.dart';
import 'reports.dart';
import 'announcement.dart';
import 'admin_managescholar.dart'; // IMPORT: Your new management module

class AdminMainSkeleton extends StatefulWidget {
  final VoidCallback onLogout;

  const AdminMainSkeleton({super.key, required this.onLogout});

  @override
  State<AdminMainSkeleton> createState() => _AdminMainSkeletonState();
}

class _AdminMainSkeletonState extends State<AdminMainSkeleton> {
  String activePage = 'Dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // --- THE PURPLE SIDEBAR ---
          Container(
            width: 260,
            color: const Color(0xFF3B125A), // Deep Purple Sidebar
            child: Column(
              children: [
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/jmclogo.png',
                    height: 60,
                    width: 60,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.school,
                        size: 40,
                        color: Color(0xFF3B125A)),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Scholar Management',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                const SizedBox(height: 40),

                // Navigation Menu
                _navItem(Icons.grid_view, 'Dashboard'),
                // ADDED: Manage Scholar Navigation
                _navItem(Icons.people_alt_outlined, 'Manage Scholar'),
                _navItem(Icons.verified_outlined, 'Verification'),
                _navItem(Icons.monitor_outlined, 'Monitoring'),
                _navItem(Icons.folder_outlined, 'Reports'),
                _navItem(Icons.campaign_outlined, 'Announcements'),
                _navItem(Icons.logout_outlined, 'Logout', isLogout: true),

                const Spacer(),

                // User Profile Footer
                _buildAdminUserFooter(),
              ],
            ),
          ),

          // --- CONTENT AREA ---
          Expanded(
            child: Column(
              children: [
                // Welcome Header Section
                Container(
                  height: 110,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/jmcbg.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: const Color(0xFF3B125A)
                        .withOpacity(0.7), // Matched sidebar purple
                    padding: const EdgeInsets.only(left: 25, top: 35),
                    child: const Text(
                      "Welcome, Admin!",
                      style: TextStyle(
                          color: Color(0xFFFFEB3B), // Yellow Text
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                // DYNAMIC CONTENT
                Expanded(
                  child: Container(
                    // UPDATED: Content background color to your specific hex
                    color: const Color(0xFFC0B3C6),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: _getPageContent(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPageContent() {
    // UPDATED: Switch case to include 'Manage Scholar'
    switch (activePage) {
      case 'Dashboard':
        return const AdminDashboardView();
      case 'Manage Scholar':
        return const ManageScholarScreen();
      case 'Verification':
        return const VerificationScreen();
      case 'Monitoring':
        return const MonitoringScreen();
      case 'Reports':
        return const ReportsScreen();
      case 'Announcements':
        return const AnnouncementScreen();
      default:
        return const AdminDashboardView();
    }
  }

  Widget _navItem(IconData icon, String label, {bool isLogout = false}) {
    bool isActive = activePage == label;
    return ListTile(
      // Visual indicator for active menu item
      tileColor: isActive ? Colors.white.withOpacity(0.1) : Colors.transparent,
      leading: Icon(icon,
          color: isActive ? const Color(0xFFFFEB3B) : Colors.white, size: 22),
      title: Text(label,
          style: TextStyle(
            color: isActive ? const Color(0xFFFFEB3B) : Colors.white,
            fontSize: 14,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          )),
      onTap: () {
        if (isLogout) {
          widget.onLogout();
        } else {
          setState(() => activePage = label);
        }
      },
    );
  }

  Widget _buildAdminUserFooter() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 25),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white54,
            child: Icon(Icons.person, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('System User',
                  style: TextStyle(
                      color: Color(0xFFFFEB3B),
                      fontWeight: FontWeight.bold,
                      fontSize: 13)),
              Text('System Administrator',
                  style: TextStyle(color: Colors.white70, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}
