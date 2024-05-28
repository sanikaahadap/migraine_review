import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
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
          'profilePicture': userInfo['profilePicture'], // Assuming there's a profile picture URL
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
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF16666B), Color(0xFF2C8C92)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    userData['profilePicture'] != null
                        ? CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(userData['profilePicture']),
                    )
                        : CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Text(
                        _getInitials(userData['name']),
                        style: const TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildInfoCard('Name', userData['name'], Icons.person),
                    _buildInfoCard('Date of Birth', userData['dob'], Icons.cake),
                    _buildInfoCard('Age', '${userData['age']} years', Icons.calendar_today),
                    _buildInfoCard('Gender', userData['gender'], Icons.person_outline),
                    // Add more fields here as needed
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF16666B)),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF16666B)),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(fontSize: 16.0, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getInitials(String name) {
    List<String> nameParts = name.split(' ');
    String initials = '';
    if (nameParts.isNotEmpty) {
      initials = nameParts.map((part) => part[0]).take(2).join();
    }
    return initials.toUpperCase();
  }
}
