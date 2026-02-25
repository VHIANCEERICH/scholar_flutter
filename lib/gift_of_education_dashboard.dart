import 'package:flutter/material.dart';
import 'dashboard_components.dart';

class GiftOfEducationDashboard extends StatelessWidget {
  const GiftOfEducationDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5B4E3), // Formal Lavender Background
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header
            const Text(
              "Gift of Education Program",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D0D44),
              ),
            ),
            const SizedBox(height: 25),

            // 2. Scholarship Stats (Service & Donor Info)
            _buildEducationStats(),
            const SizedBox(height: 20),

            // 3. Middle Section: Service Hours & Feed
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left: Community Service Progress Card
                Expanded(
                  flex: 2,
                  child: _buildFormalContentBox(
                    title: "Service Hours Progress",
                    children: [
                      const Text("Social Outreach Goal",
                          style:
                              TextStyle(fontSize: 12, color: Colors.black54)),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: 0.8,
                        backgroundColor: Colors.grey.shade200,
                        color:
                            const Color(0xFFAB47BC), // Branded Purple Progress
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      const SizedBox(height: 12),
                      const Text("40 / 50 Hours Completed",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6A1B9A))),
                      const Divider(height: 30),
                      _statusRow("Next Activity:", "Coastal Cleanup",
                          Colors.blue.shade300),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                // Right: Activity Feed
                const Expanded(
                  flex: 3,
                  child: ActivityFeedBox(label: "Community Service Feed"),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 4. Donor & Appreciation Section
            _buildFormalContentBox(
              title: "Donor Connection & Updates",
              children: [
                _outreachItem(
                    "Thank You Letter",
                    "Deadline: Oct 30 - Write your semester update to your donor.",
                    Icons.volunteer_activism),
                const SizedBox(height: 15),
                _outreachItem(
                    "Sponsor Meet-up",
                    "Virtual Gathering on Nov 5, 4:00 PM via Zoom.",
                    Icons.video_call),
                const SizedBox(height: 15),
                _outreachItem(
                    "Gift Distribution",
                    "Volunteers needed for basic education kit distribution.",
                    Icons.card_giftcard),
              ],
            ),
            const SizedBox(height: 20),

            // 5. Admin Feedback / Renewal Status
            _buildFormalContentBox(
              title: "Grant Renewal Status",
              children: [
                Row(
                  children: [
                    const Text("Semestral Grant",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Spacer(),
                    _badge("Active", Colors.green.shade400),
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color:
                        const Color(0xFFF3E5F5), // Light purple tinted feedback
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Your commitment to community service is inspiring! Ensure your thank-you letter is submitted on time to maintain grant eligibility.",
                    style: TextStyle(
                        fontSize: 13,
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

  // --- FORMAL UI HELPERS ---

  Widget _buildFormalContentBox(
      {required String title, required List<Widget> children}) {
    return Container(
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A))),
          const Divider(height: 30),
          ...children,
        ],
      ),
    );
  }

  Widget _buildEducationStats() {
    return Row(
      children: [
        Expanded(
            child: DashProps.statBox(
                "Stipend", "Released", Colors.white, const Color(0xFF43A047))),
        const SizedBox(width: 15),
        Expanded(
            child: DashProps.statBox(
                "Progress", "80%", Colors.white, const Color(0xFFFB8C00))),
        const SizedBox(width: 15),
        Expanded(
            child: DashProps.statBox("Donor", "Alumni '94",
                const Color(0xFFFFD54F), const Color(0xFF2D0D44))),
      ],
    );
  }

  Widget _statusRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(color: Colors.black87, fontSize: 13)),
        _badge(value, color),
      ],
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }

  Widget _outreachItem(String title, String subtitle, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF6A1B9A), size: 24),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
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
      height: 180, // Slightly taller for this dashboard
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFAB47BC), width: 2),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Color(0xFF3B125A)),
        ),
      ),
    );
  }
}
