import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, dynamic>> _userData;

  @override
  void initState() {
    super.initState();
    _userData = _getUserData();
  }

  Future<Map<String, dynamic>> _getUserData() async {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final userDocSnapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final userInfoDocSnapshot = await FirebaseFirestore.instance.collection('user_info').doc(uid).get();

      if (userDocSnapshot.exists && userInfoDocSnapshot.exists) {
        final userData = userDocSnapshot.data() as Map<String, dynamic>;
        final userInfo = userInfoDocSnapshot.data() as Map<String, dynamic>;

        // Extract Date of Birth from user data and calculate age
        String dobString = userData['dob']; // Assuming 'dob' is a String
        DateTime dob = DateTime.parse(dobString); // Parsing string to DateTime
        DateTime now = DateTime.now();
        int age = now.year - dob.year;
        if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
          age--;
        }

        // Combine data from both collections
        Map<String, dynamic> combinedData = {
          'name': userData['name'],
          'dob': userData['dob'],
          'age': age,
          'gender': userInfo['gender'],
        };

        return combinedData;
      } else {
        throw Exception('User data not found');
      }
    } else {
      throw Exception('User ID not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF16666B),
      ),
      body: FutureBuilder(
        future: _userData,
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('User data not found'));
          } else {
            var userData = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Name:',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF16666B)),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${userData['name']}',
                    style: const TextStyle(fontSize: 16.0, color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Date of Birth:',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF16666B)),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${userData['dob']}',
                    style: const TextStyle(fontSize: 16.0, color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Age:',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF16666B)),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${userData['age']} years',
                    style: const TextStyle(fontSize: 16.0, color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Gender:',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF16666B)),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${userData['gender']}',
                    style: const TextStyle(fontSize: 16.0, color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  // Add more fields here as needed
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
