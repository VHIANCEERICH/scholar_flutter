import 'package:flutter/material.dart';

class UploadFilesScreen extends StatefulWidget {
  const UploadFilesScreen({super.key});

  @override
  State<UploadFilesScreen> createState() => _UploadFilesScreenState();
}

class _UploadFilesScreenState extends State<UploadFilesScreen> {
  String selectedDocType = 'Report of Grades';
  String selectedAcademicTerm = 'AY 2025-2026 1st Semester';

  final List<String> docTypes = ['Report of Grades', 'Renewal Letter'];
  final List<String> academicTerms = [
    'AY 2025-2026 2nd Semester',
    'AY 2025-2026 1st Semester',
    'Summer - 2025',
    'AY 2024-2025 2nd Semester',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5B4E3), // Matched Lavender
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Document Submission & Processing',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D0D44))),
            const SizedBox(height: 30),
            Wrap(
              spacing: 40,
              runSpacing: 40,
              children: [
                // LEFT SIDE
                SizedBox(
                  width: 600,
                  child: Column(
                    children: [
                      _buildScannerFrame(),
                      const SizedBox(height: 30),
                      _buildDropdownRow(
                        label: 'Document Type',
                        value: selectedDocType,
                        items: docTypes,
                        onChanged: (val) =>
                            setState(() => selectedDocType = val!),
                      ),
                      const SizedBox(height: 15),
                      _buildDropdownRow(
                        label: 'Academic Term',
                        value: selectedAcademicTerm,
                        items: academicTerms,
                        onChanged: (val) =>
                            setState(() => selectedAcademicTerm = val!),
                      ),
                      const SizedBox(height: 15),
                      _buildRemarksField(),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _actionBtn('Start Processing',
                              const Color(0xFFAB47BC), Colors.white),
                          const SizedBox(width: 20),
                          _actionBtn('Cancel', Colors.white, Colors.black,
                              hasBorder: true),
                        ],
                      ),
                    ],
                  ),
                ),
                // RIGHT SIDE
                SizedBox(
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Uploaded Documents',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      _statusCard('Report of Grades', 'Approved', Colors.green,
                          () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OCRDataView()));
                      }),
                      const SizedBox(height: 20),
                      _statusCard(
                          'Renewal Letter', 'Pending', Colors.red, null),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- HELPERS (Keep existing logic, ensure colors match) ---
  Widget _buildDropdownRow(
      {required String label,
      required String value,
      required List<String> items,
      required ValueChanged<String?> onChanged}) {
    return Row(
      children: [
        SizedBox(
            width: 140,
            child: Text(label,
                style: const TextStyle(fontWeight: FontWeight.bold))),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                items: items
                    .map((item) =>
                        DropdownMenuItem(value: item, child: Text(item)))
                    .toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScannerFrame() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFAB47BC), width: 2)),
      child: const Center(
          child: Icon(Icons.document_scanner_outlined,
              size: 80, color: Color(0xFFAB47BC))),
    );
  }

  Widget _buildRemarksField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
            width: 140,
            child: Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text('Remarks',
                    style: TextStyle(fontWeight: FontWeight.bold)))),
        Expanded(
          child: TextField(
            maxLines: 3,
            decoration: InputDecoration(
                hintText: "Enter remarks...",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none)),
          ),
        ),
      ],
    );
  }

  Widget _statusCard(
      String title, String status, Color color, VoidCallback? onTap) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
                backgroundColor:
                    onTap != null ? const Color(0xFFAB47BC) : Colors.grey),
            child: const Text('View OCR Data',
                style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 10),
          Text(status,
              style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _actionBtn(String label, Color bg, Color text,
      {bool hasBorder = false}) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          side: hasBorder ? const BorderSide(color: Colors.black12) : null),
      child: Text(label,
          style: TextStyle(color: text, fontWeight: FontWeight.bold)),
    );
  }
}

// (OCRDataView remains similar but ensure background is Color(0xFFC7BDD5))
class OCRDataView extends StatelessWidget {
  const OCRDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC7BDD5),
      appBar: AppBar(
          title: const Text("Scholar Management"),
          backgroundColor: const Color(0xFF6A1B9A),
          foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: const Center(child: Text("Document Preview")),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: const Color(0xFF1A1225),
                    borderRadius: BorderRadius.circular(15)),
                child: const Column(
                  children: [
                    Text("EXTRACTED DATA",
                        style: TextStyle(
                            color: Colors.purpleAccent,
                            fontWeight: FontWeight.bold)),
                    Divider(color: Colors.white24),
                    // Add your _ocrField items here...
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
