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

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: scores.where('uid', isEqualTo: currentUserUID).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            // If no scores found for the current user, return a message
            return Center(
              child: Text(
                'No scores found.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              // Access each score document
              Map<String, dynamic> data =
                  (snapshot.data!.docs[index].data() as Map<String, dynamic>);
              String score = data['score'].toString();

              // Access the timestamp and format it to display the date
              Timestamp timestamp = data['timestamp'];
              DateTime dateTime = timestamp.toDate();
              String formattedDate =
                  DateFormat.yMMMd().add_jm().format(dateTime);

              // Return a widget to display the score, day, and date
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(
                    'MIDAS Score: $score',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Recorded on: $formattedDate'),
                  leading: Icon(Icons.score, color: Colors.blue),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
