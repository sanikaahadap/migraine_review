import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:neurooooo/user_home/nav_bar.dart';

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CustomBottomNavigationBar(),
              ),
            );
          },
        ),
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
                    const SizedBox(height: 20), // Add some spacing before the button
                    ElevatedButton(
                      onPressed: () => _showDeleteAccountDialog(context),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red, backgroundColor: Colors.white, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Rounded corners
                        ),
                      ),
                      child: const Text('Delete Account'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteAccount(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _reauthenticateUser(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String? password = await _getUserPassword(context); // Implement this function to get password from user

      if (password != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password,
        );
        await user.reauthenticateWithCredential(credential);
      }
    }
  }

  Future<String?> _getUserPassword(BuildContext context) async {
    String? password;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController passwordController = TextEditingController();
        return AlertDialog(
          title: const Text('Reauthenticate'),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                password = passwordController.text;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return password;
  }

  Future<void> _deleteAccount(BuildContext context) async {
    try {
      await _reauthenticateUser(context);
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Delete user data from Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();

        // Delete user account
        await user.delete();

        // Sign out the user
        await FirebaseAuth.instance.signOut();

        // Show confirmation dialog
        _showAccountDeletedDialog(context);
      }
    } catch (e) {
      print(e);
      String errorMessage = 'Error deleting account. Please try again.';
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'requires-recent-login':
            errorMessage = 'Please reauthenticate to delete your account.';
            break;
          case 'network-request-failed':
            errorMessage = 'Network error. Please check your connection.';
            break;
          default:
            errorMessage = 'An unexpected error occurred. Please try again.';
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  void _showAccountDeletedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Account Deleted'),
          content: const Text('Your account has been successfully deleted.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/login');
              },
            ),
          ],
        );
      },
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