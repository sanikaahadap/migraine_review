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
                        MaterialPageRoute(builder: (context) => PatientDetailsPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF16666B),
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
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
            padding: const EdgeInsets.only(bottom: 20), // Add some space from the bottom
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
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              ),
              icon: const Icon(Icons.logout, color: Colors.white), // Set the icon color to white
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

  PatientDetailsPage({super.key});

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