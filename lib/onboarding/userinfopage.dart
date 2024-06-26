import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:neurooooo/login/login.dart';
import 'package:neurooooo/login/signup.dart';
// import 'package:neurooooo/user_home/nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
                const Text(
                  'What is your gender?',
                  style: TextStyle(
                    color: Color(0xFF16666B), // Text color
                  ),
                ),
                const SizedBox(height: 8), // Adding some space between text and text field
                TextFormField(
                  controller: genderController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF16666B)), // Border color when focused
                    ),
                  ),
                  maxLines: null,
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Do you have any existing medical conditions? If yes, please specify.',
                  style: TextStyle(
                    color: Color(0xFF16666B), // Text color
                  ),
                ),
                const SizedBox(height: 8), // Adding some space between text and text field
                TextFormField(
                  controller: medicalConditionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF16666B)), // Border color when focused
                    ),
                  ),
                  maxLines: null,
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'List any current medications you are taking (prescription or over-the-counter).',
                  style: TextStyle(
                    color: Color(0xFF16666B), // Text color
                  ),
                ),
                const SizedBox(height: 8), // Adding some space between text and text field
                TextFormField(
                  controller: medicationsController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF16666B)), // Border color when focused
                    ),
                  ),
                  maxLines: null,
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Have you had any surgeries or hospitalizations in the past? If yes, please provide details.',
                  style: TextStyle(
                    color: Color(0xFF16666B), // Text color
                  ),
                ),
                const SizedBox(height: 8), // Adding some space between text and text field
                TextFormField(
                  controller: surgeriesController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF16666B)), // Border color when focused
                    ),
                  ),
                  maxLines: null,
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
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
                      }).then((value) {
                        // Navigate to the next page after storing data
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BackToLogin()),
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
                  // Styling for the button
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF16666B)), // Button background color
                    elevation: MaterialStateProperty.all<double>(2), // Elevation of the button
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Button border radius
                      ),
                    ),
                  ),
                  child: const Text('Proceed', style: TextStyle(color: Colors.white)),
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

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning, // Choose the appropriate icon
                  color: Color(0xFF16666B),
                  size: 30.0,
                ),
                SizedBox(width: 8.0), // Add some space between the icon and text
                Text(
                  'Disclaimer',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF16666B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'The app is designed to help you keep track of your headache and coordinate with your physician. Your data will be kept confidential. It will be accessible to no one except you and your doctor.',
                style: TextStyle(
                  color: Color(0xFF16666B),
                  fontSize: 15.0,
                ),
                textAlign: TextAlign.center, // Center the text
              ),
            ),
            const SizedBox(height: 70.0),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16666B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: const Text('Proceed'),
            ),
          ],
        ),
      ),

    );
  }
}


class BackToLogin extends StatelessWidget {
  const BackToLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF16666B),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Account created successfully, please log in again',
                style: TextStyle(
                  color: Color(0xFF16666B),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  ); // Implement navigation to login page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16666B),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                child: const Text(
                  'Back to Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
