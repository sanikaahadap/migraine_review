import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:neurooooo/main_features/ehr/ehr_getscores.dart";
import "package:fl_chart/fl_chart.dart";

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
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              height: 30,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  titlesData: const FlTitlesData(show: true),
                  borderData: FlBorderData(show: true),
                  minX: 0,
                  maxX: 35,
                  minY: 0,
                  maxY: 40,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 3),
                        const FlSpot(1, 1),
                        const FlSpot(2, 4),
                        const FlSpot(3, 2),
                        const FlSpot(4, 5),
                        const FlSpot(10, 3),
                      ],
                      isCurved: false,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
                child: FutureBuilder(
                    future: getDocId(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                          itemCount: docIDs.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: GetScore(
                                docID: docIDs[index],
                              ),
                            );
                          });
                    }))
          ],
        ),
      ),
    );
  }
}
