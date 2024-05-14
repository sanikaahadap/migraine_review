// In admin_home.dart
import 'package:flutter/material.dart';
import 'package:neurooooo/other_services/user_service.dart';
import 'package:neurooooo/models/user.dart';// Import the user service

class AdminHomePage extends StatelessWidget {
  final UserService userService = UserService();

  AdminHomePage({super.key}); // Initialize the user service

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PatientDetailsPage()),
            );
          },
          child: const Text('Patient Details'),
        ),
      ),
    );
  }
}

class PatientDetailsPage extends StatelessWidget {
  final UserService userService = UserService();

  PatientDetailsPage({super.key}); // Initialize the user service

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
      ),
      body: FutureBuilder(
        future: userService.getUsers(),
        builder: (BuildContext context, AsyncSnapshot<List<ModelUser>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<ModelUser> users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[index].name),
                  subtitle: Text(users[index].email),
                  // Add more user details as needed
                );
              },
            );
          }
        },
      ),
    );
  }
}
