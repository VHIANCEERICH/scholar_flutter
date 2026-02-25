import 'package:flutter/material.dart';
import 'profile_components.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? selectedArea;
  String? selectedSemester = "AY 2025-2026 2nd Semester";
  bool isFiltered = false;

  final List<String> semesters = [
    "AY 2025-2026 2nd Semester",
    "AY 2025-2026 1st Semester",
    "Summer - 2025"
  ];

  final Map<String, Map<String, String>> areaData = {
    'Library': {'duty': '8.00', 'boss': 'Athisa Manalo', 'req': '250'},
    'Canteen': {'duty': '10.50', 'boss': 'Chef Maria', 'req': '250'},
    'Registrar': {'duty': '12.00', 'boss': 'John Doe', 'req': '250'},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Restored original light purple background
      backgroundColor: const Color(0xFFC5B4E3),
      body: BaseProfileLayout(
        title: "Profile",
        role: "Student Assistant Scholar",
        semester: selectedSemester,
        filters: [
          buildProfileDropdown(selectedSemester, "Select Semester", semesters,
              (val) => setState(() => selectedSemester = val)),
          const SizedBox(width: 15),
          buildProfileDropdown(
              selectedArea,
              "Select Area",
              areaData.keys.toList(),
              (val) => setState(() => selectedArea = val)),
        ],
        onFilter: () => setState(() => isFiltered = selectedArea != null),
        content: _buildMainContent(),
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            // Subtle shadow for formal depth
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        // Branded border matching the notification system
        border: Border.all(color: const Color(0xFFAB47BC), width: 2),
      ),
      child: isFiltered && selectedArea != null
          ? ProfileDataTable(
              headers: const [
                "Assign Area",
                "Duty Hours",
                "Supervisor",
                "Required Hours"
              ],
              data: [
                selectedArea!,
                areaData[selectedArea]!['duty']!,
                areaData[selectedArea]!['boss']!,
                areaData[selectedArea]!['req']!,
              ],
            )
          : buildEmptyState(
              "Select an academic term and area to view your official records."),
    );
  }
}
