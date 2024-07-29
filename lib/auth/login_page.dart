import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:law_app/Home/home_page.dart';
import 'package:law_app/auth/authProviders/googleAuth.dart';
import 'package:law_app/auth/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool loading = false;
  bool _isPasswordVisible = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form?.validate() ?? false) {
      form?.save();
      return true;
    }
    return false;
  }

  Future<void> loginWithEmailPassword() async {
    if (validateAndSave()) {
      setState(() {
        loading = true;
      });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Check if email is verified
        final user = FirebaseAuth.instance.currentUser;
        if (user != null && user.emailVerified) {
          // Navigate to next screen or show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login Successful! Welcome')),
          );

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        } else {
          // Show message to verify email
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Please verify your email to log in.'),
                backgroundColor: Colors.red),
          );

          // Optionally, resend verification email
          try {
            await user?.sendEmailVerification();
          } catch (e) {
            // Handle errors specifically from sendEmailVerification
            // Optionally, log this error or show a specific message
          }
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'An error occurred. Please try again.';
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'An unexpected error occurred. Please check credientials and try again.'),
              backgroundColor: Colors.red),
        );
      } finally {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // text + image
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //text
                  const Flexible(
                    child: Text(
                      'Already have an Account?',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // image

                  Image.asset('assets/images/login.png',
                      height: 200, width: 200),
                ],
              ),
            ),

            // input fields

            const SizedBox(
              height: 20,
            ),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF11CEC4))),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF11CEC4))),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Color(0xFF11CEC4)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email field cannot be empty';
                        }
                        final emailRegex = RegExp(
                            r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Invalid Email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF11CEC4))),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF11CEC4))),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: const Color(0xFF11CEC4),
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Color(0xFF11CEC4)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password field cannot be empty';
                        }
                        if (value.length < 8) {
                          return 'Password length should be greater than 8 characters';
                        }
                        return null;
                      },
                    ),
                  ),

                  // login button

                  const SizedBox(
                    height: 20,
                  ),

                  loading
                      ? const CircularProgressIndicator(
                          color: Color(0xFF11CEC4))
                      : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              loginWithEmailPassword();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF11CEC4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 110, vertical: 15),
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                ],
              ),
            ),

            // new user, register now cliclable text

            const SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const SignupPage()));
                    Navigator.of(context).push(_createRoute());
                  },
                  child: const Text(
                    'New User? Register Now',
                    style: TextStyle(color: Color(0xFF11CEC4)),
                  ),
                ),
              ],
            ),

            // other login options, google and linkedin providers

            const SizedBox(
              height: 20,
            ),

            const Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'use other method',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          signInWithGoogle(context);
                        },
                        child: Image.asset('assets/images/google.png',
                            height: 50, width: 50),
                      ),
                      // const SizedBox(
                      //   width: 20,
                      // ),
                      // Image.asset(
                      //   'assets/images/linkedin.png',
                      //   height: 50,
                      //   width: 50,
                      // ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const SignupPage()));
                    Navigator.of(context).push(_createRoute());
                  },
                  child: Container(
                    height: 100,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xFF11CEC4),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100),
                          bottomLeft: Radius.circular(100)),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SignupPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
