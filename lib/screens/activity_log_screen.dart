import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'gps_screen.dart';

class ActivityLogScreen extends StatefulWidget {
  const ActivityLogScreen({super.key});

  @override
  _ActivityLogScreenState createState() => _ActivityLogScreenState();
}

class _ActivityLogScreenState extends State<ActivityLogScreen> {
  final List<Map<String, String>> _activityLog = [];

  void _addActivity(String duration, int steps) {
    setState(() {
      _activityLog.add({
        'date': DateTime.now().toString(),
        'activity': 'Tracking',
        'duration': duration,
        'steps': '$steps steps',
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Log'),
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
              const Text('Daily Activity Overview',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Card(
                color: Color(0xFFFFF9C4),
                margin: EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.directions_walk, color: Color(0xFFD3E004)),
                          Text('Walking'),
                          Text('30 mins',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.sports_soccer, color: Color(0xFFD3E004)),
                          Text('Playing'),
                          Text('45 mins',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.bed, color: Color(0xFFD3E004)),
                          Text('Resting'),
                          Text('3 hours',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Text('Weekly Activity Summary',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 200,
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: _createSampleData(),
                            isCurved: true,
                            color: const Color(0xFFD3E004),
                            barWidth: 4,
                            isStrokeCapRound: true,
                            belowBarData: BarAreaData(show: false),
                            dotData: const FlDotData(show: false),
                          ),
                        ],
                        titlesData: const FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true),
                          ),
                        ),
                        borderData: FlBorderData(show: true),
                        gridData: const FlGridData(show: true),
                      ),
                    ),
                  ),
                ),
              ),
              // Button to navigate to GPS Tracking Screen
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GPSTrackingScreen(
                                onFinish: (String duration, int steps) {
                                  _addActivity(duration, steps);
                                },
                              )),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD3E004),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 32),
                  ),
                  child: const Text('Track Activity',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Activity Log',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ..._activityLog
                  .map((log) => _buildActivityLogEntry(log))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityLogEntry(Map<String, String> log) {
    return Card(
      color: const Color(0xFFFFF9C4), // Light yellow color
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${log['date']}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Activity: ${log['activity']}'),
            Text('Duration: ${log['duration']}'),
            Text('Steps: ${log['steps']}'),
          ],
        ),
      ),
    );
  }

  static List<FlSpot> _createSampleData() {
    return [
      const FlSpot(0, 30),
      const FlSpot(1, 60),
      const FlSpot(2, 90),
      const FlSpot(3, 40),
      const FlSpot(4, 70),
      const FlSpot(5, 100),
      const FlSpot(6, 20),
    ];
  }
}
