import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ActivityLogScreen extends StatefulWidget {
  const ActivityLogScreen({super.key});

  @override
  _ActivityLogScreenState createState() => _ActivityLogScreenState();
}

class _ActivityLogScreenState extends State<ActivityLogScreen> {
  final List<LatLng> _route = [];
  GoogleMapController? _mapController;
  final Location _location = Location();
  bool _tracking = false;

  void _startTracking() {
    setState(() {
      _tracking = true;
      _route.clear();
    });

    _location.onLocationChanged.listen((LocationData currentLocation) {
      if (_tracking) {
        setState(() {
          _route.add(LatLng(currentLocation.latitude!, currentLocation.longitude!));
          _mapController?.animateCamera(
            CameraUpdate.newLatLng(LatLng(currentLocation.latitude!, currentLocation.longitude!)),
          );
        });
      }
    });
  }

  void _stopTracking() {
    setState(() {
      _tracking = false;
    });
  }

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

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
              // Daily Activity Overview
              const Text('Daily Activity Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Card(
                color: Color(0xFFFFF9C4), // Light yellow color
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
                          Text('30 mins', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.sports_soccer, color: Color(0xFFD3E004)),
                          Text('Playing'),
                          Text('45 mins', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.bed, color: Color(0xFFD3E004)),
                          Text('Resting'),
                          Text('3 hours', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Weekly Activity Summary
              const Text('Weekly Activity Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
              // Start and Stop Tracking
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: _startTracking,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD3E004),
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      ),
                      child: const Text('Start Tracking', style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _stopTracking,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      ),
                      child: const Text('Stop Tracking', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              // Displaying the Map with Tracked Route
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: GoogleMap(
                  initialCameraPosition: _initialCameraPosition,
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId('route'),
                      points: _route,
                      color: Colors.blue,
                      width: 5,
                    ),
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Activity Log
              const Text('Activity Log', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildActivityLogEntry('2023-10-10', 'Walking', '30 mins', 'Walked in the park.'),
              _buildActivityLogEntry('2023-10-09', 'Playing', '45 mins', 'Played fetch in the backyard.'),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Implement add activity functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD3E004),
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  ),
                  child: const Text('Add Activity', style: TextStyle(color: Colors.white)),
                ),
              ),
              // Goal Setting
              const Text('Goal Setting', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildGoalSetting('Daily Walking Goal: 60 mins', 0.5),
                      _buildGoalSetting('Weekly Playing Goal: 5 hours', 0.3),
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

  Widget _buildActivityLogEntry(String date, String activity, String duration, String notes) {
    return Card(
      color: const Color(0xFFFFF9C4), // Light yellow color
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: $date', style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Activity: $activity'),
            Text('Duration: $duration'),
            Text('Notes: $notes'),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalSetting(String goal, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(goal),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[200],
          color: const Color(0xFFD3E004),
        ),
        const SizedBox(height: 16),
      ],
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
