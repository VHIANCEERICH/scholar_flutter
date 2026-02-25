import 'dart:ui';
import 'package:flutter/material.dart';

// Ensure these imports match your actual file names
import 'role_selection.dart';
import 'admin_login.dart';
import 'admin_main.dart';
import 'scholar_main.dart';

void main() => runApp(const JMCFIScholarshipApp());

class JMCFIScholarshipApp extends StatelessWidget {
  const JMCFIScholarshipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JMCFI Scholarship Portal',
      theme: ThemeData(
        primaryColor: const Color(0xFF6A1B9A),
        fontFamily: 'Inter',
        // Ensuring buttons and text across the app look consistent
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF9C27B0),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: const MainPortalPage(),
    );
  }
}

enum PortalState { roleSelection, login, adminDashboard, scholarDashboard }

class MainPortalPage extends StatefulWidget {
  const MainPortalPage({super.key});

  @override
  State<MainPortalPage> createState() => _MainPortalPageState();
}

class _MainPortalPageState extends State<MainPortalPage> {
  PortalState currentState = PortalState.roleSelection;
  String selectedRole = '';
  String selectedScholarType = 'Student Assistant Scholar';

  @override
  Widget build(BuildContext context) {
    // --- NAVIGATION LOGIC ---
    if (currentState == PortalState.adminDashboard) {
      return AdminMainSkeleton(
        onLogout: () =>
            setState(() => currentState = PortalState.roleSelection),
      );
    }

    if (currentState == PortalState.scholarDashboard) {
      return ScholarMainSkeleton(
        scholarType: selectedScholarType,
        onLogout: () =>
            setState(() => currentState = PortalState.roleSelection),
      );
    }

    // --- PORTAL (LOGIN/ROLE SELECTION) UI ---
    return Scaffold(
      body: Stack(
        children: [
          // 1. BACKGROUND IMAGE (Full Coverage)
          Positioned.fill(
            child: Image.asset(
              'assets/jmcbg.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // 2. GLOBAL PURPLE TINT (Matches Sidebar/Header Atmosphere)
          Positioned.fill(
            child: Container(
              color: const Color(0xFF3B125A).withOpacity(0.6),
            ),
          ),

          // 3. CENTER BRANDED GLASS CARD
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  width: 480,
                  // Constraints for smaller screens/windows
                  constraints:
                      const BoxConstraints(maxWidth: 900, maxHeight: 650),
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    // UPDATED: High-Fidelity Purple Overlay (0xFF9C27B0)
                    color: const Color(0xFF9C27B0).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 25,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: currentState == PortalState.roleSelection
                        ? RoleSelectionScreen(
                            key: const ValueKey('RoleSelect'),
                            onRoleSelected: (role) {
                              setState(() {
                                selectedRole = role;
                                currentState = PortalState.login;
                              });
                            },
                          )
                        : LoginScreen(
                            key: const ValueKey('Login'),
                            selectedRole: selectedRole,
                            onLoginSuccess: (type) {
                              setState(() {
                                selectedScholarType = type;
                                currentState = selectedRole == 'Admin'
                                    ? PortalState.adminDashboard
                                    : PortalState.scholarDashboard;
                              });
                            },
                            onBack: () => setState(
                              () => currentState = PortalState.roleSelection,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
