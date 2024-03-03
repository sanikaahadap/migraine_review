import 'package:cloud_firestore/cloud_firestore.dart';

class ModelUser
{
  final String email;
  final String name;
  final String uid;
  final String patient_id;
  final String phone;
  final String dob;

  ModelUser({required this.email,required this.name,required this.uid, required this.patient_id, required this.phone, required this.dob});

  Map<String,dynamic> toJson()=>
      {
        'email': email,
        'name': name,
        'uid':uid,
        'patient_id': patient_id,
        'phone': phone,
        'dob': dob,
      };

  static ModelUser fromSnap(DocumentSnapshot snap)
  {
    var snapshot=snap.data() as Map<String,dynamic>;

    return ModelUser(
        email: snapshot['email'],
        name: snapshot['name'],
        uid: snapshot['patient_id'],
        phone : snapshot['email'],
        dob: snapshot['dob'],
        patient_id: snapshot['patient_id']

    );
  }
}
