import 'package:flutter/material.dart';
import 'dart:io';

class ManageScholarScreen extends StatefulWidget {
  const ManageScholarScreen({super.key});

  @override
  State<ManageScholarScreen> createState() => _ManageScholarScreenState();
}

class _ManageScholarScreenState extends State<ManageScholarScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();

  String _selectedType = "Student Assistant";
  String _searchQuery = "";
  String? _tempImagePath;

  List<Map<String, String>> scholars = [
    {
      "id": "1",
      "name": "Marian Rivera",
      "course": "1st Year - BS Tourism",
      "type": "Student Assistant",
      "detail": "Library",
      "image": ""
    },
    {
      "id": "4",
      "name": "Jenn Makiling",
      "course": "3rd yr. BSIT",
      "type": "Gift of Education",
      "detail": "Foundation Sponsored",
      "image": "assets/jenn.jpg"
    },
  ];

  List<Map<String, String>> get _filteredScholars => scholars
      .where(
          (s) => s['name']!.toLowerCase().contains(_searchQuery.toLowerCase()))
      .toList();

  void _showScholarDialog({String? id}) {
    if (id != null) {
      final s = scholars.firstWhere((item) => item['id'] == id);
      _nameController.text = s['name']!;
      _courseController.text = s['course']!;
      _selectedType = s['type']!;
      _detailController.text = s['detail']!;
      _tempImagePath = s['image'];
    } else {
      _nameController.clear();
      _courseController.clear();
      _detailController.clear();
      _tempImagePath = null;
      _selectedType = "Student Assistant";
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          if (_selectedType == "Gift of Education") {
            _detailController.text = "Foundation Sponsored";
          }

          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text(id == null ? "Add New Scholar" : "Edit Scholar Details",
                style: const TextStyle(
                    color: Color(0xFF2D0D44), fontWeight: FontWeight.bold)),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: _tempImagePath != null &&
                                _tempImagePath!.isNotEmpty
                            ? (_tempImagePath!.startsWith('assets')
                                ? AssetImage(_tempImagePath!) as ImageProvider
                                : FileImage(File(_tempImagePath!)))
                            : null,
                        child: _tempImagePath == null || _tempImagePath!.isEmpty
                            ? const Icon(Icons.person,
                                size: 45, color: Colors.grey)
                            : null,
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: const Color(0xFFAB47BC),
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt,
                              size: 15, color: Colors.white),
                          onPressed: () {
                            setDialogState(() {
                              _tempImagePath = "assets/jenn.jpg";
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                          labelText: "Full Name",
                          prefixIcon: Icon(Icons.person))),
                  const SizedBox(height: 10),
                  TextField(
                      controller: _courseController,
                      decoration: const InputDecoration(
                          labelText: "Course & Year",
                          prefixIcon: Icon(Icons.school))),
                  const SizedBox(height: 15),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedType,
                    decoration: const InputDecoration(
                        labelText: "Scholarship Category",
                        border: OutlineInputBorder()),
                    items: [
                      "Student Assistant",
                      "Academic Scholar",
                      "Varsity Scholar",
                      "Gift of Education"
                    ]
                        .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                        .toList(),
                    onChanged: (val) =>
                        setDialogState(() => _selectedType = val!),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                      controller: _detailController,
                      readOnly: _selectedType == "Gift of Education",
                      decoration: InputDecoration(
                          labelText: _selectedType == "Student Assistant"
                              ? "Assign Area"
                              : "Grant Detail",
                          prefixIcon: const Icon(Icons.assignment_ind))),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel")),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFAB47BC)),
                onPressed: () {
                  setState(() {
                    final data = {
                      "id": id ?? DateTime.now().toString(),
                      "name": _nameController.text,
                      "course": _courseController.text,
                      "type": _selectedType,
                      "detail": _detailController.text,
                      "image": _tempImagePath ?? "",
                    };
                    if (id == null) {
                      scholars.add(data);
                    } else {
                      int index =
                          scholars.indexWhere((item) => item['id'] == id);
                      scholars[index] = data;
                    }
                  });
                  Navigator.pop(context);
                },
                child: const Text("Save Changes",
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5B4E3),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Manage Scholar",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D0D44))),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B125A),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15)),
                  onPressed: () => _showScholarDialog(),
                  icon: const Icon(Icons.person_add, color: Colors.white),
                  label: const Text("Add Scholar",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: 400,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val),
                decoration: const InputDecoration(
                    hintText: "Search scholar by name...",
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none),
              ),
            ),
            const SizedBox(height: 25),
            // Updated Table Section to occupy full width
            Expanded(
              child: Container(
                width: double.infinity, // Occupies full width
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(15)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      child: DataTable(
                        horizontalMargin: 24,
                        columnSpacing: 20,
                        headingRowColor:
                            WidgetStateProperty.all(const Color(0xFFF3E5F5)),
                        columns: const [
                          DataColumn(
                              label: Text('PHOTO',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('FULL NAME',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('TYPE & DETAIL',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('ACTIONS',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ],
                        rows: _filteredScholars.map((s) {
                          return DataRow(cells: [
                            DataCell(CircleAvatar(
                              radius: 18,
                              backgroundImage: s['image']!.isNotEmpty
                                  ? (s['image']!.startsWith('assets')
                                      ? AssetImage(s['image']!) as ImageProvider
                                      : FileImage(File(s['image']!)))
                                  : null,
                              child: s['image']!.isEmpty
                                  ? const Icon(Icons.person, size: 20)
                                  : null,
                            )),
                            // Used SizedBox to give the name column priority width
                            DataCell(SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text(s['name']!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500)),
                            )),
                            DataCell(SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(s['type']!,
                                      style: const TextStyle(
                                          color: Color(0xFFAB47BC),
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                  Text("(${s['detail']!})",
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 11)),
                                ],
                              ),
                            )),
                            DataCell(Row(
                              children: [
                                IconButton(
                                    icon: const Icon(Icons.edit_note,
                                        color: Colors.blue),
                                    onPressed: () =>
                                        _showScholarDialog(id: s['id'])),
                                IconButton(
                                    icon: const Icon(Icons.delete_sweep,
                                        color: Colors.redAccent),
                                    onPressed: () => setState(() =>
                                        scholars.removeWhere(
                                            (item) => item['id'] == s['id']))),
                              ],
                            )),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
