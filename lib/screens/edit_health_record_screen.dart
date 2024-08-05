import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditHealthRecordScreen extends StatefulWidget {
  final Map<String, dynamic>? record;

  EditHealthRecordScreen({this.record});

  @override
  _EditHealthRecordScreenState createState() => _EditHealthRecordScreenState();
}

class _EditHealthRecordScreenState extends State<EditHealthRecordScreen> {
  late TextEditingController dateController;
  late TextEditingController typeController;
  late TextEditingController vetController;
  XFile? selectedImage;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController(text: widget.record?['date'] ?? '');
    typeController = TextEditingController(text: widget.record?['type'] ?? '');
    vetController = TextEditingController(text: widget.record?['vet'] ?? '');
    selectedImage = widget.record?['image'];
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = pickedFile;
    });
  }

  void _saveRecord() {
    Navigator.of(context).pop({
      'date': dateController.text,
      'type': typeController.text,
      'vet': vetController.text,
      'image': selectedImage,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.record == null ? 'Add Health Record' : 'Edit Health Record'),
        backgroundColor: Color(0xFFD3E004),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: dateController,
                decoration: InputDecoration(labelText: 'Date'),
              ),
              TextField(
                controller: typeController,
                decoration: InputDecoration(labelText: 'Type'),
              ),
              TextField(
                controller: vetController,
                decoration: InputDecoration(labelText: 'Vet'),
              ),
              SizedBox(height: 10),
              selectedImage != null
                  ? Image.file(File(selectedImage!.path), height: 100)
                  : Text('No image selected'),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Add Image'),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _saveRecord,
                    child: Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}