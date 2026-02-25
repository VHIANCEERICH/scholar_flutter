import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5B4E3), // Consistent theme
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'REPORTS MANAGEMENT',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D0D44),
                  letterSpacing: 1.2),
            ),
            const SizedBox(height: 30),

            // --- STATS SUMMARY BAR ---
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                _buildStatCard(
                    'Total Scholars', '120', Icons.people_alt, Colors.blue),
                _buildStatCard(
                    'Approved', '85', Icons.check_circle, Colors.green),
                _buildStatCard('Pending', '25', Icons.pending, Colors.orange),
                _buildStatCard('Rejected', '10', Icons.cancel, Colors.red),
              ],
            ),
            const SizedBox(height: 40),

            // --- GRAPHS SECTION ---
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildChartContainer(
                    title: 'Scholars by Type',
                    child: _buildFixedBarChart(),
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  flex: 1,
                  child: _buildChartContainer(
                    title: 'Status Distribution',
                    child: _buildFixedPieChart(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color accent) {
    return Container(
      width: 230,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 8))
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: accent.withOpacity(0.1),
            child: Icon(icon, color: accent),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
              Text(value,
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D0D44))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartContainer({required String title, required Widget child}) {
    return Container(
      height: 450,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D0D44))),
          const Divider(height: 30),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _buildFixedBarChart() {
    final List<Map<String, dynamic>> data = [
      {'label': 'Academic', 'value': 0.65, 'color': const Color(0xFF6A1B9A)},
      {
        'label': 'Student Assistant',
        'value': 0.85,
        'color': const Color(0xFFAB47BC)
      },
      {'label': 'Varsity', 'value': 0.45, 'color': const Color(0xFFCE93D8)},
      {'label': 'Gift of Ed.', 'value': 0.35, 'color': const Color(0xFFE1BEE7)},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: data.map((item) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('${(item['value'] * 100).toInt()}%',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 8),
            Container(
              width: 50,
              height: (250 * (item['value'] as double)),
              decoration: BoxDecoration(
                color: item['color'],
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8)),
              ),
            ),
            const SizedBox(height: 12),
            Text(item['label'],
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildFixedPieChart() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.pie_chart_outline,
            size: 180, color: Color(0xFF6A1B9A)),
        const SizedBox(height: 30),
        _legendItem('Approved', Colors.green),
        _legendItem('Pending', Colors.orange),
        _legendItem('Rejected', Colors.red),
      ],
    );
  }

  Widget _legendItem(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 10),
          Text(text,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
