import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:project/bottom_nav_pages/home.dart';
import 'package:project/registraion.dart';

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  final TextEditingController _emailController =
      TextEditingController(); // Controller of Email TextField

  final TextEditingController _passwordController =
      TextEditingController(); // Controller of Password TextField

  signIn() async {
    // Asynchronus SignIn function.This function will check the user id and password
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      var authCredintial = userCredential.user;
      if (authCredintial!.uid.isNotEmpty) {
        // If the user id and password in the DataBase
        Get.off(
            Home()); //Then we will go Product Home page . Where we will see the product list
      } else {
        Get.snackbar(
          "Something Wrong",
          "Sorry Something is going wrong",
          icon: const Icon(Icons.sms_failed, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          "Invalid",
          "Sorry, User Not Found",
          icon: const Icon(Icons.admin_panel_settings_rounded,
              color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          "Invalid",
          "Sorry, wrong password insert",
          icon: const Icon(Icons.admin_panel_settings_rounded,
              color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Something Wrong",
        "Sorry Something is going wrong",
        icon: const Icon(Icons.sms_failed, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Ionicons.logo_google,
                    size: 100,
                  ),
                  const SizedBox(height: 25),
                  Text("Hello Again",
                      style: GoogleFonts.bebasNeue(
                        fontSize: 52,
                      )),
                  const SizedBox(height: 10),
                  Text("Welcome back, you've been missed",
                      style: GoogleFonts.lobster(fontSize: 20)),
                  const SizedBox(height: 20),
          
                  // Email TextField Start
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25), // padding for left right space
                    child: Container(
                      padding: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
          
                  // Password TextField Start
          
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "password",
                        ),
                        obscureText: true,
                      ),
                    ),
                  ),
          
                  const SizedBox(height: 20),
                  // Sign in Button Start
          
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: GestureDetector(
                      onTap: () {
                        signIn();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blue,
                        ),
                        child: const Center(
                          child: Text("sign in",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
          
                  const SizedBox(height: 25),
          
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Not a Member?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.off(const Registration_page());
                        },
                        child: const Text(
                          "Register Now",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
