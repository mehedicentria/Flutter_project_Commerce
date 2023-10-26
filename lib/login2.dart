import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/bottom_nav_pages/home.dart';
import 'package:project/registraion.dart';

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {

  final TextEditingController _emailController = TextEditingController();             // Controller of Email TextField

  final TextEditingController _passwordController = TextEditingController();          // Controller of Password TextField


  signIn() async {                                                                  // Asynchronus SignIn function.This function will check the user id and password
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
      var authCredintial = userCredential.user;
      if(authCredintial!.uid.isNotEmpty) {        // If the user id and password in the DataBase
        Get.off( Home());                         //Then we will go Product Home page . Where we will see the product list
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
          icon: const Icon(Icons.admin_panel_settings_rounded, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          "Invalid",
          "Sorry, wrong password insert",
          icon: const Icon(Icons.admin_panel_settings_rounded, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print(e);
    }





  }

  

  
  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFCB2B93),
            Color(0xFF9546C4),
            Color(0xFF5E61F4),
          ]
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/images/log-in.png')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _emailController,
                textAlign: TextAlign.left,
                style:  TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                decoration:  InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Colors.white70,
                  ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(width: 0, style: BorderStyle.solid)

                    ),
                    labelText: 'Email',
                    labelStyle: const TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _passwordController,
                textAlign: TextAlign.left,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.password_outlined,
                    color: Colors.white70,
                  ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(width: 0, style: BorderStyle.solid)
                    ),
                    labelText: 'Password',
                    labelStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      
                      fontWeight: FontWeight.w600,
                    ),
                    hintText: 'Enter secure password'),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () {
              //    FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
                  signIn();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9F7BFF),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            TextButton(
              onPressed: () {
                Get.off(const Registration_page());
              },
              child: const Text("New User? Sign up"),
            ),
          ],
        ),
      ),
      ),
    );
  }
}