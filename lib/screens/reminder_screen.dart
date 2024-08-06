import 'package:flutter/material.dart';
import 'package:petcare/screens/notification_service.dart';
import 'package:intl/intl.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  _RemindersScreenState createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  final List<Map<String, String>> _upcomingReminders = [];
  final List<Map<String, String>> _pastReminders = [];
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String? _selectedType;
  final TextEditingController _descriptionController = TextEditingController();
  bool _notificationsEnabled = true;
  String? _reminderTone = 'Default';
  String? _leadTime = '10 minutes before';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
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
              const Text('Upcoming Reminders', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ..._upcomingReminders.map((reminder) => _buildReminderCard(reminder)).toList(),
              const SizedBox(height: 16),
              const Text('Add Reminder', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _dateController,
                        decoration: const InputDecoration(
                          labelText: 'Date',
                          hintText: 'dd/mm/yy',
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _dateController.text = DateFormat('dd/MM/yy').format(pickedDate);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _timeController,
                        decoration: const InputDecoration(
                          labelText: 'Time',
                          hintText: '--:--',
                          prefixIcon: Icon(Icons.access_time),
                        ),
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              _timeController.text = pickedTime.format(context);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Type',
                        ),
                        items: ['Appointment', 'Medication', 'Feeding Schedule', 'Activity Log', 'Health Tracking'].map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedType = newValue;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _saveReminder,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD3E004),
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                        ),
                        child: const Text('Save', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
              const Text('Reminder Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: const Text('Enable Notifications'),
                        value: _notificationsEnabled,
                        onChanged: (bool value) {
                          setState(() {
                            _notificationsEnabled = value;
                          });
                        },
                      ),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Reminder Tone',
                        ),
                        items: ['Default', 'Tone 1', 'Tone 2'].map((String tone) {
                          return DropdownMenuItem<String>(
                            value: tone,
                            child: Text(tone),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _reminderTone = newValue;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Lead Time',
                        ),
                        items: ['At the time of event', '10 minutes before', '30 minutes before', '1 hour before'].map((String time) {
                          return DropdownMenuItem<String>(
                            value: time,
                            child: Text(time),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _leadTime = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const Text('Past Reminders', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ..._pastReminders.map((reminder) => _buildReminderCard(reminder)).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReminderCard(Map<String, String> reminder) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(Icons.check, color: Color(0xFFD3E004)),
        title: Text(reminder['title']!),
        subtitle: Text('${reminder['date']} at ${reminder['time']}'),
      ),
    );
  }

  void _saveReminder() {
    if (_dateController.text.isEmpty || _timeController.text.isEmpty || _selectedType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all the fields')),
      );
      return;
    }

    final reminder = {
      'title': _selectedType!,
      'date': _dateController.text,
      'time': _timeController.text,
      'description': _descriptionController.text,
    };

    setState(() {
      _upcomingReminders.add(reminder);
    });

    if (_notificationsEnabled) {
      _scheduleNotification(reminder);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reminder saved')),
    );

    _dateController.clear();
    _timeController.clear();
    _selectedType = null;
    _descriptionController.clear();
  }

  Future<void> _scheduleNotification(Map<String, String> reminder) async {
    DateTime scheduledDateTime = DateFormat('dd/MM/yy HH:mm').parse('${reminder['date']} ${reminder['time']}');

    // Adjust the scheduled time based on lead time
    if (_leadTime == '10 minutes before') {
      scheduledDateTime = scheduledDateTime.subtract(const Duration(minutes: 10));
    } else if (_leadTime == '30 minutes before') {
      scheduledDateTime = scheduledDateTime.subtract(const Duration(minutes: 30));
    } else if (_leadTime == '1 hour before') {
      scheduledDateTime = scheduledDateTime.subtract(const Duration(hours: 1));
    }

    debugPrint('Scheduling reminder at: $scheduledDateTime');

    await NotificationService.showNotification(
      _upcomingReminders.length,
      reminder['title']!,
      reminder['description']!,
      scheduledDateTime,
    );
  }
}
