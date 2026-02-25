import 'package:flutter/material.dart';
import 'dashboard_components.dart';

class AcademicDashboard extends StatelessWidget {
  const AcademicDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5B4E3), // Formal Lavender Background
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Academic Scholar Dashboard",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D0D44),
              ),
            ),
            const SizedBox(height: 25),

            // Academic Stats (GWA & Eligibility)
            _buildGradeStats(),
            const SizedBox(height: 20),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Document Status Box
                Expanded(
                  flex: 2,
                  child: _buildFormalContentBox(
                    title: "Document Status",
                    children: [
                      _statusRow(
                          "Renewal Form", "Submitted", Colors.purple.shade300),
                      const SizedBox(height: 12),
                      _statusRow(
                          "Grade Report", "Pending", Colors.orange.shade300),
                      const SizedBox(height: 12),
                      _statusRow(
                          "Good Moral Cert", "Verified", Colors.green.shade300),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                // Activity Feed
                const Expanded(
                  flex: 3,
                  child: ActivityFeedBox(label: "Academic Announcements"),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Reminders Section
            _buildFormalContentBox(
              title: "Study Schedule & Reminders",
              children: [
                _academicItem("Midterm Exams",
                    "Oct 25-27 - General Engineering", Icons.menu_book_rounded),
                const SizedBox(height: 15),
                _academicItem("Scholarship Assembly", "Friday, 3:00 PM - AVR 1",
                    Icons.groups_rounded),
                const SizedBox(height: 15),
                _academicItem(
                    "Dean's List Deadline",
                    "Ensure grades are encoded by Oct 30",
                    Icons.notification_important_rounded),
              ],
            ),
            const SizedBox(height: 20),

            // Feedback Section
            _buildFormalContentBox(
              title: "Scholarship Request Feedback",
              children: [
                Row(
                  children: [
                    const Text("Renewal Application",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Spacer(),
                    _badge("Approved", Colors.green.shade300),
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(
                        0xFFF3E5F5), // Light purple background for feedback
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Keep up the excellent GWA! Your scholarship has been renewed for the next semester.",
                    style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF2D0D44)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeStats() {
    return Row(
      children: [
        Expanded(
            child: DashProps.statBox(
                "Current GWA", "1.25", Colors.white, const Color(0xFF6A1B9A))),
        const SizedBox(width: 15),
        Expanded(
            child: DashProps.statBox(
                "Min. Req", "1.75", Colors.white, const Color(0xFFAB47BC))),
        const SizedBox(width: 15),
        Expanded(
            child: DashProps.statBox("Dean's List", "Qualified",
                const Color(0xFFFFD54F), const Color(0xFF2D0D44))),
      ],
    );
  }

  Widget _buildFormalContentBox(
      {required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFAB47BC), width: 2),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF6A1B9A))),
          const Divider(height: 25),
          ...children,
        ],
      ),
    );
  }

  Widget _statusRow(String label, String status, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13)),
        _badge(status, color),
      ],
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: Text(text,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }

  Widget _academicItem(String title, String subtitle, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF6A1B9A), size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13)),
              Text(subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
        ),
      ],
    );
  }
}

class ActivityFeedBox extends StatelessWidget {
  final String label;
  const ActivityFeedBox({super.key, this.label = "Activity Feed"});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFAB47BC), width: 2),
      ),
      child: Center(
        child: Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFF2D0D44))),
      ),
    );
  }
}
