import 'package:flutter/material.dart';
// import 'package:neurooooo/other_services/user_service.dart';
// import 'package:neurooooo/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neurooooo/admin_home/users_info.dart';
import 'package:neurooooo/login/login_signup_page.dart';

class AdminHomePage extends StatelessWidget {
  final UserService userService = UserService();

  AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF16666B),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Admin Dashboard',
                    style: TextStyle(
                      color: Color(0xFF16666B),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientDetailsPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF16666B),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 32),
                    ),
                    child: const Text(
                      'Patient Details',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                bottom: 20), // Add some space from the bottom
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginSignupPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16666B),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              ),
              icon: const Icon(Icons.logout,
                  color: Colors.white), // Set the icon color to white
              label: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
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
        builder:
            (BuildContext context, AsyncSnapshot<List<ModelUser>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<ModelUser> users = snapshot.data ?? [];

            // Remove duplicate entries
            final uniqueUsers = users.toSet().toList();

            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: uniqueUsers.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    leading: CircleAvatar(
                      backgroundColor: Color(0xFF16666B),
                      child: Text(
                        uniqueUsers[index].name[0].toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      uniqueUsers[index].name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(uniqueUsers[index].email),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UserDetailsPage(user: uniqueUsers[index]),
                        ),
                      );
                    },
                  ),
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
  final String uid;
  final String email;
  final String dob;

  ModelUser(
      {required this.name,
      required this.uid,
      required this.dob,
      required this.email});

  factory ModelUser.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ModelUser(
      name: data['name'] ?? 'No Name',
      uid: data['uid'] ?? 'No UID',
      dob: data['dob'] ?? 'No dob',
      email: data['email'] ?? 'No email', // Ensure there's a default value
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
