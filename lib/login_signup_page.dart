import 'package:flutter/material.dart';
import 'package:neurooooo/login.dart';

class LoginSignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x80B2EBF2), // Set the background color for the AppBar
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Color(0x80B2EBF2),
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(

            children: [
              SizedBox(height: 70.0),
              // Logo image
              Image.asset(
                'assets/images/logo.png',
                height: MediaQuery.of(context).size.height * 0.22,
                fit: BoxFit.contain,
              ),

              SizedBox(height: 16.0),

              // 'Welcome' text
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF16666B),
                ),
              ),
              SizedBox(height: 16.0),

              // Login button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF16666B),
                  fixedSize: Size(170.0, 45.0),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 17.0, color: Colors.white),
                ),
              ),
              SizedBox(height: 16.0),

              // Signup button
              ElevatedButton(
                onPressed: () {
                  // Add signup button logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF16666B),
                  fixedSize: Size(170.0, 45.0),
                ),
                child: Text(
                  'Signup',
                  style: TextStyle(fontSize: 17.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginSignupPage(),
  ));
}
