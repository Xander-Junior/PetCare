import 'package:flutter/material.dart';

class HomeScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'PetCare Home',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white, // Set the background color to white
        elevation: 0, // Remove the shadow
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      drawer: Drawer(
        // Implement drawer if needed
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFD3E004),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Navigate to home
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to settings
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add Story Section
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildStoryAvatar('assets/img14.jpg', 'Buddy, 3'),
                    _buildStoryAvatar('assets/img16.jpg', 'Bella, 5'),
                    _buildStoryAvatar('assets/img13.jpg', 'Max, 2'),
                    _buildStoryAvatar('assets/img10.jpg', 'Luna, 4'),
                    _buildStoryAvatar('assets/img4.jpg', 'Charlie, 1'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Daily Health Tips Card
              Card(
                color: Colors.grey[200],
                margin: EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                            'assets/bg6.jpg'), // Replace with your image path
                      ),
                      title: Text('Daily Health Tips'),
                      subtitle: Text('Upcoming Reminders'),
                      trailing: IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {
                          // Implement more options
                        },
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        'assets/img1.jpg', // Replace with your image path
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('More', style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
              ),
              // Recent Activity Log Card
              Card(
                color: Colors.grey[200],
                margin: EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                            'assets/bg6.jpg'), // Replace with your image path
                      ),
                      title: Text('Recent Activity Log'),
                      subtitle: Text('Recent Activity Log'),
                      trailing: IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {
                          // Implement more options
                        },
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        'assets/img6.jpg', // Replace with your image path
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('More', style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStoryAvatar(String imagePath, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage:
                AssetImage(imagePath), // Replace with your image path
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
