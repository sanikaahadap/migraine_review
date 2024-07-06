import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'migraine_log_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MigraineLogsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Migraine Logs List', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF16666B),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('migraine_logs').orderBy('timestamp', descending: true).snapshots(),
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
                    'Migraine Log - ${timestamp.day}/${timestamp.month}/${timestamp.year}',
                    style: const TextStyle(color: Color(0xFF16666B)),
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
