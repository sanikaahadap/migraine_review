import 'package:cloud_firestore/cloud_firestore.dart';

class ModelUser
{
  final String email;
  final String username;
  final String uid;
  ModelUser({required this.email,required this.username,required this.uid});

  Map<String,dynamic> toJson()=>
      {
        'email': email,
        'username': username,
        'uid':uid

      };

  static ModelUser fromSnap(DocumentSnapshot snap)
  {
    var snapshot=snap.data() as Map<String,dynamic>;

    return ModelUser(email: snapshot['email'], username: snapshot['name'], uid: snapshot['patient_id']);
  }
}
