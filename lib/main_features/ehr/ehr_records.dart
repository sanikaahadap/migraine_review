import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:neurooooo/main_features/ehr/ehr_get_scores.dart';
import 'package:neurooooo/main_features/ehr/ehr_graph.dart';

class EhrRecordsPage extends StatefulWidget {
  const EhrRecordsPage({super.key});

  @override
  State<EhrRecordsPage> createState() => _EhrRecordsPageState();
}

class _EhrRecordsPageState extends State<EhrRecordsPage> {
  List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('midas_scores')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              docIDs.add(document.reference.id);
            }));
  }

  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff16666b), // Custom theme color
          title: const Text('MIDAS Scores Information',
              style: TextStyle(color: Colors.white)),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MIDAS scores provide a measure of migraine disability. The scores help to understand the impact of migraines on daily activities. Higher scores indicate greater disability.',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  'Score Ranges:',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  '0-5: Little or no disability',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '6-10: Mild disability',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '11-20: Moderate disability',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '21+: Severe disability',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  'Disclaimer:',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  'MIDAS scores are not an accurate measure of a patient\'s migraine levels. They are a preliminary score, and patients must consult their professional neurologist for a perfect diagnosis.',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MIDAS Scores'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showInfoDialog,
          ),
        ],
      ),
      body: const Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            EhrGraphPage(),
            Expanded(
              child: GetScore(),
            )
          ],
        ),
      ),
    );
  }
}
