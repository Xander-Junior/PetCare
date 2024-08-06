import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeedingScheduleScreen extends StatefulWidget {
  const FeedingScheduleScreen({super.key});

  @override
  _FeedingScheduleScreenState createState() => _FeedingScheduleScreenState();
}

class _FeedingScheduleScreenState extends State<FeedingScheduleScreen> {
  final List<FeedingTime> _feedingTimes = [
    FeedingTime('8:00 AM', 'Wet Food', 'assets/bone1.png'),
    FeedingTime('12:00 PM', 'Dry Food', 'assets/bone2.png'),
    FeedingTime('6:00 PM', 'Treats', 'assets/bone3.png'),
  ];

  final List<Meal> _upcomingMeals = [
    Meal('10:00 AM', 'Dry Food', '50g'),
    Meal('4:00 PM', 'Wet Food', '100g'),
    Meal('9:00 PM', 'Treats', '20g'),
  ];

  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _foodTypeController = TextEditingController();
  final TextEditingController _portionController = TextEditingController();

  void _showEditDialog(Meal meal, {int? index}) {
    _timeController.text = meal.time;
    _foodTypeController.text = meal.foodType;
    _portionController.text = meal.portion;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Meal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTimePickerField(),
              _buildTextField(_foodTypeController, 'Type of Food'),
              _buildTextField(_portionController, 'Portion Size'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  meal.time = _timeController.text;
                  meal.foodType = _foodTypeController.text;
                  meal.portion = _portionController.text;
                });
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD3E004)),
              child: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTimePickerField() {
    return TextField(
      controller: _timeController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Meal Time',
        border: const OutlineInputBorder(),
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
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void _addFeedingTime() {
    setState(() {
      _feedingTimes.add(
        FeedingTime(
          _timeController.text,
          _foodTypeController.text,
          'assets/bone1.png', // Default icon for new feeding times
        ),
      );
    });
  }

  void _editFeedingTime(int index) {
    _timeController.text = _feedingTimes[index].time;
    _foodTypeController.text = _feedingTimes[index].foodType;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Feeding Time'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTimePickerField(),
              _buildTextField(_foodTypeController, 'Type of Food'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _feedingTimes[index] = FeedingTime(
                    _timeController.text,
                    _foodTypeController.text,
                    _feedingTimes[index].iconPath,
                  );
                });
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD3E004)),
              child: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _addMeal() {
    setState(() {
      _upcomingMeals.add(
        Meal(
          _timeController.text,
          _foodTypeController.text,
          _portionController.text,
        ),
      );
    });
  }

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
                              _addFeedingTime();
                            },
                            icon: const Icon(Icons.add, color: Colors.white),
                            label: const Text('Add',
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD3E004),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ..._feedingTimes.map((feedingTime) {
                        int index = _feedingTimes.indexOf(feedingTime);
                        return ListTile(
                          leading: Image.asset(feedingTime.iconPath, width: 24, height: 24, fit: BoxFit.cover),
                          title: Text(
                            '${feedingTime.time} - ${feedingTime.foodType}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _editFeedingTime(index),
                          ),
                        );
                      }).toList(),
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
                      ..._upcomingMeals.map((meal) {
                        int index = _upcomingMeals.indexOf(meal);
                        return ListTile(
                          title: Text(
                            '${meal.time} - ${meal.foodType}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('Portion: ${meal.portion}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _showEditDialog(meal, index: index),
                          ),
                        );
                      }).toList(),
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
                      _buildTimePickerField(),
                      _buildTextField(_foodTypeController, 'Type of Food'),
                      _buildTextField(_portionController, 'Portion Size'),
                      const SizedBox(height: 8),
                      Center(
                        child: ElevatedButton(
                          onPressed: _addMeal,
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
            ],
          ),
        ),
      ),
    );
  }
}

class FeedingTime {
  String time;
  String foodType;
  String iconPath;

  FeedingTime(this.time, this.foodType, this.iconPath);
}

class Meal {
  String time;
  String foodType;
  String portion;

  Meal(this.time, this.foodType, this.portion);
}
