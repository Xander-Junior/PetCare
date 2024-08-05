import 'package:flutter/material.dart';

class PetProfileScreen extends StatefulWidget {
  @override
  _PetProfileScreenState createState() => _PetProfileScreenState();
}

class _PetProfileScreenState extends State<PetProfileScreen> {
  List<Map<String, String>> medicalHistory = [
    {'category': 'Vaccination', 'details': 'Rabies, Distemper, Parvovirus', 'date': '2023-01-15'},
    {'category': 'Allergies', 'details': 'None', 'date': '2023-01-10'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Profile'),
        backgroundColor: Color(0xFFD3E004),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/bg6.jpg'),
                  radius: 80,
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Buddy',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Golden Retriever',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Card(
                margin: EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Age', '5 Years'),
                      _buildDetailRow('Weight', '25 kg'),
                      _buildDetailRow('Breed', 'Golden Retriever'),
                    ],
                  ),
                ),
              ),
              Text(
                'Medical History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ...medicalHistory.map((history) => _buildMedicalHistoryCard(history)).toList(),
              SizedBox(height: 8),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _addMedicalHistory(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD3E004),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  ),
                  child: Text('Add Medical History', style: TextStyle(color: Colors.white)),
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
            style: TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalHistoryCard(Map<String, String> history) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  history['details']!,
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Date: ${history['date']}',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.edit, color: Colors.grey),
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
          title: Text('Edit Medical History'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              TextField(
                controller: detailsController,
                decoration: InputDecoration(labelText: 'Details'),
              ),
              TextField(
                controller: dateController,
                decoration: InputDecoration(labelText: 'Date'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
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
              child: Text('Save'),
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
          title: Text('Add Medical History'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              TextField(
                controller: detailsController,
                decoration: InputDecoration(labelText: 'Details'),
              ),
              TextField(
                controller: dateController,
                decoration: InputDecoration(labelText: 'Date'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
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
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
