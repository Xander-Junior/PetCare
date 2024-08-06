import 'package:flutter/material.dart';
import 'package:petcare/screens/new_entry_screen.dart';
import 'package:petcare/screens/edit_entry_screen.dart';
import 'package:petcare/screens/diary_entry.dart';
import 'package:share_files_and_screenshot_widgets_plus/share_files_and_screenshot_widgets_plus.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

class PetDiariesScreen extends StatefulWidget {
  @override
  _PetDiariesScreenState createState() => _PetDiariesScreenState();
}

class _PetDiariesScreenState extends State<PetDiariesScreen> {
  List<DiaryEntry> _entries = [
    DiaryEntry(
      date: '12/10/2023',
      title: 'A Day at the Park',
      content: 'Today, Max had an exciting day at the park...',
    ),
    DiaryEntry(
      date: '11/10/2023',
      title: 'Vet Visit',
      content: 'Max had a check-up today. Everything is fine...',
    ),
    DiaryEntry(
      date: '10/10/2023',
      title: 'New Toy',
      content: 'Max got a new toy today. He loves it...',
    ),
  ];

  GlobalKey previewContainer = GlobalKey();

  void _addNewEntry(DiaryEntry entry) {
    setState(() {
      _entries.add(entry);
    });
  }

  void _editEntry(DiaryEntry oldEntry, DiaryEntry newEntry) {
    setState(() {
      int index = _entries.indexOf(oldEntry);
      if (index != -1) {
        _entries[index] = newEntry;
      }
    });
  }

Future<void> _shareEntry(DiaryEntry entry) async {
  // Convert entry content to bytes for sharing
  String entryContent = '${entry.title}\n\n${entry.date}\n\n${entry.content}';
  Uint8List bytes = Uint8List.fromList(utf8.encode(entryContent));

  // Share the entry as a text file
  await ShareFilesAndScreenshotWidgets().shareFile(
    'Diary Entry',
    'entry.txt',
    bytes,
    'text/plain',
    text: 'Sharing Diary Entry',
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Diaries'),
        backgroundColor: const Color(0xFFD3E004),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _entries.length,
                itemBuilder: (context, index) {
                  return _buildDiaryCard(context, _entries[index]);
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final newEntry = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewEntryScreen()),
                );
                if (newEntry != null) {
                  _addNewEntry(newEntry);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD3E004),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: const Text('Add New Entry', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiaryCard(BuildContext context, DiaryEntry entry) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(entry.date, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(entry.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(entry.content),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    final editedEntry = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditEntryScreen(entry: entry)),
                    );
                    if (editedEntry != null) {
                      _editEntry(entry, editedEntry);
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      _entries.remove(entry);
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () => _shareEntry(entry),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
