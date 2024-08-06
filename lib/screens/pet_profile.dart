import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class PetProfileScreen extends StatefulWidget {
  const PetProfileScreen({super.key});

  @override
  _PetProfileScreenState createState() => _PetProfileScreenState();
}

class _PetProfileScreenState extends State<PetProfileScreen> {
  String petName = 'Buddy';
  String breed = 'Golden Retriever';
  String age = '5 Years';
  String weight = '25 kg';
  String? profileImageUrl;

  List<Map<String, String>> medicalHistory = [
    {'category': 'Vaccination', 'details': 'Rabies, Distemper, Parvovirus', 'date': '2023-01-15'},
    {'category': 'Allergies', 'details': 'None', 'date': '2023-01-10'},
  ];

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      petName = prefs.getString('petName') ?? 'Buddy';
      breed = prefs.getString('breed') ?? 'Golden Retriever';
      String? dobString = prefs.getString('dob');
      if (dobString != null) {
        DateTime dob = DateFormat('dd-MM-yyyy').parse(dobString);
        int years = DateTime.now().year - dob.year;
        age = '$years Years';
      }
      weight = prefs.getString('weight') ?? '25 kg'; // Ensure to save weight in the ProfileScreen
      profileImageUrl = prefs.getString('petProfileImage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Profile'),
        backgroundColor: const Color(0xFFD3E004),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: profileImageUrl != null
                      ? FileImage(File(profileImageUrl!))
                      : const AssetImage('assets/bg6.jpg') as ImageProvider,
                  radius: 80,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Column(
                  children: [
                    Text(
                      petName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      breed,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Age', age),
                      _buildDetailRow('Weight', weight),
                      _buildDetailRow('Breed', breed),
                    ],
                  ),
                ),
              ),
              const Text(
                'Medical History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...medicalHistory.map((history) => _buildMedicalHistoryCard(history)),
              const SizedBox(height: 8),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _addMedicalHistory(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD3E004),
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  ),
                  child: const Text('Add Medical History', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalHistoryCard(Map<String, String> history) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  history['category']!,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  history['details']!,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Date: ${history['date']}',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.grey),
              onPressed: () {
                _editMedicalHistory(context, history);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _editMedicalHistory(BuildContext context, Map<String, String> history) {
    TextEditingController categoryController = TextEditingController(text: history['category']);
    TextEditingController detailsController = TextEditingController(text: history['details']);
    TextEditingController dateController = TextEditingController(text: history['date']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Medical History'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              TextField(
                controller: detailsController,
                decoration: const InputDecoration(labelText: 'Details'),
              ),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(labelText: 'Date'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  history['category'] = categoryController.text;
                  history['details'] = detailsController.text;
                  history['date'] = dateController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _addMedicalHistory(BuildContext context) {
    TextEditingController categoryController = TextEditingController();
    TextEditingController detailsController = TextEditingController();
    TextEditingController dateController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Medical History'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              TextField(
                controller: detailsController,
                decoration: const InputDecoration(labelText: 'Details'),
              ),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(labelText: 'Date'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  medicalHistory.add({
                    'category': categoryController.text,
                    'details': detailsController.text,
                    'date': dateController.text,
                  });
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
