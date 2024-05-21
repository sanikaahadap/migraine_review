import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:neurooooo/admin_home/admin_home.dart';
import 'package:neurooooo/admin_home/user_pdf_upload.dart';
import 'package:neurooooo/admin_home/users_graph.dart';
import 'package:neurooooo/main_features/ehr/ehr_graph.dart';

class UserDetailsPage extends StatelessWidget {
  final ModelUser user;

  UserDetailsPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details: ${user.name}'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('Patient Details'),
          _buildDetailItem('Name', user.name),
          _buildDetailItem('Email', user.email),

          SizedBox(height: 20),

          _buildSectionTitle('EHR Scores'),
          _buildEhrScores(user.uid), // Display EHR scores

          SizedBox(height: 20),

          GraphChart(uid: user.uid),

          _buildSectionTitle('Patient Documents'),
          
          //PatientDoc(uid: user.uid)
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(value.isNotEmpty ? value : 'N/A'),
    );
  }

  Widget _buildEhrScores(String uid) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('midas_scores').where('uid', isEqualTo: uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No scores available'));
        }

        List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: documents.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;

            double score = data['score']?.toDouble() ?? 0.0; // Provide a default value if score is null
            Timestamp timestamp = data['timestamp'] as Timestamp; // Ensure timestamp is cast correctly
            DateTime dateTime = timestamp.toDate();
            String formattedDate = DateFormat.yMMMd().add_jm().format(dateTime);

            return ListTile(
              title: Text('MIDAS Score: $score'),
              subtitle: Text('Recorded on: $formattedDate'),
            );
          },
        );
      },
    );
  }
}