import 'package:flutter/material.dart';
import 'dashboard_components.dart';

class StudentAssistantDashboard extends StatelessWidget {
  const StudentAssistantDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFC5B4E3), // Unified Lavender Background
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Student Assistant Dashboard",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D0D44),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 25),
            _buildSAStats(),
            const SizedBox(height: 25),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildStyledContentBox(
                    title: "Submission Status",
                    children: [
                      _statusRow("DTR (Daily Time Record)", "Submitted",
                          const Color(0xFFCE93D8)),
                      const SizedBox(height: 12),
                      _statusRow("Accomplishment Report", "Pending",
                          const Color(0xFFFFCC80)),
                      const SizedBox(height: 12),
                      _statusRow(
                          "Duty Schedule", "Verified", const Color(0xFFA5D6A7)),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                const Expanded(
                  flex: 3,
                  child: ActivityFeedBox(label: "Recent Duty Logs"),
                ),
              ],
            ),
            const SizedBox(height: 25),
            _buildStyledContentBox(
              title: "Request Status",
              children: [
                Row(
                  children: [
                    const Text("Overtime Request (Event Support)",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87)),
                    const Spacer(),
                    _badge("Pending", const Color(0xFFFFCC80)),
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Text(
                    "Ensure your supervisor has signed the physical DTR before uploading.",
                    style: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF4A148C)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSAStats() {
    return Row(
      children: [
        _statCard("Hours Rendered", "150", const Color(0xFFE3F2FD),
            const Color(0xFF0D47A1)),
        const SizedBox(width: 20),
        _statCard("Duty Status", "On-Going", const Color(0xFFE8F5E9),
            const Color(0xFF2E7D32)),
        const SizedBox(width: 20),
        _statCard("Remaining Hours", "50", const Color(0xFFFFF3E0),
            const Color(0xFFE65100)),
      ],
    );
  }

  Widget _statCard(String label, String value, Color bg, Color textCol) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54)),
            const SizedBox(height: 10),
            Text(value,
                style: TextStyle(
                    fontSize: 36, fontWeight: FontWeight.bold, color: textCol)),
          ],
        ),
      ),
    );
  }

  Widget _buildStyledContentBox(
      {required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C))),
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
        Text(label,
            style: const TextStyle(color: Colors.black87, fontSize: 14)),
        _badge(status, color),
      ],
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Text(text,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black87)),
    );
  }
}

class ActivityFeedBox extends StatelessWidget {
  final String label;
  const ActivityFeedBox({super.key, this.label = "Activity Feed"});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        color: const Color(0xFFD1C4E9).withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white),
      ),
      child: Center(
        child: Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A148C),
                fontSize: 16)),
      ),
    );
  }
}
