import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petcare/screens/activity_log_screen.dart';
import 'package:petcare/screens/feeding_schedule.dart';
import 'package:petcare/screens/health_tracking_screen.dart';
import 'package:petcare/screens/pet_diaries_screen.dart';
import 'package:petcare/screens/pet_profile.dart';
import 'package:petcare/screens/reminder_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:petcare/screens/home_screen1.dart';
import 'package:petcare/screens/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String userName = 'Your Name';
  String petName = 'Your Pet';
  String petAge = 'Age: Unknown';
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name') ?? 'Your Name';
      petName = prefs.getString('petName') ?? 'Your Pet';
      profileImageUrl = prefs.getString('petProfileImage');
      String? dobString = prefs.getString('dob');
      if (dobString != null) {
        DateTime dob = DateFormat('dd-MM-yyyy').parse(dobString);
        int age = DateTime.now().year - dob.year;
        petAge = 'Age: $age years';
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('onboarded');
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PetCare Home'),
        backgroundColor: const Color(0xFFD3E004),
        actions: [
          IconButton(
            icon: const Icon(Icons.power_settings_new),
            onPressed: _logout,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          RefreshIndicator(
            onRefresh: _loadUserData,
            child: HomeTab(
              userName: userName,
              petName: petName,
              petAge: petAge,
              profileImageUrl: profileImageUrl,
            ),
          ),
          const HomeScreen1(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Community',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFD3E004),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.grey[200],
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  final String userName;
  final String petName;
  final String petAge;
  final String? profileImageUrl;

  const HomeTab({
    super.key,
    required this.userName,
    required this.petName,
    required this.petAge,
    this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Section
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (profileImageUrl != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImagePreviewScreen(
                            imageUrl: profileImageUrl!,
                          ),
                        ),
                      );
                    }
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: profileImageUrl != null
                        ? FileImage(File(profileImageUrl!))
                        : const AssetImage('assets/bg6.jpg') as ImageProvider,
                    child: profileImageUrl == null
                        ? const Icon(Icons.camera_alt, color: Colors.grey)
                        : null,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      petName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(petAge),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.grey),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Info Cards
          const Card(
            color: Color.fromARGB(255, 255, 255, 255),
            margin: EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text('Daily Health Tips',
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              subtitle: Text('Your first tip',
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
            ),
          ),
          const Card(
            color: Color.fromARGB(255, 255, 255, 255),
            margin: EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text('Upcoming Reminders',
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              subtitle: Text('Your first reminder',
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
            ),
          ),
          const Card(
            color: Color.fromARGB(255, 255, 255, 255),
            margin: EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text('Recent Activity Log',
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              subtitle: Text('Your first activity',
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
            ),
          ),
          // Feature Grid
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HealthTrackingScreen()),
                    );
                  },
                  child: const FeatureCard(title: 'Health Tracking'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FeedingScheduleScreen()),
                    );
                  },
                  child: const FeatureCard(title: 'Feeding Schedule'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ActivityLogScreen()),
                    );
                  },
                  child: const FeatureCard(title: 'Activity Log'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RemindersScreen()),
                    );
                  },
                  child: const FeatureCard(title: 'Reminders'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PetProfileScreen()),
                    );
                  },
                  child: const FeatureCard(title: 'Pet Profile'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  PetDiariesScreen()),
                    );
                  },
                  child: const FeatureCard(title: 'Pet Diaries'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;

  const FeatureCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width / 2) - 24,
      child: Card(
        color: const Color(0xFFD3E004),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImagePreviewScreen extends StatelessWidget {
  final String imageUrl;

  const ImagePreviewScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Preview'),
        backgroundColor: const Color(0xFFD3E004),
      ),
      body: Center(
        child: Image.file(File(imageUrl)),
      ),
    );
  }
}

