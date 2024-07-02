import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:neurooooo/main_features/ehr/ehr_get_scores.dart";
import "package:neurooooo/main_features/ehr/ehr_graph.dart";

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MIDAS Scores"),
      ),
      body: const Center(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 400,
              child: EhrGraphPage(),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: GetScore(),
            )
          ],
        ),
      ),
    );
  }
}
