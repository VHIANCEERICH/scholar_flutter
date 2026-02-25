import 'package:flutter/material.dart';

class VarsityDashboard extends StatelessWidget {
  const VarsityDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5B4E3), // Formal Lavender Background
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Use the same text style as Notification/Profile for formality
            const Text(
              "Varsity Scholar Dashboard",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D0D44),
              ),
            ),
            const SizedBox(height: 25),

            _buildFormalContentBox(
              title: "Current Athletic Season Info",
              children: [
                _infoRow(Icons.event_available, "Next Game",
                    "Oct 28 vs. State University"),
                const SizedBox(height: 12),
                _infoRow(Icons.fitness_center, "Daily Training",
                    "5:00 AM - 8:00 AM"),
                const SizedBox(height: 12),
                _infoRow(Icons.assignment_turned_in, "Coach's Note",
                    "Submit injury reports"),
              ],
            ),
            const SizedBox(height: 20),

            const ActivityFeedBox(label: "Upcoming Game Schedule"),

            const SizedBox(height: 20),

            _buildFormalContentBox(
              title: "Team Announcements & Feedback",
              children: [
                _announcementItem("Next Tournament",
                    "Regional Qualifiers - Oct 24", Icons.emoji_events),
                const SizedBox(height: 15),
                _announcementItem(
                  "Coach's Feedback",
                  "Great hustle in practice! Focus on defensive rotations.",
                  Icons.feedback,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Formal Box Styling matching Profile/Notification
  Widget _buildFormalContentBox(
      {required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFAB47BC), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A))),
          const Divider(height: 30),
          ...children,
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF6A1B9A)),
        const SizedBox(width: 10),
        Text("$title: ", style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }

  Widget _announcementItem(String title, String subtitle, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF6A1B9A), size: 24),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle,
                  style: const TextStyle(fontSize: 13, color: Colors.black87)),
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
      width: double.infinity,
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
