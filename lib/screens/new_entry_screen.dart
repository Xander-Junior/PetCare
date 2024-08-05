import 'package:flutter/material.dart';

class NewEntryScreen extends StatelessWidget {
  const NewEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Entry'),
        backgroundColor: const Color(0xFFD3E004),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Write your entry here...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    // Implement add image functionality
                  },
                  icon: const Icon(Icons.add_photo_alternate, color: Color(0xFFD3E004)),
                  tooltip: 'Add Image',
                ),
                IconButton(
                  onPressed: () {
                    // Implement add voice note functionality
                  },
                  icon: const Icon(Icons.mic, color: Color(0xFFD3E004)),
                  tooltip: 'Add Voice Note',
                ),
                IconButton(
                  onPressed: () {
                    // Implement file upload functionality
                  },
                  icon: const Icon(Icons.file_upload, color: Color(0xFFD3E004)),
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
