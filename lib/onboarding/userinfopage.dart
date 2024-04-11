import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:neurooooo/plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFF16666B), // Set the cursor color to #16666B
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF16666B), // Set the button background color to #16666B
          ),
        ),
      ),
      home: const UserInfoPage(),
    );
  }
}

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});


  @override
  UserInfoPageState createState() => UserInfoPageState();
}

class UserInfoPageState extends State<UserInfoPage> {
  final TextEditingController genderController = TextEditingController();
  final TextEditingController medicalConditionController = TextEditingController();
  final TextEditingController medicationsController = TextEditingController();
  final TextEditingController surgeriesController = TextEditingController();
  final TextEditingController emergencyContactNameController = TextEditingController();
  final TextEditingController relationshipController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();

  // late String patientId = ''; // Variable to store patient_id
  //
  // @override
  // void initState() {
  //   super.initState();
  //   fetchPatientId(); // Fetch patient_id when the page initializes
  // }
  //
  // void fetchPatientId() async {
  //   String? uid = FirebaseAuth.instance.currentUser?.uid;
  //   if (uid != null) {
  //     try {
  //       DocumentSnapshot userInfoDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  //       if (userInfoDoc.exists) {
  //         setState(() {
  //           patientId = userInfoDoc['patient_id'];
  //           log('Fetched patientId: $patientId'); // Add this for debugging
  //         });
  //       }
  //     } catch (e) {
  //       log("Error fetching patient_id: $e");
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
    ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Tell us about yourself',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF16666B), // Text color similar to features page
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16.0),
                TextFormField(
                  controller: genderController,
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    labelStyle: TextStyle(
                      color: Color(0xFF16666B), // Text color when not focused
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF16666B)), // Border color when focused
                    ),
                  ),
                  maxLines: null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: medicalConditionController,
                  decoration: const InputDecoration(
                    labelText: 'Do you have any existing medical conditions? If yes, please specify',
                    labelStyle: TextStyle(
                      color: Color(0xFF16666B), // Text color when not focused
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF16666B)), // Border color when focused
                    ),
                  ),
                  maxLines: null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: medicationsController,
                  decoration: const InputDecoration(
                    labelText: 'List any current medications you are taking (prescription or over-the-counter)',
                    labelStyle: TextStyle(
                      color: Color(0xFF16666B), // Text color when not focused
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF16666B)), // Border color when focused
                    ),
                  ),
                  maxLines: null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: surgeriesController,
                  decoration: const InputDecoration(
                    labelText: 'Have you had any surgeries or hospitalizations in the past? If yes, please provide details',
                    labelStyle: TextStyle(
                      color: Color(0xFF16666B), // Text color when not focused
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF16666B)), // Border color when focused
                    ),
                  ),
                  maxLines: null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: emergencyContactNameController,
                  decoration: const InputDecoration(
                    labelText: 'Emergency Contact Name',
                    labelStyle: TextStyle(
                      color: Color(0xFF16666B), // Text color when not focused
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF16666B)), // Border color when focused
                    ),
                  ),
                  maxLines: null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: relationshipController,
                  decoration: const InputDecoration(
                    labelText: 'Relationship',
                    labelStyle: TextStyle(
                      color: Color(0xFF16666B), // Text color when not focused
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF16666B)), // Border color when focused
                    ),
                  ),
                  maxLines: null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: contactNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Contact No.',
                    labelStyle: TextStyle(
                      color: Color(0xFF16666B), // Text color when not focused
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF16666B)), // Border color when focused
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  maxLines: null,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DisclaimerPage()),
                    );
                  },
                  // child: const Text('Proceed'),
                  // ElevatedButton for submitting the form
                  child : ElevatedButton(
                    onPressed: () {
                      String? uid = FirebaseAuth.instance.currentUser?.uid;

                      if (uid != null) {
                        // Store data in Firestore
                        FirebaseFirestore.instance.collection('user_info').doc(FirebaseAuth.instance.currentUser?.uid).set({
                          'uid': FirebaseAuth.instance.currentUser?.uid,
                          'gender': genderController.text,
                          'medicalCondition': medicalConditionController.text,
                          'medications': medicationsController.text,
                          'surgeries': surgeriesController.text,
                          'emergencyContactName': emergencyContactNameController.text,
                          'relationship': relationshipController.text,
                          'contactNumber': contactNumberController.text,
                        }).then((value) {
                          // Navigate to the next page after storing data
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DisclaimerPage()),
                          );
                        }).catchError((error) {
                          // Handle errors if any
                          log("Failed to add user information: $error");
                          // You might want to show a snackbar or dialog to inform the user about the failure
                        });
                      } else {
                        // Handle the case when the user is not authenticated
                        log("User is not authenticated.");
                      }
                    },
                    child: const Text('Proceed'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DisclaimerPage extends StatelessWidget {
  const DisclaimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Disclaimer',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF16666B),
              ),
            ),
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
              child: Text(
                'The app is designed to help you keep track of your headache and coordinate with your physician. Your data will be kept confidential',
                style: TextStyle(
                  color: Color(0xFF16666B),
                  fontSize: 15.0,
                ),
              ),
            ),


            const SizedBox(height: 170.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuestionnairePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16666B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: const Text('Accept'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuestionnairePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16666B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: const Text('Decline'),
            ),
          ],
        ),
      ),
    );
  }
}
