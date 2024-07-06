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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Migraine Log Detail', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF16666B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: const Color(0xFFE0F7FA),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Duration Index: ${log['durationIndex']}', style: const TextStyle(fontSize: 16.0, color: Color(0xFF16666B))),
                  const SizedBox(height: 8.0),
                  Text('Pain Severity: ${log['painSeverity']}', style: const TextStyle(fontSize: 16.0, color: Color(0xFF16666B))),
                  const SizedBox(height: 8.0),
                  // Text('Location: ${log['selectedLocation']}'),
                  Text('Character: ${log['selectedCharacter'].join(', ')}', style: const TextStyle(fontSize: 16.0, color: Color(0xFF16666B))),
                  const SizedBox(height: 8.0),
                  Text('Severity: ${log['selectedSeverity']}', style: const TextStyle(fontSize: 16.0, color: Color(0xFF16666B))),
                  const SizedBox(height: 8.0),
                  Text('Difficulty in Work: ${displayValue(log['difficultyInWork'])}', style: const TextStyle(fontSize: 16.0, color: Color(0xFF16666B))),
                  const SizedBox(height: 8.0),
                  Text('Nausea: ${displayValue(log['nausea'])}', style: const TextStyle(fontSize: 16.0, color: Color(0xFF16666B))),
                  const SizedBox(height: 8.0),
                  Text('Vomiting: ${displayValue(log['vomiting'])}', style: const TextStyle(fontSize: 16.0, color: Color(0xFF16666B))),
                  const SizedBox(height: 8.0),
                  Text('Photophobia: ${displayValue(log['photophobia'])}', style: const TextStyle(fontSize: 16.0, color: Color(0xFF16666B))),
                  const SizedBox(height: 8.0),
                  Text('Phonophobia: ${displayValue(log['phonophobia'])}', style: const TextStyle(fontSize: 16.0, color: Color(0xFF16666B))),
                  const SizedBox(height: 8.0),
                  Text('Osmophobia: ${displayValue(log['osmophobia'])}', style: const TextStyle(fontSize: 16.0, color: Color(0xFF16666B))),
                  const SizedBox(height: 8.0),
                  Text('Blurring of Vision: ${displayValue(log['blurringOfVision'])}', style: const TextStyle(fontSize: 16.0, color: Color(0xFF16666B))),
                  const SizedBox(height: 8.0),
                  Text('CT/MRI Scan: ${displayValue(log['ctMriScan'])}', style: const TextStyle(fontSize: 16.0, color: Color(0xFF16666B))),
                  const SizedBox(height: 8.0),
                  Text('Pain Killers per Month: ${log['painKillersPerMonth']}', style: const TextStyle(fontSize: 16.0, color: Color(0xFF16666B))),
                  const SizedBox(height: 8.0),
                  Text('Months of Painkiller Use: ${log['monthsOfPainkillerUse']}', style: const TextStyle(fontSize: 16.0, color: Color(0xFF16666B))),
                  const SizedBox(height: 8.0),
                  Text('Timestamp: ${(log['timestamp'] as Timestamp).toDate()}', style: const TextStyle(fontSize: 16.0, color: Color(0xFF16666B))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
