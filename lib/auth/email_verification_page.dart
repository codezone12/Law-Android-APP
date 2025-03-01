import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:law_app/Home/home_page.dart';
import 'package:law_app/components/toaster.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // Start the timer
    timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      try {
        // Reload the user
        await FirebaseAuth.instance.currentUser?.reload();
        var user = FirebaseAuth.instance.currentUser;
        // Check if email is verified
        if (user != null && user.emailVerified ) {
          timer.cancel();
          showToast(message: "Email successfully verified!");
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HomePage()));
        }
      } catch (e) {
        // Handle reload user errors
        showToast(message: "Failed to reload user. Please try again later.");
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Your Email"),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Please verify your email. Check your inbox for a verification link.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
