import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:petcare/screens/diary_entry.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';

class EditEntryScreen extends StatefulWidget {
  final DiaryEntry entry;

  const EditEntryScreen({super.key, required this.entry});

  @override
  _EditEntryScreenState createState() => _EditEntryScreenState();
}

class _EditEntryScreenState extends State<EditEntryScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  String? _imagePath;
  String? _voiceNotePath;
  FlutterSoundRecorder? _recorder;
  AudioPlayer _audioPlayer = AudioPlayer();
  bool _isRecording = false;
  String _date = DateFormat('dd/MM/yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.entry.title);
    _contentController = TextEditingController(text: widget.entry.content);
    _imagePath = widget.entry.imagePath;
    _voiceNotePath = widget.entry.voiceNotePath;
    _recorder = FlutterSoundRecorder();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException("Microphone permission not granted");
    }
    await _recorder!.openRecorder();
  }

  Future<void> _startRecording() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = '${tempDir.path}/temp_voice_note.aac';
    await _recorder!.startRecorder(toFile: tempPath);
    setState(() {
      _isRecording = true;
      _voiceNotePath = tempPath;
    });
  }

  Future<void> _stopRecording() async {
    await _recorder!.stopRecorder();
    setState(() {
      _isRecording = false;
    });
  }

  Future<void> _playRecording() async {
    if (_voiceNotePath != null) {
      await _audioPlayer.play(DeviceFileSource(_voiceNotePath!));
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  @override
  void dispose() {
    _recorder!.closeRecorder();
    _recorder = null;
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Diary Entry'),
        backgroundColor: const Color(0xFFD3E004),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _contentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              IconButton(
                icon: Icon(Icons.image),
                onPressed: _pickImage,
              ),
              const SizedBox(height: 16),
              if (_imagePath != null) Image.file(File(_imagePath!)),
              const SizedBox(height: 16),
              Row(
                children: [
                  IconButton(
                    icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                    onPressed: _isRecording ? _stopRecording : _startRecording,
                  ),
                  if (_voiceNotePath != null)
                    IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: _playRecording,
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final editedEntry = DiaryEntry(
                      date: _date,
                      title: _titleController.text,
                      content: _contentController.text,
                      imagePath: _imagePath,
                      voiceNotePath: _voiceNotePath,
                    );
                    Navigator.of(context).pop(editedEntry);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD3E004)),
                  child: const Text('Save', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
