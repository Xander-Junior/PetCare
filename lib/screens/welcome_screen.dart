import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background to white
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Text(
                'Get Started',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 16),
              Text(
                "Manage your pet's health and connect with other pet lovers!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey.shade600,
                    ),
              ),
              SizedBox(height: 40),
              Image.asset(
                'assets/9793786.jpg', // Ensure this image exists in the assets folder
                height: 250,
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD3E004), // Button background color
                  foregroundColor: Colors.white, // Button text color
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                  textStyle: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text('Go'),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}