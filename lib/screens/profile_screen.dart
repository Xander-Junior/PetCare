import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _dobController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
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
                    backgroundImage: AssetImage('assets/bg6.jpg'), // Replace with your image path
                  ),
                  SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      // Implement change profile picture functionality
                    },
                    child: Text('Change pet profile picture'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            _buildTextField('Pet\'s name'),
            SizedBox(height: 16),
            _buildTextField('Breed'),
            SizedBox(height: 16),
            _buildDateField('Date of birth'),
            SizedBox(height: 16),
            _buildTextField('Email'),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Implement update functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD3E004), // Button color
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('Update', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        TextField(
          style: TextStyle(color: Colors.black), // Set text color to black
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        TextField(
          controller: _dobController,
          style: TextStyle(color: Colors.black), // Set text color to black
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            suffixIcon: Icon(Icons.calendar_today, color: Colors.grey),
          ),
          onTap: () async {
            FocusScope.of(context).requestFocus(new FocusNode());
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
