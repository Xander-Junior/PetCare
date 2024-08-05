import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController petAgeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the scaffold background color
      resizeToAvoidBottomInset: false, // Prevent background color flash
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg2.jpg'), // Ensure this image exists in your assets folder
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Top Texts
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Connect with Pets',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Join the community, share experiences',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Main Container
                  Container(
                    margin: EdgeInsets.only(top: 155),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Logo and Heading Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Image.asset(
                              'assets/petLogo.png', 
                              height: 40,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Input Fields
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 2.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 2.0),
                            ),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 2.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: petNameController,
                          decoration: InputDecoration(
                            labelText: "Pet's Name",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 2.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: petAgeController,
                          decoration: InputDecoration(
                            labelText: "Pet's Age",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 2.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        // Sign Up Button
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Implement sign-up functionality
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFD3E004), // Button background color
                              foregroundColor: Colors.white, // Button text color
                              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                              textStyle: TextStyle(fontSize: 18),
                            ),
                            child: Text('Sign Up'),
                          ),
                        ),
                        // Already Signed Up Link
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Column(
                              children: [
                                Text(
                                  'Already signed up?',
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent, // Button background color
                                    foregroundColor: Colors.blue, // Button text color
                                    shadowColor: Colors.transparent, // Remove button shadow
                                  ),
                                  child: Text(
                                    'Click here to login',
                                    style: TextStyle(fontSize: 16, color: Color(0xFFD3E004), decoration: TextDecoration.none),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
