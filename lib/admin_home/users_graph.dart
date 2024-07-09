import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../main_features/ehr/ehr_graph.dart';

class GraphChart extends StatelessWidget {
  final String uid;

  const GraphChart({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference scores =
        FirebaseFirestore.instance.collection('midas_scores');

    return StreamBuilder<QuerySnapshot>(
      stream: scores.where('uid', isEqualTo: uid).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

        // Get unique dates for the x-axis labels
        final uniqueDates = <DateTime>{};
        final uniqueSpots = <FlSpot>[];

        for (var data in scoreDataList) {
          if (!uniqueDates.contains(data.dateTime)) {
            uniqueDates.add(data.dateTime);
            uniqueSpots.add(FlSpot(
                data.dateTime.millisecondsSinceEpoch.toDouble(), data.score));
          }
        }

        // Calculate the min and max X values with added spacing
        final minX = uniqueSpots.first.x -
            86400000; // Subtracting one day in milliseconds
        final maxX =
            uniqueSpots.last.x + 86400000; // Adding one day in milliseconds

        // Function to get titles for x-axis
        String getXTitles(double value) {
          final dateTime = DateTime.fromMillisecondsSinceEpoch(value.toInt());
          if (uniqueDates.contains(dateTime)) {
            return DateFormat('MMM d').format(dateTime); // Format as Jul 25
          }
          return '';
        }

        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width *
                0.9, // Adjust width as needed
            height: MediaQuery.of(context).size.height *
                0.4, // Adjust height as needed

            padding: const EdgeInsets.all(16.0),
            child: LineChart(
              LineChartData(
                axisTitleData: FlAxisTitleData(
                  leftTitle: AxisTitle(
                    margin: 1,
                    showTitle: true,
                    titleText: 'Scores',
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  bottomTitle: AxisTitle(
                    margin: 0.02,
                    showTitle: true,
                    titleText:
                        'Oldest\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tLatest',
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                titlesData: FlTitlesData(
                  bottomTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 5,
                    margin: 10,
                    getTitles: (value) {
                      return getXTitles(value);
                    },
                    getTextStyles: (BuildContext context, double value) {
                      return const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      );
                    },
                  ),
                  leftTitles: SideTitles(
                    interval: 5,
                    showTitles: true,
                    reservedSize: 40,
                    getTextStyles: (BuildContext context, double value) {
                      return const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      );
                    },
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  drawHorizontalLine: true,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.5),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.5),
                      strokeWidth: 0,
                    );
                  },
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                minX: minX,
                maxX: maxX,
                minY: 0,
                maxY: 30, // Set maximum score value as needed
                lineBarsData: [
                  LineChartBarData(
                    spots: uniqueSpots,
                    isCurved: false,
                    colors: [Color.fromARGB(255, 83, 245, 102)],
                    barWidth: 3,
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(
                      show: false,
                      colors: [const Color(0xFF539BF5).withOpacity(0.3)],
                    ),
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, bar, index) =>
                          FlDotCirclePainter(
                        radius: 6,
                        color: const Color(0xFF539BF5),
                        strokeWidth: 2,
                        strokeColor: Colors.white,
                      ),
                      checkToShowDot: (spot, barData) {
                        // Conditionally show dots for specific spots if needed
                        return true;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
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