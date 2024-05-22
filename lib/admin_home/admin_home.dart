// In admin_home.dart
import 'package:flutter/material.dart';
import 'package:neurooooo/other_services/user_service.dart';
import 'package:neurooooo/models/user.dart';// Import the user service
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neurooooo/admin_home/users_info.dart';


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

  PatientDetailsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
      ),
      body: FutureBuilder<List<ModelUser>>(
        future: userService.getUsers(),
        builder: (BuildContext context, AsyncSnapshot<List<ModelUser>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<ModelUser> users = snapshot.data ?? [];

            // Remove duplicate entries
            final uniqueUsers = users.toSet().toList();

            return ListView.builder(
              itemCount: uniqueUsers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(uniqueUsers[index].name),
                  subtitle: Text(uniqueUsers[index].email),
                  onTap: () {
                    // Navigate to another page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailsPage(user: uniqueUsers[index]),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}




class ModelUser {
  final String name;
  final String email;
  final String uid;

  ModelUser({required this.name, required this.email, required this.uid});

  factory ModelUser.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ModelUser(
      name: data['name'] ?? 'No Name',
      email: data['email'] ?? 'No Email',
      uid: data['uid'] ?? 'No UID',
    );
  }
}

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ModelUser>> getUsers() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').get();
      List<ModelUser> users = querySnapshot.docs.map((doc) {
        return ModelUser.fromDocument(doc);
      }).toList();
      return users;
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }
}