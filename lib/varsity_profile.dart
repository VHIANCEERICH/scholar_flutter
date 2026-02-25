import 'package:flutter/material.dart';
import 'profile_components.dart';

class VarsityProfileScreen extends StatefulWidget {
  const VarsityProfileScreen({super.key});

  @override
  State<VarsityProfileScreen> createState() => _VarsityProfileScreenState();
}

class _VarsityProfileScreenState extends State<VarsityProfileScreen> {
  String? selectedSport;
  String? selectedSemester = "AY 2025-2026 2nd Semester";
  bool isFiltered = false;

  final Map<String, Map<String, String>> varsityData = {
    'Basketball (Men)': {
      'coach': 'Coach Ravena',
      'schedule': 'Mon/Wed/Fri 4PM-7PM',
      'venue': 'Main Gymnasium',
      'status': 'Active'
    },
    'Basketball (Women)': {
      'coach': 'Coach Cariaso',
      'schedule': 'Tue/Thu 4PM-7PM',
      'venue': 'Main Gymnasium',
      'status': 'Active'
    },
    'Volleyball': {
      'coach': 'Coach Reyes',
      'schedule': 'Daily 6AM-9AM',
      'venue': 'Sports Center',
      'status': 'Active'
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5B4E3), // Restored original background
      body: BaseProfileLayout(
        title: "Varsity Profile",
        role: "Varsity Scholar",
        semester: selectedSemester,
        filters: [
          buildProfileDropdown(
              selectedSemester,
              "Select Semester",
              ["AY 2025-2026 2nd Semester", "AY 2025-2026 1st Semester"],
              (val) => setState(() => selectedSemester = val)),
          buildProfileDropdown(
              selectedSport,
              "Select Sport Type",
              varsityData.keys.toList(),
              (val) => setState(() {
                    selectedSport = val;
                    isFiltered = false;
                  })),
        ],
        onFilter: () {
          if (selectedSport != null) {
            setState(() => isFiltered = true);
          }
        },
        content: _buildMainContent(),
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
        border: Border.all(color: const Color(0xFFAB47BC), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: isFiltered && selectedSport != null
          ? ProfileDataTable(
              headers: const [
                "Sport",
                "Head Coach",
                "Training Schedule",
                "Status"
              ],
              data: [
                selectedSport!,
                varsityData[selectedSport]!['coach']!,
                varsityData[selectedSport]!['schedule']!,
                varsityData[selectedSport]!['status']!,
              ],
            )
          : buildEmptyState(
              "Please select your Sport Type and click Filter to view details."),
    );
  }
}
