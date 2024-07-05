import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';

class EhrGraphPage extends StatelessWidget {
  const EhrGraphPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserUID = FirebaseAuth.instance.currentUser!.uid;
    final CollectionReference scores =
        FirebaseFirestore.instance.collection('midas_scores');

    return StreamBuilder<QuerySnapshot>(
      stream: scores.where('uid', isEqualTo: currentUserUID).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final scoreDocs = snapshot.data!.docs;
        if (scoreDocs.isEmpty) {
          return const Center(child: Text('No scores available'));
        }

        final scoreDataList = scoreDocs
            .map((doc) => ScoreData(
                  DateTime.fromMillisecondsSinceEpoch(
                      doc['timestamp'].millisecondsSinceEpoch),
                  doc['score'].toDouble(),
                ))
            .toList();

        scoreDataList.sort((a, b) => a.dateTime.compareTo(b.dateTime));

        final spots = scoreDataList
            .map((data) => FlSpot(
                data.dateTime.millisecondsSinceEpoch.toDouble(), data.score))
            .toList();

        // Get the minimum and maximum dates for x-axis
        final minDate = scoreDataList.first.dateTime;
        final maxDate = scoreDataList.last.dateTime;

// Function to get titles for x-axis
        String getXTitles(double value) {
          final dateTime = DateTime.fromMillisecondsSinceEpoch(value.toInt());
          if (dateTime.isBefore(minDate) || dateTime.isAfter(maxDate)) {
            return ''; // Return empty string for dates outside the range
          }
          return DateFormat('MMM d').format(dateTime); // Format dates
        }

        return Center(
          child: Container(
              width: MediaQuery.of(context).size.width *
                  0.8, // Adjust width as needed
              height: MediaQuery.of(context).size.height *
                  0.4, // Adjust height as needed
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(16.0),
              child: LineChart(
                LineChartData(
                  axisTitleData: FlAxisTitleData(
                    leftTitle: AxisTitle(
                      margin: 15,
                      showTitle: true,
                      titleText: 'Scores',
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    bottomTitle: AxisTitle(
                      margin: 1,
                      showTitle: true,
                      titleText: 'Date',
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 10,
                      margin: 10,
                      getTitles: (value) {
                        // Here we determine which titles to show based on the value
                        // This is a simple example; adjust logic as needed
                        int index = value.toInt();
                        if (index % 5 == 0) {
                          // Show titles for every 5th index
                          return DateFormat('MM/dd').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  value.toInt()));
                        }
                        return '';
                      },
                      getTextStyles: (BuildContext context, double value) {
                        return const TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                        );
                      },
                    ),
                    leftTitles: SideTitles(
                      interval: 5,
                      showTitles: true,
                      reservedSize: 10,
                      getTextStyles: (BuildContext context, double value) {
                        return const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        );
                      },
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  minX: scoreDataList.first.dateTime.millisecondsSinceEpoch
                      .toDouble(),
                  maxX: scoreDataList.last.dateTime.millisecondsSinceEpoch
                      .toDouble(),
                  minY: 0,
                  maxY: 30, // Set maximum score value as needed
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: false,
                      colors: [const Color.fromARGB(255, 85, 190, 83)],
                      barWidth: 4,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}

class ScoreData {
  final DateTime dateTime;
  final double score;

  ScoreData(this.dateTime, this.score);
}
