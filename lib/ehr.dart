import 'package:flutter/material.dart';

class EHRPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EHR'),
      ),
      body: Center(
        child: Text(
          'No records to show',
          style: TextStyle(
            fontSize: 20,
            color: Color(0xFF16666B), // Theme color #16666B
          ),
        ),
      ),
    );
  }
}
