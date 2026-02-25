import 'package:flutter/material.dart';
import 'varsity_dashboard.dart';
import 'academic_dashboard.dart';
import 'gift_of_education_dashboard.dart';
import 'student_assistant_dashboard.dart';
import 'profile.dart';
import 'varsity_profile.dart';
import 'academic_profile.dart';
import 'upload_files.dart';
import 'notification.dart';

class ScholarMainSkeleton extends StatefulWidget {
  final String scholarType;
  final VoidCallback onLogout;

  const ScholarMainSkeleton({
    super.key,
    required this.scholarType,
    required this.onLogout,
  });

  @override
  State<ScholarMainSkeleton> createState() => _ScholarMainSkeletonState();
}

class _ScholarMainSkeletonState extends State<ScholarMainSkeleton> {
  String activePage = 'Dashboard';

  Widget _getPageContent() {
    if (activePage == 'Dashboard') {
      switch (widget.scholarType) {
        case 'Varsity Scholar':
          return const VarsityDashboard();
        case 'Academic Scholar':
          return const AcademicDashboard();
        case 'Gift of Education Scholar':
          return const GiftOfEducationDashboard();
        case 'Student Assistant Scholar':
          return const StudentAssistantDashboard();
        default:
          return const AcademicDashboard();
      }
    }

    if (activePage == 'Profile') {
      switch (widget.scholarType) {
        case 'Academic Scholar':
          return const AcademicProfileScreen();
        case 'Varsity Scholar':
          return const VarsityProfileScreen();
        case 'Student Assistant Scholar':
          return const ProfileScreen();
        default:
          return const ProfileScreen();
      }
    }

    switch (activePage) {
      case 'Upload Files':
        return const UploadFilesScreen();
      case 'Notification':
        return const NotificationScreen();
      default:
        return const Center(child: Text("Page Not Found"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // --- SIDEBAR (Updated with JMC Logo) ---
          Container(
            width: 260,
            color: const Color(0xFF3B125A),
            child: Column(
              children: [
                const SizedBox(height: 40),
                // UPDATED: CircleAvatar with JMC Logo
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
                const SizedBox(height: 15),
                const Text(
                  'Scholar\nManagement',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                _navItem(Icons.grid_view_rounded, 'Dashboard'),
                _navItem(Icons.person_outline, 'Profile'),
                _navItem(Icons.upload_file, 'Upload Files'),
                _navItem(Icons.notifications_none, 'Notification'),
                _navItem(Icons.logout, 'Logout', isLogout: true),
                const Spacer(),
                _buildSystemUserSection(),
              ],
            ),
          ),

          // --- MAIN CONTENT AREA ---
          Expanded(
            child: Column(
              children: [
                // UPDATED: Header with JMC Background
                _buildWelcomeHeader("Welcome, Marian!"),

                Expanded(
                  child: Container(
                    color: const Color(0xFFD1C4E9).withOpacity(0.3),
                    child: _getPageContent(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, {bool isLogout = false}) {
    bool isActive = activePage == label;
    return ListTile(
      tileColor: isActive ? Colors.white.withOpacity(0.1) : Colors.transparent,
      leading: Icon(icon,
          color: isActive ? const Color(0xFFFFD54F) : Colors.white, size: 22),
      title: Text(
        label,
        style: TextStyle(
          color: isActive ? const Color(0xFFFFD54F) : Colors.white,
          fontSize: 14,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        if (isLogout) {
          widget.onLogout();
        } else {
          setState(() => activePage = label);
        }
      },
    );
  }

  // UPDATED: Header function to match Admin Layout
  Widget _buildWelcomeHeader(String msg) {
    return Container(
      height: 110, // Increased height to match Admin
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/jmcbg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        // Purple overlay for readability
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF9C27B0).withOpacity(0.7),
        padding: const EdgeInsets.only(left: 25, top: 35),
        alignment: Alignment.centerLeft,
        child: Text(
          msg,
          style: const TextStyle(
              color: Color(0xFFFFEB3B), // Consistent Yellow
              fontSize: 28,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSystemUserSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 30, top: 10),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white54,
            child: Icon(Icons.person, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Scholar User',
                    style: TextStyle(
                        color: Color(0xFFFFD54F),
                        fontWeight: FontWeight.bold,
                        fontSize: 13)),
                Text(
                  widget.scholarType,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
