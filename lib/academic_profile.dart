import 'package:flutter/material.dart';
import 'profile_components.dart';

class AcademicProfileScreen extends StatefulWidget {
  const AcademicProfileScreen({super.key});

  @override
  State<AcademicProfileScreen> createState() => _AcademicProfileScreenState();
}

class _AcademicProfileScreenState extends State<AcademicProfileScreen> {
  String? selectedSemester = "AY 2025-2026 2nd Semester";
  String? selectedType;
  bool isFiltered = false;

  final Map<String, Map<String, String>> academicTypes = {
    'Academic Type A': {
      'benefit': '100% Tuition Discount',
      'gwa_req': '1.00 - 1.25',
      'allowance': 'PHP 5,000.00',
    },
    'Academic Type B': {
      'benefit': '75% Tuition Discount',
      'gwa_req': '1.26 - 1.50',
      'allowance': 'PHP 3,000.00',
    },
    'Academic Type C': {
      'benefit': '50% Tuition Discount',
      'gwa_req': '1.51 - 1.75',
      'allowance': 'None',
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5B4E3), // Restored original background
      body: BaseProfileLayout(
        title: "Academic Profile",
        role: "Academic Excellence Scholar",
        semester: selectedSemester,
        filters: [
          buildProfileDropdown(
            selectedSemester,
            "Select Semester",
            ["AY 2025-2026 2nd Semester", "AY 2025-2026 1st Semester"],
            (val) => setState(() {
              selectedSemester = val;
              isFiltered = false;
            }),
          ),
          buildProfileDropdown(
            selectedType,
            "Select Academic Type",
            academicTypes.keys.toList(),
            (val) => setState(() {
              selectedType = val;
              isFiltered = false;
            }),
          ),
        ],
        onFilter: () {
          if (selectedType != null) {
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
      child: isFiltered && selectedType != null
          ? ProfileDataTable(
              headers: const [
                "Scholarship Type",
                "Benefit",
                "GWA Req.",
                "Monthly Stipend"
              ],
              data: [
                selectedType!,
                academicTypes[selectedType]!['benefit']!,
                academicTypes[selectedType]!['gwa_req']!,
                academicTypes[selectedType]!['allowance']!,
              ],
            )
          : buildEmptyState(
              "Please select your Academic Type and click Filter."),
    );
  }
}
