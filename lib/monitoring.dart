import 'package:flutter/material.dart';

class MonitoringScreen extends StatefulWidget {
  const MonitoringScreen({super.key});

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  String currentView = 'main';
  String selectedAreaTitle = '';
  String parentView = 'main';

  // Sample data map to track duty hours specifically for Student Assistants
  final Map<String, String> _dutyHoursTracker = {
    'Coco Martin': '85/100',
    'Marian Rivera': '12/100',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5B4E3),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopHeader(),
          Expanded(child: _buildActiveContent()),
        ],
      ),
    );
  }

  // --- EDIT DIALOG FOR DUTY HOURS ---
  void _showDutyHoursDialog(String name) {
    final TextEditingController _hoursController =
        TextEditingController(text: _dutyHoursTracker[name]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Duty Hours: $name"),
        content: TextField(
          controller: _hoursController,
          decoration: const InputDecoration(
            labelText: "Hours Rendered (e.g., 50/100)",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A1B9A)),
            onPressed: () {
              setState(() {
                _dutyHoursTracker[name] = _hoursController.text;
              });
              Navigator.pop(context);
            },
            child: const Text("Update", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveContent() {
    switch (currentView) {
      case 'student_assistant':
        return _buildSubCategoryGrid(
            'Assigned Area (SA)',
            [
              {'title': 'Library', 'color': const Color(0xFF43A047)},
              {'title': 'Registrar', 'color': const Color(0xFFE6BE5A)},
              {'title': 'POD', 'color': const Color(0xFFB39DDB)},
              {'title': 'Canteen', 'color': const Color(0xFFD87474)},
              {'title': 'CITE', 'color': const Color(0xFFB71C1C)},
              {'title': 'BSBA Office', 'color': const Color(0xFFCE93D8)},
            ],
            'student_assistant');
      case 'academic_scholar':
        return _buildSubCategoryGrid(
            'Academic (Type)',
            [
              {'title': 'Academic A', 'color': const Color(0xFF43A047)},
              {'title': 'Academic B', 'color': const Color(0xFFE6BE5A)},
              {'title': 'Academic C', 'color': const Color(0xFFB39DDB)},
            ],
            'academic_scholar');
      case 'varsity':
        return _buildSubCategoryGrid(
            'Varsity (Type)',
            [
              {'title': 'Basketball', 'color': const Color(0xFFE67E22)},
              {'title': 'Volleyball', 'color': const Color(0xFF3498DB)},
            ],
            'varsity');
      case 'gift_of_education':
        return _buildSubCategoryGrid(
            'Gift of Education (Type)',
            [
              {'title': 'Gift A', 'color': const Color(0xFFE91E63)},
              {'title': 'Gift B', 'color': const Color(0xFFF06292)},
            ],
            'gift_of_education');
      case 'area_detail':
        return _buildExpandedScholarTable();
      default:
        return _buildMainCategorySelection();
    }
  }

  // --- 1. MAIN CATEGORY SELECTION ---
  Widget _buildMainCategorySelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
        childAspectRatio: 1.6,
        children: [
          _buildBox('Student Assistant', const Color(0xFF43A047),
              () => setState(() => currentView = 'student_assistant')),
          _buildBox('Academic Scholar', const Color(0xFFE6BE5A),
              () => setState(() => currentView = 'academic_scholar')),
          _buildBox('Varsity', const Color(0xFFB39DDB),
              () => setState(() => currentView = 'varsity')),
          _buildBox('Gift of Education', const Color(0xFFD87474),
              () => setState(() => currentView = 'gift_of_education')),
        ],
      ),
    );
  }

  // --- 2. REUSABLE SUB-CATEGORY GRID ---
  Widget _buildSubCategoryGrid(
      String title, List<Map<String, dynamic>> items, String from) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBackButton('main'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Text(title,
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D0D44))),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 25,
                mainAxisSpacing: 25,
                childAspectRatio: 1.6,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) => _buildBox(
                  items[index]['title'],
                  items[index]['color'],
                  () => _openArea(items[index]['title'], from)),
            ),
          ),
        ),
      ],
    );
  }

  // --- 3. FORMAL TABLE VIEW ---
  Widget _buildExpandedScholarTable() {
    // Determine if we should show the Duty Hours column
    bool isSA = parentView == 'student_assistant';

    List<DataRow> scholarRows = [
      _scholarRow('Coco Martin', 'BSCRIM - 4', 'Oct 25, 2025', 'Submitted',
          'Submitted', 'Complete', isSA),
      _scholarRow('Marian Rivera', 'BSTM - 1', 'Oct 25, 2025', 'Missing',
          'Missing', 'Notify Scholar', isSA),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerRight,
            child: Text('Semester: AY 2025-2026 1st Semester',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF3B125A))),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 5))
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SingleChildScrollView(
                  child: DataTable(
                    headingRowColor:
                        WidgetStateProperty.all(const Color(0xFFF8F5FB)),
                    columnSpacing: 30,
                    headingRowHeight: 70,
                    dataRowHeight: 65,
                    columns: [
                      const DataColumn(
                          label: Text('Scholar Name',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      const DataColumn(
                          label: Text('Course/Year',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      const DataColumn(
                          label: Text('Due Date',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      // Only show Duty Hours for Student Assistants
                      if (isSA)
                        const DataColumn(
                            label: Text('Duty Hours',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                      const DataColumn(
                          label: Text('Grades',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      const DataColumn(
                          label: Text('Renewal',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      const DataColumn(
                          label: Text('Remarks',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: scholarRows,
                  ),
                ),
              ),
            ),
          ),
          _buildBottomBackButton(parentView),
        ],
      ),
    );
  }

  // --- STYLING HELPERS ---

  void _openArea(String title, String fromView) {
    setState(() {
      selectedAreaTitle = title;
      parentView = fromView;
      currentView = 'area_detail';
    });
  }

  Widget _buildBox(String title, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4))
          ],
        ),
        child: Center(
            child: Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold))),
      ),
    );
  }

  Widget _buildTopHeader() {
    String title = "MONITORING";
    if (currentView == 'area_detail') title = selectedAreaTitle.toUpperCase();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D0D44),
                  letterSpacing: 1.2)),
          if (currentView != 'area_detail') _searchBar(),
        ],
      ),
    );
  }

  Widget _buildBackButton(String target) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: TextButton.icon(
        onPressed: () => setState(() => currentView = target),
        icon: const Icon(Icons.arrow_back, color: Color(0xFF4A148C)),
        label: const Text('Back',
            style: TextStyle(
                color: Color(0xFF4A148C), fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildBottomBackButton(String target) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Align(
        alignment: Alignment.bottomRight,
        child: ElevatedButton(
          onPressed: () => setState(() => currentView = target),
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6A1B9A),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          child: const Text('Return to Categories',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Search scholar...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }

  DataRow _scholarRow(String name, String cy, String date, String grade,
      String renewal, String remarks, bool isSA) {
    bool isUrgent = remarks == 'Notify Scholar';
    return DataRow(cells: [
      DataCell(Text(name, style: const TextStyle(fontWeight: FontWeight.w500))),
      DataCell(Text(cy)),
      DataCell(Text(date)),
      // Duty Hours Cell with Edit Icon
      if (isSA)
        DataCell(
          Row(
            children: [
              Text(_dutyHoursTracker[name] ?? "0/100",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xFF4A148C))),
              IconButton(
                icon: const Icon(Icons.edit, size: 16, color: Colors.grey),
                onPressed: () => _showDutyHoursDialog(name),
              )
            ],
          ),
        ),
      DataCell(Text(grade)),
      DataCell(Text(renewal)),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isUrgent
                ? Colors.red.withOpacity(0.1)
                : Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(remarks,
              style: TextStyle(
                  color: isUrgent ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
        ),
      ),
    ]);
  }
}
