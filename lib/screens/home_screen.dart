import 'package:flutter/material.dart';
import 'package:petcare/screens/home_screen1.dart';
import 'package:petcare/screens/profile_screen.dart';
import 'package:petcare/screens/health_tracking_screen.dart';
import 'package:petcare/screens/feeding_schedule.dart';
import 'package:petcare/screens/activity_log_screen.dart';
import 'package:petcare/screens/reminder_screen.dart';
import 'package:petcare/screens/pet_profile.dart';
import 'package:petcare/screens/pet_diaries_screen.dart'; // Import the new screen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [HomeTab(), HomeScreen1()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PetCare Home'),
        backgroundColor: Color(0xFFD3E004),
      ),
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
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
        selectedItemColor: Color(0xFFD3E004),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.grey[200],
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Section
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/bg6.jpg'),
                    radius: 40,
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Max',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Age: 3 years'),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.grey),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          // Info Cards
          Card(
            color: Color.fromARGB(255, 255, 255, 255),
            margin: EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text('Daily Health Tips', style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
              subtitle: Text('Tip: Make sure your pet drinks plenty of water.', style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
            ),
          ),
          Card(
            color: Color.fromARGB(255, 255, 255, 255),
            margin: EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text('Upcoming Reminders', style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
              subtitle: Text('Vet appointment - Tomorrow at 10:00 AM', style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
            ),
          ),
          Card(
            color: Color.fromARGB(255, 255, 255, 255),
            margin: EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text('Recent Activity Log', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              subtitle: Text('Walked - 30 minutes', style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
            ),
          ),
          // Feature Grid
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HealthTrackingScreen()),
                    );
                  },
                  child: FeatureCard(title: 'Health Tracking'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FeedingScheduleScreen()),
                    );
                  },
                  child: FeatureCard(title: 'Feeding Schedule'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ActivityLogScreen()),
                    );
                  },
                  child: FeatureCard(title: 'Activity Log'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RemindersScreen()),
                    );
                  },
                  child: FeatureCard(title: 'Reminders'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PetProfileScreen()),
                    );
                  },
                  child: FeatureCard(title: 'Pet Profile'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PetDiariesScreen()),
                    );
                  },
                  child: FeatureCard(title: 'Pet Diaries'),
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

  FeatureCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width / 2) - 24,
      child: Card(
        color: Color(0xFFD3E004),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
        ),
      ),
    );
  }
}
