import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_charts/flutter_charts.dart';
import 'edit_health_record_screen.dart';  // Import the new screen

class HealthTrackingScreen extends StatefulWidget {
  const HealthTrackingScreen({super.key});

  @override
  _HealthTrackingScreenState createState() => _HealthTrackingScreenState();
}

class _HealthTrackingScreenState extends State<HealthTrackingScreen> {
  String weight = '20kg';
  String temperature = '38°C';
  String heartRate = '75 bpm';

  List<Map<String, dynamic>> healthRecords = [
    {'date': '2023-09-15', 'type': 'General Check-up', 'vet': 'Dr. Smith', 'image': null},
    {'date': '2023-08-20', 'type': 'Vaccination', 'vet': 'Dr. Brown', 'image': null},
    {'date': '2023-07-10', 'type': 'Dental Check-up', 'vet': 'Dr. Lee', 'image': null},
  ];

  Future<void> _addEditHealthRecord({Map<String, dynamic>? record}) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditHealthRecordScreen(record: record),
      ),
    );

    if (result != null) {
      setState(() {
        if (record != null) {
          record['date'] = result['date'];
          record['type'] = result['type'];
          record['vet'] = result['vet'];
          record['image'] = result['image'];
        } else {
          healthRecords.add(result);
        }
      });
    }
  }

  void _editOverview() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String tempWeight = weight;
        String tempTemperature = temperature;
        String tempHeartRate = heartRate;
        return AlertDialog(
          title: const Text('Edit Overview'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Weight'),
                onChanged: (value) {
                  tempWeight = value;
                },
                controller: TextEditingController(text: weight),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Temperature'),
                onChanged: (value) {
                  tempTemperature = value;
                },
                controller: TextEditingController(text: temperature),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Heart Rate'),
                onChanged: (value) {
                  tempHeartRate = value;
                },
                controller: TextEditingController(text: heartRate),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  weight = tempWeight;
                  temperature = tempTemperature;
                  heartRate = tempHeartRate;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Tracking'),
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
                color: const Color(0xFFFFF9C4), // Light yellow color
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: _editOverview,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Icon(Icons.monitor_weight, color: Color(0xFFD3E004)),
                              const Text('Weight'),
                              Text(weight, style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(Icons.thermostat, color: Color(0xFFD3E004)),
                              const Text('Temperature'),
                              Text(temperature, style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(Icons.favorite, color: Color(0xFFD3E004)),
                              const Text('Heart Rate'),
                              Text(heartRate, style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
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
                      const Text('Health Records', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      ...healthRecords.map((record) => _buildHealthRecord(record)),
                      const SizedBox(height: 8),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            _addEditHealthRecord();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD3E004),
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                          ),
                          child: const Text('Add Record', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                color: const Color(0xFFFFF9C4), // Light yellow color
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Health Metrics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 200,
                        child: LineChart(
                          painter: LineChartPainter(
                            lineChartContainer: LineChartTopContainer(
                              chartData: ChartData(
                                dataRows: const [
                                  [10.0, 20.0, 5.0, 30.0, 5.0, 20.0],
                                  [30.0, 60.0, 16.0, 100.0, 12.0, 120.0],
                                  [25.0, 40.0, 20.0, 80.0, 12.0, 90.0],
                                ],
                                xUserLabels: const ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                                dataRowsLegends: const ['Series 1', 'Series 2', 'Series 3'],
                                chartOptions: const ChartOptions(),
                              ),
                            ),
                          ),
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

  Widget _buildHealthTip(String title, String description, String imagePath) {
    return ListTile(
      leading: Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.cover),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(description),
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
    );
  }

  Widget _buildHealthRecord(Map<String, dynamic> record) {
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
                  record['date']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(record['type']!),
                Text('Vet: ${record['vet']}'),
                if (record['image'] != null)
                  Image.file(File(record['image']!.path), height: 50, width: 50),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.grey),
              onPressed: () {
                _addEditHealthRecord(record: record);
              },
            ),
          ],
        ),
      ),
    );
  }
}
