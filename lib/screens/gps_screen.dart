import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:petcare/screens/const.dart';

class GPSTrackingScreen extends StatefulWidget {
  final Function(String duration, int steps) onFinish;

  const GPSTrackingScreen({super.key, required this.onFinish});

  @override
  _GPSTrackingScreenState createState() => _GPSTrackingScreenState();
}

class _GPSTrackingScreenState extends State<GPSTrackingScreen> {
  final List<LatLng> _route = [];
  GoogleMapController? _mapController;
  final Location _location = Location();
  bool _tracking = false;
  bool _paused = false;
  LatLng? _currentPosition;

  Map<PolylineId, Polyline> polylines = {};
  int _seconds = 0;
  Timer? _timer;
  int _steps = 0;

  static const LatLng _initialPosition = LatLng(37.42796133580664, -122.085749655962);
  static const LatLng _destinationPosition = LatLng(37.3346, -122.0090);

  @override
  void initState() {
    super.initState();
    _getLocationUpdates();
  }

  Future<void> _getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _location.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        setState(() {
          _currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          if (_tracking && !_paused) {
            _route.add(_currentPosition!);
            _mapController?.animateCamera(
              CameraUpdate.newLatLng(_currentPosition!),
            );
            _updatePolylines();
            _steps++;
          }
        });
      }
    });
  }

  void _startTracking() {
    setState(() {
      _tracking = true;
      _paused = false;
      _route.clear();
      _seconds = 0;
      _steps = 0;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (!_paused) {
        setState(() {
          _seconds++;
        });
      }
    });
  }

  void _pauseTracking() {
    setState(() {
      _paused = !_paused;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_paused ? 'Tracking Paused' : 'Tracking Resumed'),
      ),
    );
  }

  void _stopTracking() {
    _timer?.cancel();
    setState(() {
      _tracking = false;
    });
    _saveActivityLog();
  }

  void _saveActivityLog() {
    String duration = "${_seconds ~/ 60} mins ${_seconds % 60} secs";
    widget.onFinish(duration, _steps);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tracking Stopped. Activity log saved.'),
      ),
    );
    Navigator.pop(context);
  }

  Future<void> _updatePolylines() async {
    List<LatLng> polylineCoordinates = await _getPolylinePoints();
    _generatePolylineFromPoints(polylineCoordinates);
  }

  Future<List<LatLng>> _getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineRequest polylineRequest = PolylineRequest(
      origin: PointLatLng(_initialPosition.latitude, _initialPosition.longitude),
      destination: PointLatLng(_destinationPosition.latitude, _destinationPosition.longitude),
      mode: TravelMode.driving,
    );
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: polylineRequest,
      googleApiKey: GOOGLE_MAPS_API_KEY,
    );
    if (result.points.isNotEmpty) {
      for (PointLatLng point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void _generatePolylineFromPoints(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 8,
    );
    setState(() {
      polylines[id] = polyline;
    });
  }

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: _initialPosition,
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPS Tracking'),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    onPressed: _pauseTracking,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    ),
                    child: const Text('Pause/Resume Tracking', style: TextStyle(color: Colors.white)),
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
                  const SizedBox(height: 8),
                  Text(
                    _tracking
                        ? 'Tracking... Duration: ${_seconds ~/ 60} mins ${_seconds % 60} secs, Steps: $_steps'
                        : 'Not Tracking',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _currentPosition == null
                  ? const Center(child: CircularProgressIndicator())
                  : GoogleMap(
                      initialCameraPosition: _initialCameraPosition,
                      markers: {
                        Marker(
                          markerId: MarkerId("_currentLocation"),
                          icon: BitmapDescriptor.defaultMarker,
                          position: _currentPosition!,
                        ),
                        Marker(
                          markerId: MarkerId("_sourceLocation"),
                          icon: BitmapDescriptor.defaultMarker,
                          position: _initialPosition,
                        ),
                        Marker(
                          markerId: MarkerId("_destinationLocation"),
                          icon: BitmapDescriptor.defaultMarker,
                          position: _destinationPosition,
                        ),
                      },
                      polylines: Set<Polyline>.of(polylines.values),
                      onMapCreated: (GoogleMapController controller) {
                        _mapController = controller;
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
