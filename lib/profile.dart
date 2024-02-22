import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<DocumentSnapshot> _userData;

  @override
  void initState() {
    super.initState();
    _userData = _getUserData();
  }

  Future<DocumentSnapshot> _getUserData() async {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      return await FirebaseFirestore.instance.collection('users').doc(uid).get();
    } else {
      throw Exception('User ID not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder(
        future: _userData,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('User data not found'));
          } else {
            var userData = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${userData['name']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Age: ${userData['age']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Gender: ${userData['gender']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Date of Birth: ${userData['dateOfBirth']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Emergency Contact: ${userData['emergencyContact']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Previous Medical Conditions: ${userData['previousMedicalConditions']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
