import 'package:flutter/material.dart';


class MigraineLogsPage extends StatefulWidget {
  @override
  _MigraineLogsPageState createState() => _MigraineLogsPageState();
}

class _MigraineLogsPageState extends State<MigraineLogsPage> {
  List<String> migraineLogs = [
    "Migraine log 1",
    "Migraine log 2",
    "Migraine log 3",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Migraine Logs'),
      ),
      body: ListView.builder(
        itemCount: migraineLogs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(migraineLogs[index]),
          );
        },
      ),
    );
  }
}
