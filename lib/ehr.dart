import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:neurooooo/storage_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EHRPage extends StatefulWidget {
  const EHRPage({super.key});

  @override
  State<EHRPage> createState() => _EHRPageState();
}

class _EHRPageState extends State<EHRPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Storage storage = Storage();

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  Future<void> requestPermission() async {
    final permission2 = Permission.photos;
    final permission3 = Permission.camera;
    if (await permission2.isDenied) {
      print("---photos permission---");
      await permission2.request();
    }
    if (await permission3.isDenied) {
      await permission3.request();
    }
  }

  Future<void> _uploadAndSaveToFirestore(String path, String fileName) async {
    // Upload image to Firebase Storage
    final imageUrl = await storage.uploadFile(path, fileName);

    // Get current user
    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;

      // Add data to Firestore
      await _firestore
          .collection('ehr')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        'uid': FirebaseAuth.instance.currentUser?.uid,
        // 'imageUrl': imageUrl as String,
      });

      // return imageUrl; // Return imageUrl after uploading
    } else {
      // No user signed in
      print('No user signed in');
      // return ''; // Return empty string if no user signed in
    }
  }

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();

    return Scaffold(
      appBar: AppBar(
        title: const Text('EHR'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                final results = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  type: FileType.custom,
                  allowedExtensions: ['png', 'jpg'],
                );

                if (results == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No file selected'),
                    ),
                  );
                  return;
                }

                final path = results.files.single.path!;
                final fileName = results.files.single.name;

                storage
                    .uploadFile(path, fileName)
                    .then((value) => print('done'));
              },
              child: Text('Upload File'),
            ),
          ),
          FutureBuilder(
              future: storage.listFiles(),
              builder: (BuildContext context,
                  AsyncSnapshot<firebase_storage.ListResult> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(snapshot.data!.items[index].name),
                            ),
                          );
                        }),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                return Container();
              }),
          FutureBuilder(
              future: storage.downloadURL(''),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Container(
                      width: 300,
                      height: 250,
                      child: Image.network(
                        snapshot.data!,
                        fit: BoxFit.cover,
                      ));
                }
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                return Container();
              })
        ],
      ),
    );
  }
}
