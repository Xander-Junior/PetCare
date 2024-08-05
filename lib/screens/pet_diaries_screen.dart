import 'package:flutter/material.dart';
import 'package:petcare/screens/new_entry_screen.dart';
import 'package:petcare/screens/edit_entry_screen.dart';

class PetDiariesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Diaries'),
        backgroundColor: Color(0xFFD3E004),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildDiaryCard(context, '12/10/2023', 'A Day at the Park', 'Today, Max had an exciting day at the park...'),
                  _buildDiaryCard(context, '11/10/2023', 'Vet Visit', 'Max had a check-up today. Everything is fine...'),
                  _buildDiaryCard(context, '10/10/2023', 'New Toy', 'Max got a new toy today. He loves it...'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewEntryScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFD3E004),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: Text('Add New Entry', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiaryCard(BuildContext context, String date, String title, String content) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(content),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditEntryScreen(date: date, title: title, content: content)),
                    );
                  },
                  child: Text('Edit', style: TextStyle(color: Colors.green)),
                ),
                TextButton(
                  onPressed: () {
                    // Implement delete functionality
                  },
                  child: Text('Delete', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
