import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  File? _imageFile;
  String? _profileImageUrl;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _petNameController.text = prefs.getString('petName') ?? '';
      _breedController.text = prefs.getString('breed') ?? '';
      String? dobString = prefs.getString('dob');
      if (dobString != null) {
        selectedDate = DateFormat('dd-MM-yyyy').parse(dobString);
        _dobController.text = dobString;
      }
      _profileImageUrl = prefs.getString('petProfileImage');
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _profileImageUrl = _imageFile!.path;
      });
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      _loading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('petName', _petNameController.text);
    await prefs.setString('breed', _breedController.text);
    await prefs.setString('dob', _dobController.text);
    if (_profileImageUrl != null) {
      await prefs.setString('petProfileImage', _profileImageUrl!);
    }

    setState(() {
      _loading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully!')),
    );
    Navigator.pop(context);  // Go back to the home screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : _profileImageUrl != null
                            ? FileImage(File(_profileImageUrl!))
                            : const AssetImage('assets/bg6.jpg') as ImageProvider,
                    child: _profileImageUrl == null ? const Icon(Icons.camera_alt, color: Colors.grey) : null,
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _pickImage,
                    child: const Text('Change pet profile picture'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildTextField('Pet\'s name', _petNameController),
            const SizedBox(height: 16),
            _buildTextField('Breed', _breedController),
            const SizedBox(height: 16),
            _buildDateField('Date of birth'),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _updateProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD3E004), // Button color
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Update', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(color: Colors.black), // Set text color to black
          decoration: InputDecoration(
            hintText: label, // Add hint text
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: _dobController,
          style: const TextStyle(color: Colors.black), // Set text color to black
          decoration: InputDecoration(
            hintText: label, // Add hint text
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            suffixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
          ),
          onTap: () async {
            FocusScope.of(context).requestFocus(FocusNode());
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (picked != null && picked != selectedDate) {
              setState(() {
                selectedDate = picked;
                _dobController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
              });
            }
          },
        ),
      ],
    );
  }
}
