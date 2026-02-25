import 'package:flutter/material.dart';
import 'dart:math';

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({super.key});

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  final Random _random = Random();

  // State variable for the specific selection
  String selectedScholarType = 'Student Assistant Scholar';

  late Map<String, String> currentStats;

  @override
  void initState() {
    super.initState();
    _generateRandomStats();
  }

  // Logic to change numbers based on the specific selection
  void _generateRandomStats() {
    currentStats = {
      'total': (_random.nextInt(150) + 50).toString(),
      'pending': (_random.nextInt(30) + 2).toString(),
      'reports': (_random.nextInt(80) + 10).toString(),
      'active': (_random.nextInt(120) + 30).toString(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFC5B4E3), // Light purple background
      child: Column(
        children: [
          // 1. UPDATED DROPDOWN WITH SPECIFIC TYPES
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedScholarType,
                  isExpanded: true,
                  items: <String>[
                    'Student Assistant Scholar',
                    'Academic Scholar A',
                    'Academic Scholar B',
                    'Academic Scholar C',
                    'Varsity Scholar - Basketball',
                    'Varsity Scholar - Volleyball',
                    'Gift of Education Scholar'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: const TextStyle(fontSize: 14)),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedScholarType = newValue!;
                      _generateRandomStats(); // Randomize stats for the specific type
                    });
                  },
                ),
              ),
            ),
          ),

          // 2. STATISTICS CARDS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                _buildStatCard("Total Scholars", currentStats['total']!, const Color(0xFFE6E29C)),
                const SizedBox(width: 15),
                _buildStatCard("Pending Renewals", currentStats['pending']!, const Color(0xFFD1B3E2), textColor: Colors.red),
                const SizedBox(width: 15),
                _buildStatCard("Submitted Grade Reports", currentStats['reports']!, const Color(0xFFE2A7A7)),
                const SizedBox(width: 15),
                _buildStatCard("Active Scholarships", currentStats['active']!, const Color(0xFF8EBDC4), textColor: Colors.green),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // 3. DYNAMIC RECENT SUBMISSIONS
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Recent Submissions",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF3B125A),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: SingleChildScrollView(
                          child: DataTable(
                            headingRowColor: WidgetStateProperty.all(const Color(0xFFF3E5F5)),
                            columns: const [
                              DataColumn(label: Text('Student Name', style: TextStyle(fontWeight: FontWeight.bold))),
                              DataColumn(label: Text('Date Submitted', style: TextStyle(fontWeight: FontWeight.bold))),
                              DataColumn(label: Text('Scholarship Type', style: TextStyle(fontWeight: FontWeight.bold))),
                              DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                            ],
                            rows: _generateRandomRows(), 
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Generates random rows that reflect the specific chosen type
  List<DataRow> _generateRandomRows() {
    final List<String> names = ["Marian Rivera", "Dingdong Dantes", "Alden Richards", "Maine Mendoza", "Kathryn Bernardo", "Daniel Padilla"];
    final List<String> dates = ["Jan 20, 2026", "Jan 18, 2026", "Jan 15, 2026", "Jan 12, 2026"];
    
    int rowCount = _random.nextInt(3) + 3; 

    return List.generate(rowCount, (index) {
      bool isPending = _random.nextBool();
      
      // Extracting the sub-type for table display (e.g., "Academic A" or "Basketball")
      String displayType = selectedScholarType
          .replaceAll(" Scholar", "")
          .replaceAll("Varsity - ", "");

      return _buildSampleRow(
        names[_random.nextInt(names.length)],
        dates[_random.nextInt(dates.length)],
        displayType,
        isPending ? "Pending" : "Verified",
        isPending ? Colors.orange : Colors.blue,
      );
    });
  }

  DataRow _buildSampleRow(String name, String date, String type, String status, Color statusColor) {
    return DataRow(cells: [
      DataCell(Text(name)),
      DataCell(Text(date)),
      DataCell(Text(type)),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            status,
            style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ),
    ]);
  }

  Widget _buildStatCard(String title, String count, Color bgColor, {Color textColor = Colors.black}) {
    return Expanded(
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(count, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: textColor)),
          ],
        ),
      ),
    );
  }
}