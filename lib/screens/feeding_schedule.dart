import 'package:flutter/material.dart';

class FeedingScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feeding Schedule'),
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
              Card(
                margin: EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Current Feeding Schedule',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          ElevatedButton.icon(
                            onPressed: () {
                              // Implement edit functionality
                            },
                            icon: Icon(Icons.edit, color: Colors.white),
                            label: Text('Edit',
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFD3E004),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      _buildFeedingTime(
                          '8:00 AM', 'Wet Food', 'assets/bone1.png'),
                      _buildFeedingTime(
                          '12:00 PM', 'Dry Food', 'assets/bone2.png'),
                      _buildFeedingTime(
                          '6:00 PM', 'Treats', 'assets/bone3.png'),
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Upcoming Meals',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      _buildUpcomingMeal('10:00 AM', 'Dry Food', '50g'),
                      _buildUpcomingMeal('4:00 PM', 'Wet Food', '100g'),
                      _buildUpcomingMeal('9:00 PM', 'Treats', '20g'),
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Add Meal',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      _buildTextField('Meal Time'),
                      _buildTextField('Type of Food'),
                      _buildTextField('Portion Size'),
                      SizedBox(height: 8),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Implement save functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFD3E004),
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 32),
                          ),
                          child: Text('Save',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Reminders',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      _buildReminder('Daily Reminder'),
                      _buildReminder('Weekly Reminder'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeedingTime(String time, String type, String iconPath) {
    return ListTile(
      leading: Image.asset(iconPath, width: 24, height: 24, fit: BoxFit.cover),
      title:
          Text('$time - $type', style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildUpcomingMeal(String time, String type, String portion) {
    return ListTile(
      title:
          Text('$time - $type', style: TextStyle(fontWeight: FontWeight.bold)),
      trailing: Text(portion),
    );
  }

  Widget _buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildReminder(String text) {
    return SwitchListTile(
      title: Text(text),
      value: true,
      onChanged: (bool value) {
        // Implement switch functionality
      },
    );
  }
}
