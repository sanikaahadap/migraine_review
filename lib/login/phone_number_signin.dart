import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'verify_otp.dart';

class SignInWithPhone extends StatefulWidget {
  const SignInWithPhone({Key? key}) : super(key: key);

  @override
  State<SignInWithPhone> createState() => _SignInWithPhoneState();
}

class _SignInWithPhoneState extends State<SignInWithPhone> {
  TextEditingController phoneController = TextEditingController();

  void sendOTP() async {
    String phone = "+91" + phoneController.text.trim();

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        codeSent: (verificationId, resendToken) {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => VerifyOtpScreen(
                        verificationId: verificationId,
                      )));
        },
        verificationCompleted: (credential) {},
        verificationFailed: (ex) {
          print(ex.code.toString());
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        timeout: Duration(seconds: 30));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0),
              // Logo image
              Image.asset(
                'assets/images/logo.png',
                height: MediaQuery.of(context).size.height * 0.15,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 40.0),

              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color(0x80B2EBF2),
                  contentPadding: EdgeInsets.all(12.0),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: sendOTP,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 170.0,
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF16666B),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Center(
                    child: Text(
                      "Login In",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
