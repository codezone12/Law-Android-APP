import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:law_app/Home/home_page.dart';
import 'package:law_app/auth/email_verification_page.dart';
import 'package:law_app/auth/login_page.dart';
import 'package:law_app/components/toaster.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting for the stream
            return const Center(
                child: CircularProgressIndicator(color: Color(0xFF11CEC4)));
          } else if (snapshot.hasData) {
            // User is logged in
            User? user = snapshot.data;
            if (user != null) {
              if (!user.emailVerified) {
                // Email is not verified, redirect to verification screen
                return const EmailVerificationPage(); // Make sure to create this widget
              } else {
                // Email is verified, go to home page
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showToast(message: "Login successful!");
                });
                return const HomePage();
              }
            } else {
              // User is null, show an error message or redirect to login
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showToast(message: "User data is null. Please try again.");
              });
              return const Center(child: Text('User data is null.'));
            }
          } else if (snapshot.hasError) {
            // Handle error state
            FirebaseAuthException? authException =
                snapshot.error as FirebaseAuthException?;
            String errorMessage = "An error occurred. Please try again.";

            if (authException != null) {
              switch (authException.code) {
                case 'network-request-failed':
                  errorMessage = "Network issue. Please check your connection.";
                  break;
                case 'wrong-password':
                  errorMessage = "Incorrect credentials. Please try again.";
                  break;
                case 'user-not-found':
                  errorMessage = "User not found. Please sign up.";
                  break;
                default:
                  errorMessage = authException.message ?? errorMessage;
              }
            }

            WidgetsBinding.instance.addPostFrameCallback((_) {
              showToast(message: errorMessage);
            });

            return const Center(child: Text('An error occurred.'));
          } else {
            // User is not logged in, show login page
            return const LoginPage(); // Make sure to create this widget
          }
        },
      ),
    );
  }
}
