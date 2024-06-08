import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neurooooo/admin_home/users_info.dart';
import 'package:neurooooo/login/login_signup_page.dart';

class AdminHomePage extends StatelessWidget {
  final UserService userService = UserService();

  AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF80DEEA), Color(0xFF16666B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Welcome',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Dr. Bindu Menon',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black26,
                                offset: Offset(3.0, 3.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PatientDetailsPage()),
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
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
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

class PatientDetailsPage extends StatefulWidget {
  const PatientDetailsPage({super.key});

  @override
  _PatientDetailsPageState createState() => _PatientDetailsPageState();
}

class _PatientDetailsPageState extends State<PatientDetailsPage> {
  final UserService userService = UserService();
  List<ModelUser> _users = [];
  List<ModelUser> _filteredUsers = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _searchController.addListener(_filterUsers);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _fetchUsers() async {
    List<ModelUser> users = await userService.getUsers();
    setState(() {
      _users = users;
      _filteredUsers = users;
    });
  }

  void _filterUsers() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUsers = _users
          .where((user) => user.name.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
        backgroundColor: const Color(0xFF16666B),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by name',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: _buildUserList(),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList() {
    if (_filteredUsers.isEmpty) {
      return const Center(child: Text('No users found'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: _filteredUsers.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: CircleAvatar(
              backgroundColor: const Color(0xFF16666B),
              child: Text(
                _filteredUsers[index].name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              _filteredUsers[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(_filteredUsers[index].email),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      UserDetailsPage(user: _filteredUsers[index]),
                ),
              );
            },
          ),
        );
      },
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
