
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class GetScore extends StatelessWidget {
  const GetScore({super.key});

  @override
  Widget build(BuildContext context) {
    String currentUserUID = FirebaseAuth.instance.currentUser!.uid;

    CollectionReference scores =
    FirebaseFirestore.instance.collection('midas_scores');

    return StreamBuilder<QuerySnapshot>(
      stream: scores.where('uid', isEqualTo: currentUserUID).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          // If no scores found for the current user, return an empty widget
          return const SizedBox.shrink();
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
          // Access each score document
          Map<String, dynamic> data =
          (snapshot.data!.docs[index].data() as Map<String, dynamic>);
          String score = data['score'].toString();

          // Access the timestamp and format it to display the date
          Timestamp timestamp = data['timestamp'];
          DateTime dateTime = timestamp.toDate();
          String formattedDate = DateFormat.yMMMd().add_jm().format(dateTime);

          // Return a widget to display the score, day, and date
          return ListTile(
            title: Text('MIDAS Score: $score'),
            subtitle: Text('Recorded on: $formattedDate'),
            // Add more details if needed
          );
        },
        );
      },
    );
  }
}