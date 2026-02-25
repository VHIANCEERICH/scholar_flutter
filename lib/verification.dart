import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  // --- STATE VARIABLES ---
  String selectedScholarType = 'Student Assistant Scholar';
  Map<String, String>? selectedScholar;

  final List<String> scholarTypes = [
    'Student Assistant Scholar',
    'Academic Scholar A',
    'Academic Scholar B',
    'Academic Scholar C',
    'Varsity Scholar - Basketball',
    'Varsity Scholar - Volleyball',
    'Gift of Education Scholar',
  ];

  final Map<String, List<Map<String, String>>> scholarData = {
    'Student Assistant Scholar': [
      {
        'name': 'Marian Rivera',
        'type': 'Grade Report',
        'date': 'Oct 25, 2025',
        'status': 'Pending'
      },
      {
        'name': 'Coco Martin',
        'type': 'Renewal Form',
        'date': 'Oct 22, 2025',
        'status': 'Approved'
      },
    ],
    'Academic Scholar A': [
      {
        'name': 'Maine Mendoza',
        'type': 'Grade Report',
        'date': 'Jan 18, 2026',
        'status': 'Pending'
      },
    ],
    'Varsity Scholar - Basketball': [
      {
        'name': 'James Yap',
        'type': 'Attendance',
        'date': 'Nov 02, 2025',
        'status': 'Pending'
      },
    ],
    'Gift of Education Scholar': [
      {
        'name': 'Gia Smith',
        'type': 'Renewal Form',
        'date': 'Oct 15, 2025',
        'status': 'Rejected'
      },
    ],
  };

  void _updateStatus(String newStatus) {
    if (selectedScholar == null) return;
    setState(() {
      final list = scholarData[selectedScholarType]!;
      int index = list.indexWhere((s) => s['name'] == selectedScholar!['name']);
      if (index != -1) {
        list[index]['status'] = newStatus;
      }
      selectedScholar = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Status updated to $newStatus")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5B4E3), // Consistent Light Purple
      body: selectedScholar == null
          ? _buildListView()
          : _buildDocumentReviewView(),
    );
  }

  // --- VIEW A: THE FORMAL TABLE LIST ---
  Widget _buildListView() {
    final currentList = scholarData[selectedScholarType] ?? [];

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Formal Header
          const Text(
            "VERIFICATION",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: Color(0xFF2D0D44),
            ),
          ),
          const SizedBox(height: 24),

          // Dropdown Styled like Dashboard
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedScholarType,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                style: const TextStyle(color: Colors.black87, fontSize: 14),
                items: scholarTypes
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (val) => setState(() => selectedScholarType = val!),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // The Formal Card Box for the Table
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SingleChildScrollView(
                  child: DataTable(
                    headingRowColor:
                        MaterialStateProperty.all(const Color(0xFFF8F5FB)),
                    dataRowHeight: 65,
                    columns: const [
                      DataColumn(
                          label: Text('Scholar Name',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Type',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Date',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Status',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Action',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: currentList.map((data) {
                      return DataRow(cells: [
                        DataCell(Text(data['name']!)),
                        DataCell(Text(data['type']!)),
                        DataCell(Text(data['date']!)),
                        DataCell(_buildStatusBadge(data['status']!)),
                        DataCell(
                          ElevatedButton(
                            onPressed: () =>
                                setState(() => selectedScholar = data),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6A1B9A),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text("Verify",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- VIEW B: THE DOCUMENT REVIEW ---
  Widget _buildDocumentReviewView() {
    return Column(
      children: [
        // Top Navigation Bar
        Container(
          height: 80,
          color: const Color(0xFF4A148C),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => setState(() => selectedScholar = null),
              ),
              const SizedBox(width: 16),
              Text(
                "Review: ${selectedScholar!['name']}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: const Color(0xFFC5B4E3),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 15)
                      ],
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.file_copy_outlined,
                              size: 100, color: Color(0xFFC5B4E3)),
                          SizedBox(height: 16),
                          Text("Document Preview",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _actionBtn("APPROVE", Colors.green.shade700,
                        () => _updateStatus("Approved")),
                    const SizedBox(width: 24),
                    _actionBtn("REJECT", Colors.red.shade700,
                        () => _updateStatus("Rejected")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // UI Helpers
  Widget _buildStatusBadge(String status) {
    Color color = status == 'Pending'
        ? Colors.orange
        : (status == 'Approved' ? Colors.green : Colors.red);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style:
            TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  Widget _actionBtn(String label, Color color, VoidCallback onTap) {
    return SizedBox(
      width: 180,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
        ),
        child: Text(label,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2)),
      ),
    );
  }
}
