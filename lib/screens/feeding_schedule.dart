import 'package:flutter/material.dart';

class FeedingScheduleScreen extends StatelessWidget {
  const FeedingScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feeding Schedule'),
        backgroundColor: const Color(0xFFD3E004),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
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
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Current Feeding Schedule',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          ElevatedButton.icon(
                            onPressed: () {
                              // Implement edit functionality
                            },
                            icon: const Icon(Icons.edit, color: Colors.white),
                            label: const Text('Edit',
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD3E004),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
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
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Upcoming Meals',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      _buildUpcomingMeal('10:00 AM', 'Dry Food', '50g'),
                      _buildUpcomingMeal('4:00 PM', 'Wet Food', '100g'),
                      _buildUpcomingMeal('9:00 PM', 'Treats', '20g'),
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Add Meal',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      _buildTextField('Meal Time'),
                      _buildTextField('Type of Food'),
                      _buildTextField('Portion Size'),
                      const SizedBox(height: 8),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Implement save functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD3E004),
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 32),
                          ),
                          child: const Text('Save',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Reminders',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
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
          Text('$time - $type', style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildUpcomingMeal(String time, String type, String portion) {
    return ListTile(
      title:
          Text('$time - $type', style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: Text(portion),
    );
  }

  Widget _buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
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
