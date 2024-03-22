import "package:flutter/material.dart";
import "package:neurooooo/ehr.dart";
import "package:neurooooo/ehr_record.dart";

class ehrmainpg extends StatelessWidget {
  const ehrmainpg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ehrrec()),
                );
              },
              child: Text('Go to Page One'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EHRPage()),
                );
              },
              child: Text('Go to Page Two'),
            ),
          ],
        ),
      ),
    );
  }
}
