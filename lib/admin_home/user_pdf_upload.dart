import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../main_features/ehr/pdf_upload.dart';

class PatientDoc extends StatefulWidget {
  final String uid;

  const PatientDoc({Key? key, required this.uid}) : super(key: key);

  @override
  State<PatientDoc> createState() => _PatientDocState();
}

class _PatientDocState extends State<PatientDoc> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> pdfData = [];

  void getAllPdf() async {
    final results = await _firebaseFirestore
        .collection("docs")
        .where('uid', isEqualTo: widget.uid)
        .get();
    pdfData = results.docs.map((e) => e.data()).toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAllPdf();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: pdfData.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PDFViewerScreen(
                    pdfurl: pdfData[index]['download_url'],
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/images/pdf.png",
                    height: 120,
                    width: 100,
                  ),
                  Text(
                    pdfData[index]['pdf_name'],
                    style: const TextStyle(fontSize: 10),
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
