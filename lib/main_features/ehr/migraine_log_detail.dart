import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MigraineLogDetailPage extends StatelessWidget {
  final Map<String, dynamic> log;

  const MigraineLogDetailPage({Key? key, required this.log}) : super(key: key);

  String displayValue(dynamic value) {
    if (value == null) {
      return 'Not available';
    } else if (value == true) {
      return 'Yes';
    } else if (value == false) {
      return 'No';
    } else {
      return value.toString();
    }
  }

  Widget buildDetailCard(String title, String value) {
    return Card(
      color: const Color(0xFFE0F7FA),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Text(
                '$title:',
                // textHeightBehavior: TextHeightBehavior(leadingDistribution: TextLeadingDistribution.proportional),
                style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Color(0xFF16666B)),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              flex: 3,
              child: Text(
                value,
                style: const TextStyle(fontSize: 16.0, color: Color(0xFF16666B)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Migraine Log Detail', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF16666B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDetailCard('Duration Index', log['durationIndex'].toString()),
              buildDetailCard('Pain Severity', log['painSeverity'].toString()),
              buildDetailCard('Character', log['selectedCharacter'].join(', ')),
              buildDetailCard('Severity', log['selectedSeverity'].toString()),
              buildDetailCard('Difficulty in Work', displayValue(log['difficultyInWork'])),
              buildDetailCard('Nausea', displayValue(log['nausea'])),
              buildDetailCard('Vomiting', displayValue(log['vomiting'])),
              buildDetailCard('Photophobia', displayValue(log['photophobia'])),
              buildDetailCard('Phonophobia', displayValue(log['phonophobia'])),
              buildDetailCard('Osmophobia', displayValue(log['osmophobia'])),
              buildDetailCard('Blurring of Vision', displayValue(log['blurringOfVision'])),
              buildDetailCard('CT/MRI Scan', displayValue(log['ctMriScan'])),
              buildDetailCard('Pain Killers per Month', log['painKillersPerMonth'].toString()),
              buildDetailCard('Months of Painkiller Use', log['monthsOfPainkillerUse'].toString()),
              buildDetailCard('Timestamp', (log['timestamp'] as Timestamp).toDate().toString()),
            ],
          ),
        ),
      ),
    );
  }
}