import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/user.dart'; // Import the user model

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _usersCollection = 'users'; // Change this to match your Firestore collection name

  Future<List<ModelUser>> getUsers() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection(_usersCollection).get();
      List<ModelUser> users = querySnapshot.docs.map((doc) => ModelUser.fromSnap(doc)).toList();
      return users;
    } catch (error) {
      print('Error fetching users: $error');
      return []; // Return an empty list if an error occurs
    }
  }
}
