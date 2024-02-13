import 'package:flutter/material.dart';
import 'package:neurooooo/plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFF16666B), // Set the cursor color to #16666B
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF16666B), // Set the button background color to #16666B
          ),
        ),
      ),
      home: UserInfoPage(),
    );
  }
}

class UserInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
    ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Tell us about yourself',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF16666B), // Text color similar to features page
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16.0),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    labelStyle: TextStyle(
                      color: Color(0xFF16666B), // Text color when not focused
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF16666B)), // Border color when focused
                    ),
                  ),
                  maxLines: null,
                ),
                const SizedBox(height: 16.0),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Do you have any existing medical conditions? If yes, please specify',
                    labelStyle: TextStyle(
                      color: Color(0xFF16666B), // Text color when not focused
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF16666B)), // Border color when focused
                    ),
                  ),
                  maxLines: null,
                ),
                const SizedBox(height: 16.0),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'List any current medications you are taking (prescription or over-the-counter)',
                    labelStyle: TextStyle(
                      color: Color(0xFF16666B), // Text color when not focused
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF16666B)), // Border color when focused
                    ),
                  ),
                  maxLines: null,
                ),
                const SizedBox(height: 16.0),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Have you had any surgeries or hospitalizations in the past? If yes, please provide details',
                    labelStyle: TextStyle(
                      color: Color(0xFF16666B), // Text color when not focused
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF16666B)), // Border color when focused
                    ),
                  ),
                  maxLines: null,
                ),
                const SizedBox(height: 16.0),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Emergency Contact Name',
                    labelStyle: TextStyle(
                      color: Color(0xFF16666B), // Text color when not focused
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF16666B)), // Border color when focused
                    ),
                  ),
                  maxLines: null,
                ),
                const SizedBox(height: 16.0),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Relationship',
                    labelStyle: TextStyle(
                      color: Color(0xFF16666B), // Text color when not focused
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF16666B)), // Border color when focused
                    ),
                  ),
                  maxLines: null,
                ),
                const SizedBox(height: 16.0),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Contact No.',
                    labelStyle: TextStyle(
                      color: Color(0xFF16666B), // Text color when not focused
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF16666B)), // Border color when focused
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  maxLines: null,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DisclaimerPage()),

                    );
                  },
                  child: const Text('Proceed'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DisclaimerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('This is the disclaimer page.'),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QuestionnairePage()),);// Action when the user accepts
              },
              child: const Text('Accept'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QuestionnairePage()),);// Action when the user declines
              },
              child: const Text('Decline'),
            ),
          ],
        ),
      ),
    );
  }
}
