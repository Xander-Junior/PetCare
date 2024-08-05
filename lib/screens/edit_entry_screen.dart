import 'package:flutter/material.dart';

class EditEntryScreen extends StatelessWidget {
  final String date;
  final String title;
  final String content;

  EditEntryScreen({required this.date, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Entry'),
        backgroundColor: Color(0xFFD3E004),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: title),
            ),
            SizedBox(height: 16),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Write your entry here...',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: content),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    // Implement add image functionality
                  },
                  icon: Icon(Icons.add_photo_alternate, color: Color(0xFFD3E004)),
                  tooltip: 'Add Image',
                ),
                IconButton(
                  onPressed: () {
                    // Implement add voice note functionality
                  },
                  icon: Icon(Icons.mic, color: Color(0xFFD3E004)),
                  tooltip: 'Add Voice Note',
                ),
                IconButton(
                  onPressed: () {
                    // Implement file upload functionality
                  },
                  icon: Icon(Icons.file_upload, color: Color(0xFFD3E004)),
                  tooltip: 'Upload File',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
