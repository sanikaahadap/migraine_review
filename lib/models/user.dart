// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class ModelUser {
  final String email;
  final String name;
  final String uid;
  final String patient_id;
  final String phone;
  final String dob;
  final bool admin_role;


  ModelUser({
    required this.email,
    required this.name,
    required this.uid,
    required this.patient_id,
    required this.phone,
    required this.dob,
    this.admin_role = false, // Set default value to false
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'name': name,
    'uid': uid,
    'patient_id': patient_id,
    'phone': phone,
    'dob': dob,
    'admin_role': admin_role,
  };

  static ModelUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ModelUser(
      email: snapshot['email'],
      name: snapshot['name'],
      uid: snapshot['uid'], // Fixed the uid field
      patient_id: snapshot['patient_id'],
      phone: snapshot['phone'],
      dob: snapshot['dob'],
      admin_role: snapshot['admin_role'] ?? false, // Default to false if not present
    );
  }
}