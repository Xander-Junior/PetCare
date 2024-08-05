import 'package:flutter/material.dart';

class RemindersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminders'),
        backgroundColor: Color(0xFFD3E004),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Implement settings functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Upcoming Reminders
              Text('Upcoming Reminders', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Card(
                margin: EdgeInsets.only(bottom: 16),
                child: ListTile(
                  leading: Icon(Icons.calendar_today, color: Color(0xFFD3E004)),
                  title: Text('Vet Appointment'),
                  subtitle: Text('10/12/2023 at 2:00 PM'),
                ),
              ),
              Card(
                margin: EdgeInsets.only(bottom: 16),
                child: ListTile(
                  leading: Icon(Icons.medical_services, color: Color(0xFFD3E004)),
                  title: Text('Medication'),
                  subtitle: Text('10/14/2023 at 8:00 AM'),
                ),
              ),
              SizedBox(height: 16),
              // Add Reminder
              Text('Add Reminder', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Card(
                margin: EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Date',
                          hintText: 'dd/mm/yy',
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Time',
                          hintText: '--:--',
                          prefixIcon: Icon(Icons.access_time),
                        ),
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Type',
                        ),
                        items: ['Appointment', 'Medication'].map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          // Do something when the value changes
                        },
                      ),
                      SizedBox(height: 16),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Description',
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Implement save reminder functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFD3E004),
                          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                        ),
                        child: Text('Save', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
              // Reminder Settings
              Text('Reminder Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Card(
                margin: EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: Text('Enable Notifications'),
                        value: true,
                        onChanged: (bool value) {
                          // Do something when switch is toggled
                        },
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Reminder Tone',
                        ),
                        items: ['Default', 'Tone 1', 'Tone 2'].map((String tone) {
                          return DropdownMenuItem<String>(
                            value: tone,
                            child: Text(tone),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          // Do something when the value changes
                        },
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Lead Time',
                        ),
                        items: ['10 minutes before', '30 minutes before', '1 hour before'].map((String time) {
                          return DropdownMenuItem<String>(
                            value: time,
                            child: Text(time),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          // Do something when the value changes
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // Past Reminders
              Text('Past Reminders', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Card(
                margin: EdgeInsets.only(bottom: 16),
                child: ListTile(
                  leading: Icon(Icons.check, color: Color(0xFFD3E004)),
                  title: Text('Vet Appointment'),
                  subtitle: Text('09/30/2023 at 2:00 PM'),
                ),
              ),
              Card(
                margin: EdgeInsets.only(bottom: 16),
                child: ListTile(
                  leading: Icon(Icons.check, color: Color(0xFFD3E004)),
                  title: Text('Medication'),
                  subtitle: Text('10/01/2023 at 8:00 AM'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
