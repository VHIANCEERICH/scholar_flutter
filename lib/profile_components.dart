import 'package:flutter/material.dart';

// 1. Reusable Dropdown
Widget buildProfileDropdown(
    String? val, String hint, List<String> items, Function(String?) onChg) {
  return Container(
    width: 280,
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: val,
        hint: Text(hint, style: const TextStyle(fontSize: 14)),
        isExpanded: true,
        items: items
            .map((e) => DropdownMenuItem(
                value: e, child: Text(e, style: const TextStyle(fontSize: 14))))
            .toList(),
        onChanged: onChg,
      ),
    ),
  );
}

// 2. Base Profile Layout Template
class BaseProfileLayout extends StatelessWidget {
  final String title, role;
  final String? semester;
  final List<Widget> filters;
  final VoidCallback onFilter;
  final Widget content;

  const BaseProfileLayout({
    super.key,
    required this.title,
    required this.role,
    this.semester,
    required this.filters,
    required this.onFilter,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D0D44))),
          const SizedBox(height: 25),
          Wrap(
            spacing: 15,
            runSpacing: 15,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ...filters,
              ElevatedButton(
                onPressed: onFilter,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFAB47BC),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 22),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Filter",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 30),
          _HeaderBanner(role: role, semester: semester),
          content,
        ],
      ),
    );
  }
}

class _HeaderBanner extends StatelessWidget {
  final String role;
  final String? semester;
  const _HeaderBanner({required this.role, this.semester});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        color: Color(0xFF6A1B9A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Scholar Profile Picture
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/jenn.jpg'),
            ),
          ),
          const SizedBox(width: 25),
          // Scholar Info Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Name: Marian Rivera",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Text("Sem: ${semester ?? 'N/A'}",
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 10),
                const Text("Course: First Year - BS Tourism Management",
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                const SizedBox(height: 15),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: const Color(0xFFFFD54F),
                      borderRadius: BorderRadius.circular(4)),
                  // UPDATED: Changed 'Role' label to 'Type'
                  child: Text("Type: $role",
                      style: const TextStyle(
                          color: Color(0xFF2D0D44),
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 3. Profile Data Table
class ProfileDataTable extends StatelessWidget {
  final List<String> headers;
  final List<String> data;
  const ProfileDataTable(
      {super.key, required this.headers, required this.data});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade50),
          children: headers.map((h) => _buildCell(h, true)).toList(),
        ),
        TableRow(
          children: data.map((d) => _buildCell(d, false)).toList(),
        ),
      ],
    );
  }

  Widget _buildCell(String text, bool isHeader) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 15,
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            color: isHeader ? const Color(0xFF2D0D44) : Colors.black87),
      ),
    );
  }
}

// 4. Empty State
Widget buildEmptyState(String msg) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(80),
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
    child: Column(
      children: [
        const Icon(Icons.info_outline, size: 60, color: Colors.grey),
        const SizedBox(height: 15),
        Text(msg,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey)),
      ],
    ),
  );
}
