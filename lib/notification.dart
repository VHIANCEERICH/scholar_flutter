import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final TextEditingController _messageController = TextEditingController();

  // Track visibility choice: 'Admin' or 'All Scholars'
  String _selectedVisibility = 'Admin';

  List<Map<String, dynamic>> notifications = [
    {
      "text":
          "Your Report of Grades for AY 2025-2026 1st Sem has been approved.",
      "isRead": false
    },
    {
      "text": "Scholarship renewal for the next academic year is now open.",
      "isRead": false
    },
    {
      "text": "Reminder: Please upload your community service hours report.",
      "isRead": false
    },
    {
      "text": "New announcement regarding the upcoming scholar assembly.",
      "isRead": false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // UPDATED: Used your specific light purple background color
      backgroundColor: const Color(0xFFC5B4E3),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Notifications",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D0D44))),
            const SizedBox(height: 20),
            _buildFilterButtons(),
            const SizedBox(height: 30),
            Expanded(child: _buildNotificationList()),
          ],
        ),
      ),
    );
  }

  // --- REPLACED: Updated Reply Dialog with Visibility Options ---
  void _showReplyDialog(String originalMessage) {
    // Reset state for new dialog
    _selectedVisibility = 'Admin';
    _messageController.clear();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        // StatefulBuilder allows checkbox/radio updates inside dialog
        builder: (context, setDialogState) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text("Reply to Notification",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF2D0D44))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _messageController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Enter your reply...",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Who can see this reply?",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),

                // Visibility Selection
                Row(
                  children: [
                    Radio<String>(
                      value: 'Admin',
                      groupValue: _selectedVisibility,
                      activeColor: const Color(0xFFAB47BC),
                      onChanged: (val) =>
                          setDialogState(() => _selectedVisibility = val!),
                    ),
                    const Text("Admin Only"),
                    const SizedBox(width: 10),
                    Radio<String>(
                      value: 'All Scholars',
                      groupValue: _selectedVisibility,
                      activeColor: const Color(0xFFAB47BC),
                      onChanged: (val) =>
                          setDialogState(() => _selectedVisibility = val!),
                    ),
                    const Text("All Scholars"),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child:
                    const Text("Cancel", style: TextStyle(color: Colors.grey)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFAB47BC),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  // Logic to send message with visibility goes here
                  print(
                      "Message: ${_messageController.text}, Visibility: $_selectedVisibility");
                  Navigator.pop(context);
                },
                child: const Text("Send Reply",
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      ),
    );
  }

  // Helper widgets for filters and list (kept same but updated colors for consistency)
  Widget _buildFilterButtons() {
    return Wrap(
      spacing: 10,
      children: ["All", "Unread", "Mark all as read"].map((label) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFAB47BC),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          onPressed: () {
            if (label == "Mark all as read") {
              setState(() => notifications.forEach((n) => n['isRead'] = true));
            }
          },
          child: Text(label, style: const TextStyle(color: Colors.white)),
        );
      }).toList(),
    );
  }

  Widget _buildNotificationList() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9), // Glass effect
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
          ]),
      child: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (context, index) =>
            Divider(color: Colors.grey.shade200, height: 1),
        itemBuilder: (context, index) {
          final note = notifications[index];
          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            title: Text(note['text'],
                style: TextStyle(
                    color: note['isRead'] ? Colors.grey : Colors.black87,
                    fontSize: 16)),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFAB47BC)),
              onPressed: () => _showReplyDialog(note['text']),
              child: const Text("Reply", style: TextStyle(color: Colors.white)),
            ),
          );
        },
      ),
    );
  }
}
