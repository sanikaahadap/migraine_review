import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:neurooooo/main_features/ehr/ehr_getscores.dart";
import "package:fl_chart/fl_chart.dart";
import "package:neurooooo/main_features/ehr/ehr_graph.dart";

class Ehrrec extends StatefulWidget {
  const Ehrrec({super.key});

  @override
  State<Ehrrec> createState() => _EhrrecState();
}

class _EhrrecState extends State<Ehrrec> {
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
        title: Text("MIDAS Scores"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 400,
              child:  ScoreLineChart(),
            ),

            const SizedBox(
              height: 30,
            ),
            Expanded(child: GetScore(),)
          ],
        ),
      ),
    );
  }
}
