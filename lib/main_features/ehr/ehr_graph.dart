/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';

class ScoreData {
  final DateTime dateTime;
  final double score;

  ScoreData(this.dateTime, this.score);
}

class ScoreLineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String currentUserUID = FirebaseAuth.instance.currentUser!.uid;

    CollectionReference scores =
    FirebaseFirestore.instance.collection('midas_scores');

    return StreamBuilder<QuerySnapshot>(
      stream: scores.where('uid', isEqualTo: currentUserUID).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          // If no scores found for the current user, return an empty widget
          return Center(child: Text('No scores available'));
        }

        // Create a list to store score data
        List<ScoreData> scoreDataList = [];

        // Populate score data list from Firestore documents
        snapshot.data!.docs.forEach((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          double score = data['score'].toDouble();
          Timestamp timestamp = data['timestamp'];
          DateTime dateTime = timestamp.toDate();
          scoreDataList.add(ScoreData(dateTime, score));
        });

        // Sort the score data list by timestamp
        scoreDataList.sort((a, b) => a.dateTime.compareTo(b.dateTime));

        // Create a list of FlSpot objects for line chart
        List<FlSpot> spots = scoreDataList
            .map((data) =>
            FlSpot(data.dateTime.millisecondsSinceEpoch.toDouble(), data.score))
            .toList();

        return Padding(
          padding: EdgeInsets.all(16.0),
          child: LineChart(
            LineChartData(
              titlesData:FlTitlesData(
                bottomTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 22,
                  margin: 10,
                  getTitles: (value) {
                    return DateFormat('MMM d').format(DateTime.fromMillisecondsSinceEpoch(value.toInt()));
                  },
                  getTextStyles: (value) => const TextStyle(color: Colors.black, fontSize: 12),
                  getTitles: (value) {
                    return DateFormat('MMM d').format(DateTime.fromMillisecondsSinceEpoch(value.toInt()));
                  },
                ),
                leftTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (value) => const TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              borderData: FlBorderData(show: true),
              minX: scoreDataList.first.dateTime.millisecondsSinceEpoch.toDouble(),
              maxX: scoreDataList.last.dateTime.millisecondsSinceEpoch.toDouble(),
              minY: 0,
              maxY: 100, // Set maximum score value as needed
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  colors: [Colors.blue],
                  barWidth: 4,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}*/
