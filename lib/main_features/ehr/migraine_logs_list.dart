import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'migraine_log_detail.dart';

class MigraineLogsListPage extends StatelessWidget {
  const MigraineLogsListPage({Key? key});

  @override
  Widget build(BuildContext context) {
    // Get the current user's ID
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Migraine Logs List', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF16666B),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // Modify the query to filter logs by user ID
        stream: FirebaseFirestore.instance
            .collection('migraine_logs')
            .where('uid', isEqualTo: userId)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final logs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index].data() as Map<String, dynamic>;
              final timestamp = (log['timestamp'] as Timestamp).toDate();

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                color: const Color(0xFFE0F7FA),
                child: ListTile(
                  title: Text(
                    '${timestamp.day}/${timestamp.month}/${timestamp.year}',
                    style: const TextStyle(
                      color: Color(0xFF16666B),
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward, color: Color(0xFF16666B)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MigraineLogDetailPage(log: log),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
