import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetScore extends StatelessWidget {
  final String docID;
  const GetScore({super.key, required this.docID});

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('midas_scores');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(docID).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null || !snapshot.data!.exists) {
            // If document doesn't exist or is null, return an empty widget
            return const SizedBox.shrink();
          }

          // Here we safely access the data
          Map<String, dynamic>? data =
              snapshot.data!.data() as Map<String, dynamic>?;

          if (data == null || !data.containsKey('score')) {
            // If data or score field doesn't exist, return an empty widget
            return const SizedBox.shrink();
          }

          // Now we safely access the 'score' field
          return Text('Score: ${data['score']}');
        }

        // Default to a loading state
        return const Text('Loading...');
      }),
    );
  }
}
